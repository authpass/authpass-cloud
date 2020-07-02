import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/dao/tables/user_tables.dart';
import 'package:clock/clock.dart';

import 'package:logging/logging.dart';

final _logger = Logger('user_repository');

class UserRepository {
  UserRepository(this.db);

  final DatabaseTransaction db;

  /// Creates a new user with the given email address.
  /// If the email address is already known, just creates a new
  /// email confirmation token.
  Future<EmailConfirmEntity> createUserOrConfirmEmail(String email) async {
    assert(email != null);
    final userEmail = await db.tables.user.findUserByEmail(db, email);
    if (userEmail == null) {
      return await db.tables.user.insertUser(db, email);
    }
    final authToken = await db.tables.user.insertAuthToken(db, userEmail.user);
    return await db.tables.user.insertEmailConfirmToken(
      db,
      userEmail,
      authToken,
    );
  }

  Future<bool> isValidEmailConfirmToken(String token) =>
      db.tables.user.isValidEmailToken(db, token);

  Future<void> confirmEmailAddress(String token) async {
    final emailConfirmToken =
        await db.tables.user.findEmailConfirmToken(db, token);
    if (emailConfirmToken.confirmedAt == null) {
      await db.tables.user.updateEmailConfirmToken(db, emailConfirmToken.token,
          confirmedAt: clock.now().toUtc());
      if (emailConfirmToken.authToken.status == AuthTokenStatus.created) {
        await db.tables.user.updateAuthToken(db, emailConfirmToken.authToken.id,
            status: AuthTokenStatus.active);
      }
    }
  }

  Future<AuthTokenEntity> findValidAuthToken(String authToken,
      {bool acceptUnconfirmed = false}) async {
    final token = await db.tables.user.findAuthToken(db, authToken: authToken);
    if (token == null) {
      return null;
    }
    if (acceptUnconfirmed && token.status == AuthTokenStatus.created) {
      return token;
    }

    if (token.status == AuthTokenStatus.active) {
      return token;
    }

    _logger.warning(
        'Trying to find valid auth token, but status was ${token.status}');
    return null;
  }
}
