import 'package:authpass_cloud_backend/src/dao/tables/user_tables.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:openapi_base/openapi_base.dart';
import 'package:postgres_utils/postgres_utils.dart';
import 'package:quiver/check.dart';
import 'package:quiver/core.dart';

final _logger = Logger('email_tables');

class EmailTable extends TableBase with TableConstants {
  EmailTable({required this.cryptoService});

  static const _TABLE_EMAIL_MAILBOX = 'email_mailbox';
  static const _TABLE_EMAIL_MESSAGE = 'email_message';
  static const COLUMN_USER_ID = UserTable.COLUMN_USER_ID;
  static const _COLUMN_LABEL = 'label';
  static const SUBJECT_MAX_LENGTH = 200;

  /// client provided uuid so the client can match the mailbox with a
  /// password entry.
  static const _COLUMN_CLIENT_ENTRY_UUID = 'client_entry_uuid';
  static const _COLUMN_ADDRESS = 'address';
  static const _COLUMN_MAILBOX_ID = 'mailbox_id';
  static const _COLUMN_SUBJECT = 'subject';

  /// message body (header + body) of the email.
  static const _COLUMN_MESSAGE = 'message';
  static const _COLUMN_SIZE = 'size';
  static const _COLUMN_SENDER = 'sender';
  static const _COLUMN_READ_AT = 'read_at';
  static const _COLUMN_DELETED_AT = 'deleted_at';
  static const _COLUMN_DISABLED_AT = 'disabled_at';
  static const _COLUMN_HIDDEN_AT = 'hidden_at';

  final CryptoService cryptoService;

  @override
  List<String> get tables => [
        _TABLE_EMAIL_MAILBOX,
        _TABLE_EMAIL_MESSAGE,
      ];

  Future<void> createTables(DatabaseTransactionBase db) async {
    await db.execute('''
    CREATE TABLE $_TABLE_EMAIL_MAILBOX (
      $specColumnIdPrimaryKey,
      $_COLUMN_ADDRESS varchar not null unique,
      $_COLUMN_LABEL varchar not null,
      $_COLUMN_CLIENT_ENTRY_UUID varchar not null,
      $COLUMN_USER_ID uuid not null 
        REFERENCES ${UserTable.TABLE_USER} ($columnId),
      $specColumnCreatedAt
    );
    CREATE INDEX mailbox_address ON $_TABLE_EMAIL_MAILBOX ($_COLUMN_ADDRESS);
    
    CREATE TABLE $_TABLE_EMAIL_MESSAGE (
      $specColumnIdPrimaryKey,
      $_COLUMN_MAILBOX_ID uuid not null
        REFERENCES $_TABLE_EMAIL_MAILBOX ($columnId),
      $_COLUMN_MESSAGE TEXT not null,
      $_COLUMN_SIZE INTEGER not null,
      $_COLUMN_SENDER VARCHAR not null,
      $_COLUMN_SUBJECT VARCHAR($SUBJECT_MAX_LENGTH) not null,
      $_COLUMN_READ_AT $typeTimestamp,
      $specColumnCreatedAt
    );
    ''');
  }

  Future<void> migrate4(DatabaseTransactionBase db) async {
    await db.execute('''
    ALTER TABLE $_TABLE_EMAIL_MESSAGE ADD COLUMN $_COLUMN_DELETED_AT $typeTimestamp
    ''');
  }

  Future<void> migrate5(DatabaseTransactionBase db) async {
    await db.execute('''
    ALTER TABLE $_TABLE_EMAIL_MAILBOX ADD COLUMN $_COLUMN_DELETED_AT $typeTimestamp;
    ALTER TABLE $_TABLE_EMAIL_MAILBOX ADD COLUMN $_COLUMN_DISABLED_AT $typeTimestamp;
    ALTER TABLE $_TABLE_EMAIL_MAILBOX ADD COLUMN $_COLUMN_HIDDEN_AT $typeTimestamp;
    ''');
  }

