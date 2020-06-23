import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/dao/tables/user_tables.dart';

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
}
