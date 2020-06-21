import 'package:authpass_cloud_backend/src/dao/database_access.dart';

class UserRepository {
  UserRepository(this.db);

  final DatabaseTransaction db;

  /// Creates a new user with the given email address.
  /// If the email address is already known, just creates a new
  /// email confirmation token.
  Future<void> createUserOrConfirmEmail(String email) async {
    assert(email != null);
    final user = await db.tables.user.findUserByEmail(db, email);
    if (user == null) {
      return await db.tables.user.insertUser(db, email);
    }
  }
}
