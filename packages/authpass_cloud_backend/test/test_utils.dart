import 'dart:math';

import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/env/config.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';

class TestUtils {
  static final config = DatabaseConfig.defaults();

  static DatabaseAccess createDatabaseAccess(DatabaseConfig config) {
    return DatabaseAccess(cryptoService: CryptoService(), config: config);
  }

  static Future<DatabaseAccess> setUpDatabase() async {
    final tmp = createDatabaseAccess(config);
    final testDb = 'authpass_test_${Random().nextInt(1000000)}';
    await tmp.forTestCreateDatabase(testDb);
    await tmp.dispose();
    final db = createDatabaseAccess(config.copyWith(databaseName: testDb));
    await db.prepareDatabase();
    return db;
  }

  static Future<void> tearDown(DatabaseAccess db) async {
    await db.dispose();
    await TestUtils.createDatabaseAccess(config)
        .forTestDropDatabase(db.config.databaseName);
  }
}
