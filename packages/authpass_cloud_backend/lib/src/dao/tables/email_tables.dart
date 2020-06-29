import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/dao/tables/base_tables.dart';
import 'package:authpass_cloud_backend/src/dao/tables/user_tables.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:meta/meta.dart';
import 'package:quiver/check.dart';

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
  static const _COLUMN_MESSAGE = 'message';
  static const _COLUMN_SIZE = 'size';
  static const _COLUMN_SENDER = 'sender';

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

  Future<void> insertMessage(
    DatabaseTransaction db, {
    @required MailboxEntity mailbox,
    @required String sender,
    @required String subject,
    @required String message,
  }) async {
    final id = cryptoService.createSecureUuid();
    await db.executeInsert(_TABLE_EMAIL_MESSAGE, {
      columnId: id,
      _COLUMN_MAILBOX_ID: mailbox.id,
      _COLUMN_MESSAGE: message,
      _COLUMN_SENDER: sender,
      _COLUMN_SIZE: message.length,
      _COLUMN_SUBJECT: subject.maxLength(SUBJECT_MAX_LENGTH),
    });
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
