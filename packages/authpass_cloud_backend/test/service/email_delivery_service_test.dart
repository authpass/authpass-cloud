import 'dart:io';

import 'package:authpass_cloud_backend/src/service/email_delivery_service.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:test/test.dart';

void main() {
  PrintAppender.setupLogging();
  test('Deliver email', () async {
    final email = EmailDeliveryService();
    final body = await File('test/service/email_example.txt').readAsString();
    await email.deliverEmail(null, body);
  });
}
