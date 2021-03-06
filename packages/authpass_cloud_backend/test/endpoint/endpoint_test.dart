import 'package:authpass_cloud_backend/src/dao/email_repository.dart';
import 'package:authpass_cloud_backend/src/dao/tables/email_tables.dart';
import 'package:authpass_cloud_backend/src/dao/tables/user_tables.dart';
import 'package:authpass_cloud_backend/src/dao/user_repository.dart';
import 'package:authpass_cloud_backend/src/dao/website_repository.dart';
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
        final cryptoService = CryptoService();
        final request = MockOpenApiRequest();
        when(request.headerParameter(argThat(equalsIgnoringCase('user-agent'))))
            .thenReturn(['unit test']);
        final endpoint = AuthPassCloudImpl(
          ServiceProvider(
            env: env,
            cryptoService: cryptoService,
            emailService: MockEmailService(),
            recaptchaService: MockRecaptchaService(),
          ),
          request,
          db,
          UserRepository(db),
          EmailRepository(
            db: db,
            cryptoService: cryptoService,
            env: env,
          ),
          WebsiteRepository(db, cryptoService),
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
  final confirm =
      await db.tables.user.insertUser(endpoint.db, 'a@b.com', 'unit test');
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

Future<ApiUuid> _createMessage(
    AuthPassCloudImpl endpoint, MailboxEntity mailbox) async {
  return await endpoint.db.tables.email.insertMessage(
    endpoint.db,
    mailbox: mailbox,
    sender: 'nobody@example.com',
    subject: 'Lorem',
    message: 'Ipsum',
  );
}

extension on AuthPassCloudImpl {
  Future<void> expectSystemStatus({
    int userConfirmed,
    int emailUnconfirmed,
  }) async {
    final status = await checkStatusPost(
            xSecret: serviceProvider.env.config.secrets.systemStatusSecret)
        .requireSuccess();
    if (userConfirmed != null) {
      expect(status.user.userConfirmed, userConfirmed);
    }
    if (emailUnconfirmed != null) {
      expect(status.user.emailUnconfirmed, emailUnconfirmed);
    }
  }
}

void main() {
  PrintAppender.setupLogging();
  _logger.fine('starting tests...');

  endpointTest('creating user', (endpoint) async {
    await endpoint.expectSystemStatus(userConfirmed: 0, emailUnconfirmed: 0);
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

    await endpoint.expectSystemStatus(userConfirmed: 0, emailUnconfirmed: 1);

    when(endpoint.serviceProvider.recaptchaService.verify(any, any))
        .thenAnswer((realInvocation) async => true);

    await endpoint.emailConfirmPost(
        EmailConfirmPostSchema(token: emailToken, gRecaptchaResponse: ''));

    {
      final status = (await endpoint.emailStatusGet()).requireSuccess();
      expect(status.status, EmailStatusGetResponseBody200Status.confirmed);
    }
    await endpoint.expectSystemStatus(userConfirmed: 1, emailUnconfirmed: 0);
  });

  group('user info', () {
    endpointTest('fetch user info', (endpoint) async {
      await _createUserConfirmed(endpoint);
      final user = await endpoint.userGet().requireSuccess();
      expect(user.emails, hasLength(1));
      expect(user.emails.first.confirmedAt, isNotNull);
    });
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
      final id = await _createMessage(endpoint, mailbox);
      final list = await endpoint.mailboxListGet().requireSuccess();
      expect(list.data, hasLength(1));
      expect(list.data.first.isRead, false);

      await endpoint.mailboxMessageDelete(messageId: id).requireSuccess();

      final l2 = await endpoint.mailboxListGet().requireSuccess();
      expect(l2.data, isEmpty);
    });
    endpointTest('mark all read', (endpoint) async {
      final mailbox = await _createUserWithMailbox(endpoint);
      await _createMessage(endpoint, mailbox);
      await _createMessage(endpoint, mailbox);
      await _createMessage(endpoint, mailbox);
      await _createMessage(endpoint, mailbox);
      final status = await endpoint.statusGet().requireSuccess();
      expect(status.mail.messagesUnread, 4);
      await endpoint
          .mailMassupdatePost(MailMassupdatePostSchema(
              filter: MailMassupdatePostSchemaFilter.all, isRead: true))
          .requireSuccess();
      final statusAfter = await endpoint.statusGet().requireSuccess();
      expect(statusAfter.mail.messagesUnread, 0);
    });
  });

  group('stats endpoint', () {
    endpointTest('request stats', (endpoint) async {
      final mailbox = await _createUserWithMailbox(endpoint);
      await _createMessage(endpoint, mailbox);
      final id = await _createMessage(endpoint, mailbox);
      await endpoint.mailboxMessageMarkRead(messageId: id);
      final status = await endpoint
          .checkStatusPost(
              xSecret: endpoint
                  .serviceProvider.env.config.secrets.systemStatusSecret)
          .requireSuccess();
      expect(status.mailbox.messageCount, 2);
      expect(status.mailbox.messageReadCount, 1);
      expect(status.queryTime, inInclusiveRange(1, 1000));
    });
  });
}
