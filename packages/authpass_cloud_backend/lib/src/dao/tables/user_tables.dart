import 'dart:async';

import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/dao/tables/base_tables.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

final _logger = Logger('user_tables');

enum AuthTokenStatus {
  created,
  active,
  disabled,
}

extension on AuthTokenStatus {
  String get name => toString().split('.')[1];
}

AuthTokenStatus authTokenStatusFromName(String name) =>
    AuthTokenStatus.values.firstWhere((element) => element.name == name);

class UserTable extends TableBase with TableConstants {
  UserTable({@required this.cryptoService}) : assert(cryptoService != null);

  static const TABLE_USER = '"user"';
  static const _TABLE_AUTH_TOKEN = 'auth_token';
  static const _COLUMN_STATUS = 'status';
  static const _TABLE_EMAIL = 'user_email';
  static const COLUMN_USER_ID = 'user_id';
  static const _TABLE_EMAIL_CONFIRM = 'user_email_confirm';
  static const _COLUMN_TOKEN = 'token';

  /// reference from email token to auth token.
  static const _COLUMN_AUTH_TOKEN_ID = 'auth_token_id';
  static const _COLUMN_EMAIL_ID = 'email_id';
  static const _COLUMN_EMAIL_ADDRESS = 'email_address';
  static const _COLUMN_CONFIRMED_AT = 'confirmed_at';
  static const _TYPE_STATUS = 'AuthTokenStatus';

  final CryptoService cryptoService;

  @override
  List<String> get tables => [
        TABLE_USER,
        _TABLE_AUTH_TOKEN,
        _TABLE_EMAIL,
        _TABLE_EMAIL_CONFIRM,
      ];

  @override
  List<String> get types => [_TYPE_STATUS];

  Future<void> createTables(DatabaseTransaction conn) async {
    await conn.execute('''
    CREATE TABLE $TABLE_USER (
      $columnId uuid primary key,
      $specColumnCreatedAt
    );
    CREATE TYPE $_TYPE_STATUS AS ENUM 
      (${AuthTokenStatus.values.map((e) => "'${e.name}'").join(',')});
    CREATE TABLE $_TABLE_AUTH_TOKEN (
      $columnId uuid primary key,
      $COLUMN_USER_ID uuid not null references $TABLE_USER ($columnId),
      $_COLUMN_TOKEN varchar not null,
      $_COLUMN_STATUS $_TYPE_STATUS not null,
      $specColumnCreatedAt,

      UNIQUE ($_COLUMN_TOKEN)
    );
    CREATE TABLE $_TABLE_EMAIL (
      $columnId uuid primary key,
      $COLUMN_USER_ID uuid not null references $TABLE_USER ($columnId),
      $_COLUMN_EMAIL_ADDRESS varchar not null,
      $specColumnCreatedAt,
      $_COLUMN_CONFIRMED_AT $typeTimestamp default null,
      
      UNIQUE ($_COLUMN_EMAIL_ADDRESS)
    );
    CREATE TABLE $_TABLE_EMAIL_CONFIRM (
      $_COLUMN_EMAIL_ID uuid not null references $_TABLE_EMAIL ($columnId),
      $_COLUMN_TOKEN varchar not null unique,
      $_COLUMN_AUTH_TOKEN_ID uuid references $_TABLE_AUTH_TOKEN ($columnId),
      $_COLUMN_CONFIRMED_AT $typeTimestamp default null,
      $specColumnCreatedAt
    );
    ''');
  }

  String _normalizeEmail(String email) {
    return email.toLowerCase();
  }

  Future<EmailEntity> findUserByEmail(
      DatabaseTransaction db, String email) async {
    email = _normalizeEmail(email);
    final query = await db.query('''
      SELECT u.$columnId, e.$columnId FROM $TABLE_USER u 
        INNER JOIN $_TABLE_EMAIL e ON u.$columnId = e.$COLUMN_USER_ID
      WHERE e.$_COLUMN_EMAIL_ADDRESS = @email
    ''', values: <String, dynamic>{'email': email});
    if (query.isEmpty) {
      return null;
    }
    final row = query.first;
    return EmailEntity(
      id: row[1] as String,
      emailAddress: email,
      user: UserEntity(id: row[0] as String),
    );
  }

  Future<AuthTokenEntity> insertAuthToken(
    DatabaseTransaction db,
    UserEntity user,
  ) async {
    final tokenUuid = cryptoService.createSecureUuid();
    final authToken =
        cryptoService.createSecureToken(type: TokenType.emailConfirm);
    await db.execute('''INSERT INTO $_TABLE_AUTH_TOKEN 
     ($columnId, $COLUMN_USER_ID, $_COLUMN_TOKEN, $_COLUMN_STATUS)
     VALUES (@tokenUuid, @userUuid, @token, @status)
    ''', values: {
      'tokenUuid': tokenUuid,
      'userUuid': user.id,
      'token': authToken,
      'status': AuthTokenStatus.created.name,
    });
    return AuthTokenEntity(
      id: tokenUuid,
      token: authToken,
      status: AuthTokenStatus.created,
      user: user,
    );
  }

  Future<EmailConfirmEntity> insertEmailConfirmToken(DatabaseTransaction db,
      EmailEntity email, AuthTokenEntity authToken) async {
    final emailToken =
        cryptoService.createSecureToken(type: TokenType.emailConfirm);
    await db.execute('''
          INSERT INTO $_TABLE_EMAIL_CONFIRM 
          ($_COLUMN_EMAIL_ID, $_COLUMN_TOKEN, $_COLUMN_AUTH_TOKEN_ID)
        values (@emailUuid, @emailToken, @authTokenId);
    ''', values: {
      'emailUuid': email.id,
      'emailToken': emailToken,
      'authTokenId': authToken?.id,
    });
    return EmailConfirmEntity(
      email: email,
      token: emailToken,
      authToken: authToken,
      confirmedAt: null,
    );
  }

