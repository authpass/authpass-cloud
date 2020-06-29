import 'package:authpass_cloud_backend/src/dao/email_repository.dart';
import 'package:authpass_cloud_backend/src/dao/user_repository.dart';
import 'package:authpass_cloud_backend/src/endpoint/authpass_endpoint.dart';
import 'package:authpass_cloud_backend/src/env/env.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:authpass_cloud_backend/src/service/email_service.dart';
import 'package:authpass_cloud_backend/src/service/recaptcha_service.dart';
import 'package:authpass_cloud_backend/src/service/service_provider.dart';
import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:openapi_base/openapi_base.dart';
import 'package:test/test.dart';

import '../test_utils.dart';

final _logger = Logger('endpoint_test');

//class ServiceProviderMock extends Mock implements ServiceProvider {
//
//}

class MockOpenApiRequest extends Mock implements OpenApiRequest {}

class MockEmailService extends Mock implements EmailService {}

class MockRecaptchaService extends Mock implements RecaptchaService {}

@isTest
void endpointTest(String description,
    Future<void> Function(AuthPassCloudImpl endpoint) body) {
  test(description, () async {
    final db = await TestUtils.setUpDatabase();
    try {
      await db.run((db) async {
        final env = DevEnv();
        final endpoint = AuthPassCloudImpl(
          ServiceProvider(
            env: env,
            cryptoService: CryptoService(),
            emailService: MockEmailService(),
            recaptchaService: MockRecaptchaService(),
          ),
          MockOpenApiRequest(),
          db,
          UserRepository(db),
          EmailRepository(
            db: db,
            cryptoService: CryptoService(),
            env: env,
          ),
        );
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
    final registerResponse =
        await endpoint.userRegisterPost(RegisterRequest(email: 'a@b.com'));
    final captured =
        verify(emailService.sendEmailConfirmationToken(captureAny, captureAny))
            .captured;
    expect(captured, ['a@b.com', matches('^http.+')]);
    final emailToken =
        Uri.parse(captured[1] as String).queryParameters['token'];
    verifyNoMoreInteractions(emailService);

    when(endpoint.request.headerParameter('Authorization'))
        .thenReturn(['Bearer ${registerResponse.requireSuccess().authToken}']);

    {
      final status = (await endpoint.emailStatusGet()).requireSuccess();
      expect(status.status, EmailStatusGetResponseBody200Status.created);
    }

    when(endpoint.serviceProvider.recaptchaService.verify(any, any))
        .thenAnswer((realInvocation) async => true);

    await endpoint.emailConfirmPost(
        EmailConfirmSchema(token: emailToken, gRecaptchaResponse: ''));

    {
      final status = (await endpoint.emailStatusGet()).requireSuccess();
      expect(status.status, EmailStatusGetResponseBody200Status.confirmed);
    }
  });
}