  Future<void> insertMailbox(
    DatabaseTransactionBase db, {
    required UserEntity userEntity,
    required String label,
    required String address,
    required String clientEntryUuid,
  }) async {
    checkArgument(address.contains('@'),
        message: () => 'Address must be a full email address. {$address}');

    final id = cryptoService.createSecureUuid();

    await db.executeInsert(_TABLE_EMAIL_MAILBOX, {
      columnId: id,
      COLUMN_USER_ID: userEntity.id,
      _COLUMN_ADDRESS: address,
      _COLUMN_LABEL: label,
      _COLUMN_CLIENT_ENTRY_UUID: clientEntryUuid,
    });
  }

  Future<void> updateMailbox(
    DatabaseTransactionBase db,
    String mailboxId, {
    Optional<String>? label,
    Optional<String?>? clientEntryUuid,
    Optional<DateTime>? deletedAt,
    Optional<DateTime>? disabledAt,
    Optional<DateTime>? hiddenAt,
  }) async {
    await db.executeUpdate(
      _TABLE_EMAIL_MAILBOX,
      set: {
        _COLUMN_LABEL: label,
        _COLUMN_CLIENT_ENTRY_UUID: clientEntryUuid,
        _COLUMN_DELETED_AT: deletedAt,
        _COLUMN_DISABLED_AT: disabledAt,
        _COLUMN_HIDDEN_AT: hiddenAt,
      },
      where: {'id': mailboxId},
      setContainsOptional: true,
    );
  }

  Future<MailboxEntity?> findMailbox(DatabaseTransactionBase db,
      {String? address, String? mailboxId}) async {
    assert(address != null || mailboxId != null);
    final where = SimpleWhere({
      _COLUMN_ADDRESS: address,
      columnId: mailboxId,
    }, filterNullValues: true);
    return await db.query(
        '''SELECT $columnId, $_COLUMN_ADDRESS, $COLUMN_USER_ID, $_COLUMN_DISABLED_AT 
            FROM $_TABLE_EMAIL_MAILBOX
            WHERE $_COLUMN_DELETED_AT IS NULL AND ${where.sql()}''',
        values: where.conditions).singleOrNull((row) => MailboxEntity(
          id: row[0] as String,
          address: row[1] as String,
          user: UserEntity(id: row[2] as String),
          deletedAt: null,
          disabledAt: row[3] as DateTime?,
        ));
  }

  Future<List<Mailbox>> findMailboxAll(
      DatabaseTransactionBase db, UserEntity user) async {
    final result = await db.query('''
        SELECT $columnId, $_COLUMN_ADDRESS, $columnCreatedAt, 
                $_COLUMN_LABEL, $_COLUMN_CLIENT_ENTRY_UUID,
                $_COLUMN_DISABLED_AT
        FROM $_TABLE_EMAIL_MAILBOX 
        WHERE $COLUMN_USER_ID = @userId AND $_COLUMN_DELETED_AT IS NULL
        ORDER BY $columnCreatedAt DESC
        ''', values: {
      'userId': user.id,
    });
    return result
        .map(
          (row) => Mailbox(
            id: ApiUuid.parse(row[0] as String),
            address: row[1] as String,
            createdAt: row[2] as DateTime,
            label: row[3] as String,
            entryUuid: row[4] as String,
            isDisabled: row[5] != null,
          ),
        )
        .toList();
  }

  Future<ApiUuid> insertMessage(
    DatabaseTransactionBase db, {
    required MailboxEntity mailbox,
    required String? sender,
    required String subject,
    required String message,
  }) async {
    final id = cryptoService.createSecureUuid();
    await db.executeInsert(_TABLE_EMAIL_MESSAGE, {
      columnId: id,
      columnCreatedAt: clock.now().toUtc(),
      _COLUMN_MAILBOX_ID: mailbox.id,
      _COLUMN_MESSAGE: message,
      _COLUMN_SENDER: sender,
      _COLUMN_SIZE: message.length,
      _COLUMN_SUBJECT: subject.maxLength(SUBJECT_MAX_LENGTH),
    });
    return ApiUuid.parse(id);
  }

  Future<EmailMessageEntity?> findEmailForUser(
    DatabaseTransactionBase db,
    UserEntity user, {
    required String messageId,
  }) async {
    final list = await _findEmailsForUser(
      db,
      user,
      offset: 0,
      limit: 1,
      until: null,
      messageId: messageId,
    );
    if (list.isEmpty) {
      return null;
    }
    return list.first;
  }

