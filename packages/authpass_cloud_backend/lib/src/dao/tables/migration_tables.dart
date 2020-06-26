import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/dao/tables/base_tables.dart';

import 'package:logging/logging.dart';
import 'package:quiver/check.dart';

final _logger = Logger('migration_tables');

class MigrationTable extends TableBase with TableConstants {
  static const _TABLE_MIGRATE = 'authpass_migration';
  static const _TABLE_MIGRATE_VERSION = 'version';
  static const _TABLE_MIGRATE_APPLIED_AT = 'applied_at';

  @override
  List<String> get tables => [_TABLE_MIGRATE];

  Future<void> createTable(DatabaseTransaction connection) async {
    _logger.finest('Creating table ...');
    final result = await connection.execute('''
      CREATE TABLE IF NOT EXISTS $_TABLE_MIGRATE (
        $columnId SERIAL PRIMARY KEY,
        $_TABLE_MIGRATE_APPLIED_AT $typeTimestamp NOT NULL,
        $_TABLE_MIGRATE_VERSION INT NOT NULL
      );
      ''');
    _logger.fine('Got result: $result');
    if (result > 0) {
      if (result > 1) {
        throw Exception('Expected at most 1 affected row $result');
      }
    }
  }

  Future<int> queryLastVersion(DatabaseTransaction connection) async {
    final result = await connection
        .query('SELECT MAX($_TABLE_MIGRATE_VERSION) FROM $_TABLE_MIGRATE');
    final maxVersion = result.first[0] as int;
    _logger.finer('Migration version: $maxVersion');
    return maxVersion ?? 0;
  }

  Future<void> insertMigrationRun(
      DatabaseTransaction db, DateTime appliedAt, int version) async {
    final result = await db.execute(
        '''INSERT INTO $_TABLE_MIGRATE ($_TABLE_MIGRATE_APPLIED_AT, $_TABLE_MIGRATE_VERSION)
      values (@appliedAt, @version)''',
        values: {'appliedAt': appliedAt, 'version': version});
    checkState(result == 1);
  }
}