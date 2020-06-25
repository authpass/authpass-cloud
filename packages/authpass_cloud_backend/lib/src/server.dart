import 'package:authpass_cloud_backend/src/dao/user_repository.dart';
import 'package:authpass_cloud_backend/src/endpoint/authpass_endpoint.dart';
import 'package:authpass_cloud_backend/src/env/env.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:authpass_cloud_backend/src/service/email_service.dart';
import 'package:authpass_cloud_backend/src/service/service_provider.dart';
import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:openapi_base/openapi_base.dart';

final _logger = Logger('server');

class Server {
  Server({@required this.env}) : assert(env != null);

  final Env env;

  Future<void> run() async {
    PrintAppender.setupLogging();
    _logger.fine('Starting Server ...');

    final serviceProvider = ServiceProvider(
      env: env,
      cryptoService: CryptoService(),
      emailService: _createEmailService(env),
    );

    final db = serviceProvider.createDatabaseAccess();
    await db.prepareDatabase();

    final server = OpenApiShelfServer(
        AuthPassCloudRouter(AuthPassEndpointProvider(serviceProvider)));
    server.startServer();
  }

  EmailService _createEmailService(Env env) {
    if (env.email is EmailSmtpConfig) {
      return MailerEmailService(config: env.email as EmailSmtpConfig);
    }
    return FakeEmailService();
  }
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
          UserRepository(conn),
        ));
      });
    } finally {
      await db.dispose();
    }
  }
}
