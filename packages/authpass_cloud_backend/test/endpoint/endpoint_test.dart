import 'package:authpass_cloud_backend/src/dao/email_repository.dart';
import 'package:authpass_cloud_backend/src/dao/tables/email_tables.dart';
import 'package:authpass_cloud_backend/src/dao/tables/user_tables.dart';
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

Future<AuthTokenEntity> _createUserConfirmed(AuthPassCloudImpl endpoint) async {
  final db = endpoint.db;
  final confirm = await db.tables.user.insertUser(endpoint.db, 'a@b.com');
  await endpoint.userRepository.confirmEmailAddress(confirm.token);
  when(endpoint.request.headerParameter('Authorization'))
      .thenReturn(['Bearer ${confirm.authToken.token}']);
  return confirm.authToken;
}

Future<MailboxEntity> _createUserWithMailbox(AuthPassCloudImpl endpoint) async {
  final authToken = await _createUserConfirmed(endpoint);
  const address = 'x@mail.authpass.app';
  await endpoint.db.tables.email.insertMailbox(
    endpoint.db,
    userEntity: authToken.user,
    label: '',
    address: address,
    clientEntryUuid: '',
  );
  return endpoint.db.tables.email.findMailbox(endpoint.db, address: address);
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
        EmailConfirmPostSchema(token: emailToken, gRecaptchaResponse: ''));

    {
      final status = (await endpoint.emailStatusGet()).requireSuccess();
      expect(status.status, EmailStatusGetResponseBody200Status.confirmed);
    }
  });

  group('Email', () {
    endpointTest('list emails', (endpoint) async {
      final mailbox = await _createUserWithMailbox(endpoint);
      await endpoint.db.tables.email.insertMessage(
        endpoint.db,
        mailbox: mailbox,
        sender: 'nobody@example.com',
        subject: 'Lorem',
        message: 'Ipsum',
      );

      final list = await endpoint.mailboxListGet().requireSuccess();
      expect(list.data, hasLength(1));
    });
    endpointTest('fetch email body', (endpoint) async {
      final mailbox = await _createUserWithMailbox(endpoint);
      final id = await endpoint.db.tables.email.insertMessage(
        endpoint.db,
        mailbox: mailbox,
        sender: 'nobody@example.com',
        subject: 'Lorem',
        message: 'Ipsum',
      );

      final body =
          await endpoint.mailboxMessageGet(messageId: id).requireSuccess();
      expect(body, 'Ipsum');
    });
    endpointTest('mark as read', (endpoint) async {
      final mailbox = await _createUserWithMailbox(endpoint);
      final id = await endpoint.db.tables.email.insertMessage(
        endpoint.db,
        mailbox: mailbox,
        sender: 'nobody@example.com',
        subject: 'Lorem',
        message: 'Ipsum',
      );

      final list = await endpoint.mailboxListGet().requireSuccess();
      expect(list.data, hasLength(1));
      expect(list.data.first.isRead, false);

      await endpoint.mailboxMessageMarkRead(messageId: id).requireSuccess();

      final l2 = await endpoint.mailboxListGet().requireSuccess();
      expect(l2.data.single.isRead, true);

      await endpoint.mailboxMessageMarkUnRead(messageId: id).requireSuccess();

      final l3 = await endpoint.mailboxListGet().requireSuccess();
      expect(l3.data.single.isRead, false);
    });
    endpointTest('delete message', (endpoint) async {
      final mailbox = await _createUserWithMailbox(endpoint);
      final id = await endpoint.db.tables.email.insertMessage(
        endpoint.db,
        mailbox: mailbox,
        sender: 'nobody@example.com',
        subject: 'Lorem',
        message: 'Ipsum',
      );

      final list = await endpoint.mailboxListGet().requireSuccess();
      expect(list.data, hasLength(1));
      expect(list.data.first.isRead, false);

      await endpoint.mailboxMessageDelete(messageId: id).requireSuccess();

      final l2 = await endpoint.mailboxListGet().requireSuccess();
      expect(l2.data, isEmpty);
    });
  });
}