  Future<List<EmailMessageEntity>> findEmailsForUser(
    DatabaseTransactionBase db,
    UserEntity user, {
    required int offset,
    required int limit,
    required DateTime until,
    DateTime? since,
  }) async {
    return await _findEmailsForUser(db, user,
        offset: offset, limit: limit, until: until, since: since);
  }

  Future<List<EmailMessageEntity>> _findEmailsForUser(
    DatabaseTransactionBase db,
    UserEntity user, {
    required int offset,
    required int limit,
    required DateTime? until,
    DateTime? since,
    String? messageId,
  }) async {
    final sinceFilter = since == null ? '' : ' AND m.$columnCreatedAt > @since';
    final messageIdFilter = messageId == null ? '' : ' AND m.id = @messageId';
    final untilFilter =
        until == null ? '' : ' AND m.$columnCreatedAt <= @until ';
    final result = await db.query('''
    SELECT m.$columnId, m.$_COLUMN_SUBJECT, m.$_COLUMN_SENDER, 
      m.$columnCreatedAt, m.$_COLUMN_MAILBOX_ID, m.$_COLUMN_SIZE,
      m.$_COLUMN_READ_AT, m.$_COLUMN_DELETED_AT
    FROM $_TABLE_EMAIL_MESSAGE m INNER JOIN $_TABLE_EMAIL_MAILBOX mb ON mb.$columnId = m.$_COLUMN_MAILBOX_ID
    WHERE 
      mb.$COLUMN_USER_ID = @userId 
      AND m.$_COLUMN_DELETED_AT IS NULL
      AND mb.$_COLUMN_DELETED_AT IS NULL
      $untilFilter
      $sinceFilter
      $messageIdFilter
    ORDER BY m.$columnCreatedAt DESC, m.$columnId
    LIMIT @limit OFFSET @offset
    ''', values: {
      'userId': user.id,
      if (until != null) 'until': until,
      'limit': limit,
      'offset': offset,
      if (since != null) 'since': since,
      if (messageId != null) 'messageId': messageId,
    });
    return result
        .map((row) => EmailMessageEntity(
              id: row[0] as String,
              subject: row[1] as String,
              sender: row[2] as String,
              createdAt: row[3] as DateTime,
              mailboxEntryUuid: row[4] as String,
              size: row[5] as int,
              readAt: row[6] as DateTime?,
              deletedAt: row[7] as DateTime?,
            ))
        .toList();
  }

  Future<String?> findEmailMessageBody(
      DatabaseTransactionBase db, UserEntity user,
      {required String messageId}) async {
    final message =
        await db.query('''SELECT m.$_COLUMN_MESSAGE, mb.$COLUMN_USER_ID 
    FROM $_TABLE_EMAIL_MESSAGE m 
      INNER JOIN $_TABLE_EMAIL_MAILBOX mb ON mb.$columnId = m.$_COLUMN_MAILBOX_ID
    WHERE m.$columnId = @id
      ''', values: {'id': messageId});
    checkState(message.length <= 1);
    if (message.isEmpty) {
      _logger.warning('Unknown message id $messageId');
      return null;
    }
    final row = message.first;

    final body = row[0] as String?;
    final userId = row[1] as String?;

    if (userId != user.id) {
      _logger.severe('User requested email which was not his own. '
          '$userId vs ${user.id} for email $messageId');
      return null;
    }
    return body;
  }

  /// update the read date of the given message.
  /// Before calling this method, makee sure it is a valid message id and
  /// the it belongs to the correct user.
  Future<void> updateMailMessage(
    DatabaseTransactionBase db, {
    required String messageId,
    required DateTime? readAt,
    required DateTime? deletedAt,
  }) async {
    await db.executeUpdate(_TABLE_EMAIL_MESSAGE, set: {
      _COLUMN_READ_AT: readAt,
      _COLUMN_DELETED_AT: deletedAt,
    }, where: {
      'id': messageId
    });
  }

  Future<UserEmailStatusEntity> userStatus(
      DatabaseTransactionBase db, UserEntity user) async {
    final result = await db.query('''
    SELECT count(m.id) 
    FROM $_TABLE_EMAIL_MESSAGE m 
      INNER JOIN $_TABLE_EMAIL_MAILBOX mb ON mb.$columnId = m.$_COLUMN_MAILBOX_ID
    WHERE mb.$_COLUMN_DELETED_AT IS NULL 
      AND m.$_COLUMN_DELETED_AT IS NULL 
      AND m.$_COLUMN_READ_AT IS NULL
      AND mb.$COLUMN_USER_ID = @userId
     ''', values: {'userId': user.id});

    final row = result.single;
    return UserEmailStatusEntity(messagesUnread: row[0] as int);
  }

