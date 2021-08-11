import 'dart:math';

import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:postgres_utils/postgres_utils.dart';

import 'package:logging/logging.dart';

final _logger = Logger('test_utils');

class TestUtils {
  static final config = DatabaseConfig.fromEnvironment();

  static DatabaseAccess createDatabaseAccess(DatabaseConfig config) {
    return DatabaseAccess(cryptoService: CryptoService(), config: config);
  }

  static Future<DatabaseAccess> setUpDatabase() async {
    final tmp = createDatabaseAccess(config);
    final testDb = 'authpass_test_${Random().nextInt(1000000)}';
    _logger.info('Using database: $testDb ${config.toJson()}');
    await tmp.forTestCreateDatabase(testDb);
    await tmp.dispose();
    final db = createDatabaseAccess(config.copyWith(databaseName: testDb));
    await db.prepareDatabase();
    return db;
  }

  static Future<void> tearDown(DatabaseAccess db) async {
    await db.dispose();
    final dbDrop = TestUtils.createDatabaseAccess(config);
    await dbDrop.forTestDropDatabase(db.config.databaseName);
    await dbDrop.dispose();
  }
}
