import 'dart:math';

import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:test/test.dart';

import '../test_utils.dart';

void main() {
  PrintAppender.setupLogging();
  DatabaseAccess db;
  setUp(() async {
    db = await TestUtils.setUpDatabase();
  });
  tearDown(() async {
    await TestUtils.tearDown(db);
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