  Future<int> messageMassUpdate(
    DatabaseTransactionBase db,
    UserEntity user,
    MailMassupdatePostSchemaFilter filter, {
    List<String>? messageIds,
    Optional<DateTime>? readAt,
  }) async {
    String? where;
    final whereValues = <String, Object?>{
      'userId': user.id,
    };
    switch (filter) {
      case MailMassupdatePostSchemaFilter.messageIds:
        ArgumentError.checkNotNull(messageIds);
        where = ' AND m.$columnId IN @messageIds';
        whereValues['messageIds'] = messageIds;
        break;
      case MailMassupdatePostSchemaFilter.all:
        where = '';
        break;
    }

    final update = UpdateQueryHelper();
    update.addSetOptional(_COLUMN_READ_AT, readAt);
    update.checkHasValues();
    return await db.execute('''
        UPDATE $_TABLE_EMAIL_MESSAGE m 
        SET ${update.setQuery}
        FROM $_TABLE_EMAIL_MAILBOX mb 
        WHERE mb.$COLUMN_USER_ID = @userId $where''', values: {
      ...whereValues,
      ...update.setValues,
    });
  }

  Future<SystemStatusMailbox> countMailbox(DatabaseTransactionBase db) async {
    final mailbox =
        await db.query('SELECT COUNT(*) FROM $_TABLE_EMAIL_MAILBOX').single;
    final message = await db
        .query('SELECT COUNT(*), COUNT($_COLUMN_READ_AT) '
            'FROM $_TABLE_EMAIL_MESSAGE')
        .single;
    return SystemStatusMailbox(
      mailboxCount: mailbox[0] as int,
      messageCount: message[0] as int,
      messageReadCount: message[1] as int,
    );
  }
}

class UserEmailStatusEntity {
  UserEmailStatusEntity({required this.messagesUnread});
  final int messagesUnread;
}

class UpdateQueryHelper {
  final Map<String, Object?> setValues = {};
  final List<String> _setQueryList = [];
  int varCount = 0;

  String get setQuery => _setQueryList.join(',');

  /// Attributes which were added using [addSetOptional] but were ignored
  /// because the value was null.
  final List<String> ignoredAttributes = [];

  void addSetOptional(String attribute, Optional? value) {
    if (value == null) {
      ignoredAttributes.add(attribute);
      return;
    }
    final varName = 'setVar${varCount++}';
    setValues[varName] = value.orNull;
    _setQueryList.add('$attribute = @$varName');
  }

  void checkHasValues() {
    if (setValues.isEmpty) {
      throw ArgumentError('No updates where specified. one of those have '
          'to be non-null: $ignoredAttributes');
    }
  }
}

extension on String {
  String maxLength(int maxLength) {
    if (length > maxLength) {
      return substring(0, maxLength);
    }
    return this;
  }
}

class MailboxEntity {
  MailboxEntity({
    required this.id,
    required this.address,
    required this.user,
    required this.disabledAt,
    required this.deletedAt,
  });

  final String id;
  final String address;
  final UserEntity user;
  final DateTime? disabledAt;
  final DateTime? deletedAt;
}

class EmailMessageEntity {
  EmailMessageEntity({
    required this.id,
    required this.subject,
    required this.sender,
    required this.mailboxEntryUuid,
    required this.createdAt,
    required this.size,
    required this.readAt,
    required this.deletedAt,
  });

  final String id;

  final String subject;

  final String sender;

  final String mailboxEntryUuid;

  final DateTime createdAt;

  final int size;

  final DateTime? readAt;

  bool get isRead => readAt != null;

  final DateTime? deletedAt;

  EmailMessage toEmailMessage() => EmailMessage(
        id: ApiUuid.parse(id),
        subject: subject,
        sender: sender,
        mailboxEntryUuid: ApiUuid.parse(mailboxEntryUuid),
        createdAt: createdAt,
        size: size,
        isRead: readAt != null,
      );
}
