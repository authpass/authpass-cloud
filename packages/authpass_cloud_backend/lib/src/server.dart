import 'dart:io';

import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/dao/email_repository.dart';
import 'package:authpass_cloud_backend/src/dao/filecloud_repository.dart';
import 'package:authpass_cloud_backend/src/dao/user_repository.dart';
import 'package:authpass_cloud_backend/src/dao/website_repository.dart';
import 'package:authpass_cloud_backend/src/endpoint/authpass_endpoint.dart';
import 'package:authpass_cloud_backend/src/env/config.dart';
import 'package:authpass_cloud_backend/src/env/env.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:authpass_cloud_backend/src/service/email_service.dart';
import 'package:authpass_cloud_backend/src/service/service_provider.dart';
import 'package:authpass_cloud_backend/src/util/cors_middleware.dart';
import 'package:authpass_cloud_backend/src/util/header_middleware.dart';
import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:openapi_base/openapi_base.dart';

final _logger = Logger('server');

class BackendServer {
  BackendServer({required this.env});

  final Env env;

  Future<ServiceProvider> prepareServiceProviderAndDatabase() async {
    final serviceProvider = ServiceProvider(
      env: env,
      cryptoService: CryptoService(),
      emailService: _createEmailService(env),
    );

    final db = serviceProvider.createDatabaseAccess();
    await db.prepareDatabase();
    await db.dispose();
    return serviceProvider;
  }

  EmailService _createEmailService(Env env) {
    if (env.config.email.smtp is EmailSmtpConfig) {
      return MailerEmailService(emailConfig: env.config.email);
    }
    if (!env.assertEnabled) {
      throw StateError('Assertions are not enabled, '
          'no fake email service allowed.');
    }
    return FakeEmailService();
  }
}

class Server extends BackendServer {
  Server({required Env env}) : super(env: env);

  Future<void> run() async {
    PrintAppender.setupLogging();
    _logger.fine('Starting Server ... ${BuildInfo.asString()}');

    final serviceProvider = await prepareServiceProviderAndDatabase();

    final server = OpenApiShelfServer(
      AuthPassCloudRouter(AuthPassEndpointProvider(serviceProvider)),
      customizePipeline: (pipeline) => pipeline
          .addMiddleware(customizeHeaders({
            HttpHeaders.serverHeader: 'AuthPass Cloud',
          }))
          .addMiddleware(
            corsHeaders(
              headers: {
                ACCESS_CONTROL_EXPOSE_HEADERS: [
                  'etag',
                ]
              },
              originChecker: originOneOfPrefix([
                'https://web.authpass.app',
                'https://authpass.github.io',
                // FIXME remove localhost.
                'http://localhost',
              ]),
            ),
          ),
    );
    final process = await server.startServer(
      address: env.config.http.host,
      port: env.config.http.port,
    );
    final exitCode = await process.exitCode;
    _logger.fine('exitCode from server: $exitCode');
  }
}

class RepositoryProviderImpl extends RepositoryProvider {
  RepositoryProviderImpl(this.serviceProvider, this.db);
  final DatabaseTransaction db;
  final ServiceProvider serviceProvider;

  @override
  late final EmailRepository email = EmailRepository(
    db: db,
    cryptoService: serviceProvider.cryptoService,
    env: serviceProvider.env,
  );
  @override
  late final FileCloudRepository fileCloud = FileCloudRepository(
    db: db,
    cryptoService: serviceProvider.cryptoService,
    env: serviceProvider.env,
  );
  @override
  late final UserRepository user = UserRepository(db);
  @override
  late final WebsiteRepository website =
      WebsiteRepository(db, serviceProvider.cryptoService);
}

class AuthPassEndpointProvider extends ApiEndpointProvider<AuthPassCloudImpl> {
  AuthPassEndpointProvider(this.serviceProvider);

  final ServiceProvider serviceProvider;

  @override
  Future<U> invoke<U>(request, callback) async {
    final db = serviceProvider.createDatabaseAccess();
    try {
      return await db.run((conn) async {
        return await callback(AuthPassCloudImpl(
          serviceProvider,
          request,
          conn,
          RepositoryProviderImpl(serviceProvider, conn),
        ));
      });
    } finally {
      await db.dispose();
    }
  }
}
