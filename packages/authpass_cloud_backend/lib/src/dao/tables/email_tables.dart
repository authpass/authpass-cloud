import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/dao/tables/base_tables.dart';
import 'package:authpass_cloud_backend/src/dao/tables/user_tables.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:clock/clock.dart';
import 'package:meta/meta.dart';
import 'package:quiver/check.dart';

import 'package:logging/logging.dart';

final _logger = Logger('email_tables');

class EmailTable extends TableBase with TableConstants {
  EmailTable({@required this.cryptoService}) : assert(cryptoService != null);

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
  static const _COLUMN_READ_AT = 'readAt';

  final CryptoService cryptoService;

  @override
  List<String> get tables => [
        _TABLE_EMAIL_MAILBOX,
        _TABLE_EMAIL_MESSAGE,
      ];
  Future<void> createTables(DatabaseTransaction db) async {
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

  Future<void> insertMailbox(
    DatabaseTransaction db, {
    @required UserEntity userEntity,
    @required String label,
    @required String address,
    @required String clientEntryUuid,
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

  Future<MailboxEntity> findMailbox(DatabaseTransaction db,
      {@required String address}) async {
    assert(address != null);
    assert(db != null);
    return await db.query(
        'SELECT $columnId, $_COLUMN_ADDRESS FROM $_TABLE_EMAIL_MAILBOX WHERE $_COLUMN_ADDRESS = @address',
        values: {
          'address': address
        }).singleOrNull((row) => MailboxEntity(
          id: row[0] as String,
          address: row[1] as String,
        ));
  }

  Future<List<Mailbox>> findMailboxAll(
      DatabaseTransaction db, UserEntity user) async {
    final result = await db.query('''
        SELECT $columnId, $_COLUMN_ADDRESS, $columnCreatedAt, 
                $_COLUMN_LABEL, $_COLUMN_CLIENT_ENTRY_UUID 
        FROM $_TABLE_EMAIL_MAILBOX 
        WHERE $COLUMN_USER_ID = @userId''', values: {
      'userId': user.id,
    });
    return result
        .map(
          (row) => Mailbox(
            address: row[1] as String,
            createdAt: row[2] as DateTime,
            label: row[3] as String,
            entryUuid: row[4] as String,
          ),
        )
        .toList();
  }

  Future<String> insertMessage(
    DatabaseTransaction db, {
    @required MailboxEntity mailbox,
    @required String sender,
    @required String subject,
    @required String message,
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
    return id;
  }

  Future<List<EmailMessage>> findEmailsForUser(
    DatabaseTransaction db,
    UserEntity user, {
    @required int offset,
    @required int limit,
    @required DateTime until,
    DateTime since,
  }) async {
    final sinceFilter = since == null ? '' : ' AND m.$columnCreatedAt > @since';
    final result = await db.query('''
    SELECT m.$columnId, m.$_COLUMN_SUBJECT, m.$_COLUMN_SENDER, 
      m.$columnCreatedAt, m.$_COLUMN_MAILBOX_ID, m.$_COLUMN_SIZE,
      m.$_COLUMN_READ_AT
    FROM $_TABLE_EMAIL_MESSAGE m INNER JOIN $_TABLE_EMAIL_MAILBOX mb ON mb.$columnId = m.$_COLUMN_MAILBOX_ID
    WHERE mb.$COLUMN_USER_ID = @userId AND m.$columnCreatedAt <= @until $sinceFilter
    ORDER BY m.$columnCreatedAt DESC, m.$columnId
    LIMIT @limit OFFSET @offset
    ''', values: {
      'userId': user.id,
      'until': until,
      'limit': limit,
      'offset': offset,
      if (since != null) 'since': since,
    });
    return result
        .map((row) => EmailMessage(
              id: row[0] as String,
              subject: row[1] as String,
              sender: row[2] as String,
              createdAt: row[3] as DateTime,
              mailboxEntryUuid: row[4] as String,
              size: row[5] as int,
              isRead: row[6] != null,
            ))
        .toList();
  }

  Future<String> findEmailMessageBody(DatabaseTransaction db, UserEntity user,
      {@required String messageId}) async {
    assert(user != null);
    assert(messageId != null);
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

    final body = row[0] as String;
    final userId = row[1] as String;

    if (userId != user.id) {
      _logger.severe('User requested email which was not his own. '
          '$userId vs ${user.id} for email $messageId');
      return null;
    }
    return body;
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
  MailboxEntity({this.id, this.address});

  final String id;
  final String address;
}
