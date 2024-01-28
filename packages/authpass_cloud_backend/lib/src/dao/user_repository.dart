import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/dao/db_update_util.dart';
import 'package:authpass_cloud_backend/src/dao/tables/user_tables.dart';
import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:clock/clock.dart';

import 'package:logging/logging.dart';
import 'package:openapi_base/openapi_base.dart';

final _logger = Logger('user_repository');

class UserRepository {
  UserRepository(this.db);

  final DatabaseTransaction db;

  /// Creates a new user with the given email address.
  /// If the email address is already known, just creates a new
  /// email confirmation token.
  Future<EmailConfirmEntity> createUserOrConfirmEmail(
      String email, String userAgent,
      {bool requireExistingUser = false}) async {
    final userEmail = await db.tables.user.findUserByEmail(db, email);
    if (userEmail == null) {
      if (requireExistingUser) {
        throw NotFoundException('Unable to find user with email address.');
      }
      return await db.tables.user.insertUser(db, email, userAgent);
    }
    final authToken =
        await db.tables.user.insertAuthToken(db, userEmail.user, userAgent);
    return await db.tables.user.insertEmailConfirmToken(
      db,
      userEmail,
      authToken,
    );
  }

  Future<bool> isValidEmailConfirmToken(String token) =>
      db.tables.user.isValidEmailToken(db, token);

  Future<bool> confirmEmailAddress(String token) async {
    final emailConfirmToken =
        await db.tables.user.findEmailConfirmToken(db, token);
    if (emailConfirmToken == null) {
      throw StateError('Unable to find confirm token. $token');
    }
    if (emailConfirmToken.confirmedAt != null) {
      _logger.warning('Email was already confirmed. '
          '$token (${emailConfirmToken.email.emailAddress})');
      return false;
    }
    final now = clock.now().toUtc();
    await db.tables.user
        .updateEmailConfirmToken(db, emailConfirmToken, confirmedAt: now);
    final authToken = emailConfirmToken.authToken;
    if (authToken != null && authToken.status == AuthTokenStatus.created) {
      await db.tables.user
          .updateAuthToken(db, authToken.id, status: AuthTokenStatus.active);
    }
    return true;
  }

  Future<EmailConfirmEntity?> deleteAccountForEmailToken(String token) async {
    final emailConfirmToken =
        await db.tables.user.findEmailConfirmToken(db, token);
    if (emailConfirmToken == null) {
      throw StateError('Unable to find confirm token. $token');
    }
    final authToken = emailConfirmToken.authToken;
    if (authToken == null) {
      return null;
    }
    _logger.info('Deleting user with id ${authToken.user.id}');
    final ret = DbUpdateTracker.merge([
      await db.tables.fileCloud.deleteAllForUser(db, authToken.user),
      await db.tables.email.deleteAllForUser(db, authToken.user),
      await db.tables.user
          .deleteUserAndAllReferences(db, emailConfirmToken, authToken),
    ]);
    _logger.info('finished deleting. result: ${ret.results}');
    return emailConfirmToken;
  }

  Future<AuthTokenEntity?> findValidAuthToken(String authToken,
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

  Future<UserInfo> findUserInfo({required AuthTokenEntity authToken}) async {
    return UserInfo(
        emails: await db.tables.user.findEmailsByUser(db, authToken.user));
  }
}