  Future<bool> isValidEmailToken(DatabaseTransaction db, String token) async {
    final result = await db.query(
        '''SELECT $_COLUMN_CONFIRMED_AT FROM $_TABLE_EMAIL_CONFIRM WHERE token = @token''',
        values: {'token': token});
    if (result.isEmpty) {
      return false;
    }
    final tokenResult = result.single;
    if (tokenResult[0] != null) {
      _logger.fine('Token validated which was already confirmed.');
      return false;
    }
    return true;
  }

  Future<AuthTokenEntity> findAuthToken(DatabaseTransaction db,
      {String authToken, String tokenId}) async {
    assert(authToken != null || tokenId != null);
    final where =
        authToken != null ? ' $_COLUMN_TOKEN = @token ' : '$columnId = @id ';
    return db.query(
        '''select $columnId, $COLUMN_USER_ID, $_COLUMN_TOKEN, $_COLUMN_STATUS FROM $_TABLE_AUTH_TOKEN WHERE $where''',
        values: authToken != null
            ? {'token': authToken}
            : {'id': tokenId}).singleOrNull((row) {
      return AuthTokenEntity(
        id: row[0] as String,
        token: row[2] as String,
        status: authTokenStatusFromName(row[3] as String),
        user: UserEntity(id: row[1] as String),
      );
    });
  }

  Future<EmailConfirmEntity> findEmailConfirmToken(
      DatabaseTransaction db, String token) async {
    return await db.query('''SELECT $_COLUMN_EMAIL_ID,
     $_COLUMN_TOKEN, $_COLUMN_AUTH_TOKEN_ID, $_COLUMN_CONFIRMED_AT 
     FROM $_TABLE_EMAIL_CONFIRM WHERE $_COLUMN_TOKEN = @token ''',
        values: {'token': token}).singleOrNull((row) async {
      final email = await findEmailById(db, row[0] as String);
      final authToken = row[2] == null
          ? null
          : await findAuthToken(db, tokenId: row[2] as String);
      return EmailConfirmEntity(
        email: email,
        token: row[1] as String,
        authToken: authToken,
        confirmedAt: row[3] as DateTime,
      );
    });
  }

  Future<EmailEntity> findEmailById(
      DatabaseTransaction db, String emailId) async {
    return db.query('''SELECT $COLUMN_USER_ID, $_COLUMN_EMAIL_ADDRESS, 
    $_COLUMN_CONFIRMED_AT FROM $_TABLE_EMAIL WHERE $columnId = @id''',
        values: {'id': emailId}).singleOrNull((row) {
      return EmailEntity(
        id: emailId,
        emailAddress: row[1] as String,
        user: UserEntity(id: row[0] as String),
      );
    });
  }

  Future<EmailConfirmEntity> insertUser(
      DatabaseTransaction db, String email) async {
    email = _normalizeEmail(email);
    final userUuid = cryptoService.createSecureUuid();
    final emailUuid = cryptoService.createSecureUuid();
    final result = await db.execute(
      '''
      INSERT INTO $TABLE_USER ($columnId) values (@uuid);
      INSERT INTO $_TABLE_EMAIL 
        ($columnId, $COLUMN_USER_ID, $_COLUMN_EMAIL_ADDRESS)
        values
        (@emailUuid, @uuid, @email);
      ''',
      values: {
        'uuid': userUuid,
        'emailUuid': emailUuid,
        'email': email,
      },
    );
    final user = UserEntity(id: userUuid);
    final authToken = await insertAuthToken(db, user);
    _logger.fine('Inserted new user, result: $result');
    assert(result == 1);
    return insertEmailConfirmToken(
      db,
      EmailEntity(
        id: emailUuid,
        emailAddress: email,
        user: user,
      ),
      authToken,
    );
  }

  Future<void> updateAuthToken(DatabaseTransaction db, String id,
      {AuthTokenStatus status}) async {
    await db.execute(
      '''UPDATE $_TABLE_AUTH_TOKEN SET $_COLUMN_STATUS = @status WHERE $columnId = @id''',
      values: {'status': status.name, 'id': id},
      expectedResultCount: 1,
    );
  }

  Future<void> updateEmailConfirmToken(DatabaseTransaction db, String token,
      {DateTime confirmedAt}) async {
    await db.execute(
      '''UPDATE $_TABLE_EMAIL_CONFIRM SET $_COLUMN_CONFIRMED_AT = @confirmedAt WHERE token = @token''',
      values: {'confirmedAt': confirmedAt, 'token': token},
      expectedResultCount: 1,
    );
  }
}

class AuthTokenEntity {
  AuthTokenEntity({
    @required this.id,
    @required this.token,
    @required this.status,
    @required this.user,
  })  : assert(id != null),
        assert(token != null),
        assert(status != null);
  final String id;
  final String token;
  final AuthTokenStatus status;
  final UserEntity user;
}

class UserEntity {
  UserEntity({
    @required this.id,
  }) : assert(id != null);

  final String id;
}

class EmailEntity {
  EmailEntity(
      {@required this.id, @required this.emailAddress, @required this.user})
      : assert(id != null),
        assert(emailAddress != null),
        assert(user != null);

  final String id;
  final String emailAddress;
  final UserEntity user;
}

class EmailConfirmEntity {
  EmailConfirmEntity({
    @required this.email,
    @required this.token,
    @required this.authToken,
    @required this.confirmedAt,
  })  : assert(email != null),
        assert(token != null);

  final EmailEntity email;
  final String token;
  final AuthTokenEntity authToken;
  final DateTime confirmedAt;
}
