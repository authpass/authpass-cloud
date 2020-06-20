import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/dao/tables/base_tables.dart';

class UserTable extends TableBase with TableConstants {
  static const _TABLE_USER = '"user"';
  static const _TABLE_AUTH_TOKEN = 'auth_token';
  static const _TABLE_EMAIL = 'email';
  static const _COLUMN_USER_ID = 'user_id';
  static const _TABLE_EMAIL_CONFIRM = 'email_confirm';
  static const _COLUMN_TOKEN = 'token';
  static const _COLUMN_EMAIL_ID = 'email_id';

  @override
  List<String> get tables => [
        _TABLE_USER,
        _TABLE_AUTH_TOKEN,
        _TABLE_EMAIL,
        _TABLE_EMAIL_CONFIRM,
      ];

  Future<void> createTables(DatabaseTransaction conn) async {
    await conn.execute('''
    CREATE TABLE $_TABLE_USER (
      $columnId uuid primary key,
      $specColumnCreatedAt
    );
    CREATE TABLE $_TABLE_AUTH_TOKEN (
      $columnId serial primary key,
      $_COLUMN_USER_ID uuid not null references $_TABLE_USER ($columnId),
      $_COLUMN_TOKEN varchar not null unique
    );
    CREATE TABLE $_TABLE_EMAIL (
      $columnId uuid primary key,
      $specColumnCreatedAt
    );
    CREATE TABLE $_TABLE_EMAIL_CONFIRM (
      $_COLUMN_EMAIL_ID uuid not null references $_TABLE_EMAIL ($columnId),
      $_COLUMN_TOKEN varchar not null unique,
      $specColumnCreatedAt
    );
    ''');
  }
}
