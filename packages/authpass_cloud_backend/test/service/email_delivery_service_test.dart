import 'dart:io';

import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/dao/email_repository.dart';
import 'package:authpass_cloud_backend/src/dao/user_repository.dart';
import 'package:authpass_cloud_backend/src/env/env.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:authpass_cloud_backend/src/service/email_delivery_service.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:meta/meta.dart';
import 'package:smtpd/smtpd.dart';
import 'package:test/test.dart';

import '../test_utils.dart';

@isTest
void databaseTest(
    String description, Future<void> Function(DatabaseTransaction db) body) {
  test(description, () async {
    final db = await TestUtils.setUpDatabase();
    try {
      await db.run((db) async {
        await body(db);
      });
    } finally {
      await TestUtils.tearDown(db);
    }
  });
}

void main() {
  PrintAppender.setupLogging();
  databaseTest('Deliver email', (db) async {
    final userRepository = UserRepository(db);
    final user = await userRepository.createUserOrConfirmEmail('a@b.com');

    await userRepository.confirmEmailAddress(user.token);
    final emailRepository =
        EmailRepository(db: db, cryptoService: CryptoService(), env: DevEnv());
    final address = await emailRepository.createAddress(user.authToken.user,
        label: '', clientEntryUuid: '');

    final email = EmailDeliveryService();
    final bodyEmail =
        await File('test/service/email_example.txt').readAsString();
    final body = bodyEmail.replaceAll(
        RegExp(r'delivered-to:.*', caseSensitive: false),
        'delivered-to: $address');
    final statusCode = await email.deliverEmail(db, body);
    expect(statusCode, MailSystemStatusCodes.success);
  });
}
