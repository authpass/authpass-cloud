import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';

class SystemDao {
  SystemDao(this.db);
  final DatabaseTransaction db;

  Future<SystemStatus> getStats() async {
    final stopwatch = Stopwatch()..start();
    return SystemStatus(
      user: await db.tables.user.countUsers(db),
      website: await db.tables.website.countStats(db),
      mailbox: await db.tables.email.countMailbox(db),
      fileCloud: await db.tables.fileCloud.countStats(db),
      queryTime: stopwatch.elapsedMilliseconds,
    );
  }
}
