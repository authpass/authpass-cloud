import 'dart:math';

import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:test/test.dart';

DatabaseAccess _createDatabaseAccess(DatabaseConfig config) {
  return DatabaseAccess(cryptoService: CryptoService(), config: config);
}

void main() {
  PrintAppender.setupLogging();
  final config = DatabaseConfig();
  DatabaseAccess db;
  setUp(() async {
    final tmp = _createDatabaseAccess(config);
    final testDb = 'authpass_test_${Random().nextInt(1000000)}';
    await tmp.forTestCreateDatabase(testDb);
    await tmp.dispose();
    db = _createDatabaseAccess(config.copyWith(databaseName: testDb));
    await db.prepareDatabase();
  });
  tearDown(() async {
    await db.dispose();
    await _createDatabaseAccess(config)
        .forTestDropDatabase(db.config.databaseName);
  });
  test('creating user', () async {
    await db.run((db) async {
      final user = await db.tables.user.findUserByEmail(db, 'a@b.com');
      expect(user, isNull);
      final created = db.tables.user.insertUser(db, 'a@b.com');
      expect(created, isNotNull);
    });
  });
}
