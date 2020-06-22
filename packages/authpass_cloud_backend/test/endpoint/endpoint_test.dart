import 'package:authpass_cloud_backend/src/dao/user_repository.dart';
import 'package:authpass_cloud_backend/src/endpoint/authpass_endpoint.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:authpass_cloud_backend/src/service/email_service.dart';
import 'package:authpass_cloud_backend/src/service/service_provider.dart';
import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../test_utils.dart';

final _logger = Logger('endpoint_test');

//class ServiceProviderMock extends Mock implements ServiceProvider {
//
//}

class MockEmailService extends Mock implements EmailService {}

@isTest
void endpointTest(String description,
    Future<void> Function(AuthPassCloudImpl endpoint) body) {
  test(description, () async {
    final db = await TestUtils.setUpDatabase();
    try {
      await db.run((db) async {
        final endpoint = AuthPassCloudImpl(
            ServiceProvider(
                cryptoService: CryptoService(),
                emailService: MockEmailService()),
            db,
            UserRepository(db));
        await body(endpoint);
      });
    } finally {
      await TestUtils.tearDown(db);
    }
  });
}

void main() {
  PrintAppender.setupLogging();
  _logger.fine('starting tests...');

  endpointTest('creating user', (endpoint) async {
    final emailService = endpoint.serviceProvider.emailService;
    await endpoint.userRegisterPost(RegisterRequest(email: 'a@b.com'));
    final captured =
        verify(emailService.sendEmailConfirmationToken(captureAny, any))
            .captured;
    expect(captured, ['a@b.com']);
    verifyNoMoreInteractions(emailService);
  });
}
