import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/dao/tables/base_tables.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:meta/meta.dart';

import 'package:logging/logging.dart';

final _logger = Logger('user_tables');

enum AuthTokenStatus {
  created,
  active,
  disabled,
}

extension on AuthTokenStatus {
  String get name => toString().split('.')[1];
}

class UserTable extends TableBase with TableConstants {
  UserTable({@required this.cryptoService}) : assert(cryptoService != null);

  static const _TABLE_USER = '"user"';
  static const _TABLE_AUTH_TOKEN = 'auth_token';
  static const _COLUMN_STATUS = 'status';
  static const _TABLE_EMAIL = 'email';
  static const _COLUMN_USER_ID = 'user_id';
  static const _TABLE_EMAIL_CONFIRM = 'email_confirm';
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
        _TABLE_USER,
        _TABLE_AUTH_TOKEN,
        _TABLE_EMAIL,
        _TABLE_EMAIL_CONFIRM,
      ];

  @override
  List<String> get types => [_TYPE_STATUS];

  Future<void> createTables(DatabaseTransaction conn) async {
    await conn.execute('''
    CREATE TABLE $_TABLE_USER (
      $columnId uuid primary key,
      $specColumnCreatedAt
    );
    CREATE TYPE $_TYPE_STATUS AS ENUM 
      (${AuthTokenStatus.values.map((e) => "'${e.name}'").join(',')});
    CREATE TABLE $_TABLE_AUTH_TOKEN (
      $columnId uuid primary key,
      $_COLUMN_USER_ID uuid not null references $_TABLE_USER ($columnId),
      $_COLUMN_TOKEN varchar not null,
      $_COLUMN_STATUS $_TYPE_STATUS not null,
      $specColumnCreatedAt,

      UNIQUE ($_COLUMN_TOKEN)
    );
    CREATE TABLE $_TABLE_EMAIL (
      $columnId uuid primary key,
      $_COLUMN_USER_ID uuid not null references $_TABLE_USER ($columnId),
      $_COLUMN_EMAIL_ADDRESS varchar not null,
      $specColumnCreatedAt,
      $_COLUMN_CONFIRMED_AT $typeTimestamp default null,
      
      UNIQUE ($_COLUMN_EMAIL_ADDRESS)
    );
    CREATE TABLE $_TABLE_EMAIL_CONFIRM (
      $_COLUMN_EMAIL_ID uuid not null references $_TABLE_EMAIL ($columnId),
      $_COLUMN_TOKEN varchar not null unique,
      $_COLUMN_AUTH_TOKEN_ID uuid references $_TABLE_AUTH_TOKEN ($columnId),
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
      SELECT u.$columnId, e.$columnId FROM $_TABLE_USER u 
        INNER JOIN $_TABLE_EMAIL e ON u.$columnId = e.$_COLUMN_USER_ID
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
     ($columnId, $_COLUMN_USER_ID, $_COLUMN_TOKEN, $_COLUMN_STATUS)
     VALUES (@tokenUuid, @userUuid, @token, @status)
    ''', values: {
      'tokenUuid': tokenUuid,
      'userUuid': user.id,
      'token': authToken,
      'status': AuthTokenStatus.created.name,
    });
    return AuthTokenEntity(id: tokenUuid, token: authToken);
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
    );
  }

  Future<EmailConfirmEntity> insertUser(
      DatabaseTransaction db, String email) async {
    email = _normalizeEmail(email);
    final userUuid = cryptoService.createSecureUuid();
    final emailUuid = cryptoService.createSecureUuid();
    final result = await db.execute(
      '''
      INSERT INTO $_TABLE_USER ($columnId) values (@uuid);
      INSERT INTO $_TABLE_EMAIL 
        ($columnId, $_COLUMN_USER_ID, $_COLUMN_EMAIL_ADDRESS)
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
}

class AuthTokenEntity {
  AuthTokenEntity({@required this.id, @required this.token})
      : assert(id != null),
        assert(token != null);
  final String id;
  final String token;
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
  })  : assert(email != null),
        assert(token != null);

  final EmailEntity email;
  final String token;
  final AuthTokenEntity authToken;
}
