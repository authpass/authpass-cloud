import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/dao/user_repository.dart';
import 'package:authpass_cloud_backend/src/endpoint/authpass_endpoint.dart';
import 'package:authpass_cloud_backend/src/env/env.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:authpass_cloud_backend/src/service/email_service.dart';
import 'package:authpass_cloud_backend/src/service/service_provider.dart';
import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:openapi_base/openapi_base.dart';

final _logger = Logger('server');

class Server {
  Server({@required this.env}) : assert(env != null);

  final Env env;

  Future<void> run() async {
    _logger.fine('Starting Server ...');

    final serviceProvider = ServiceProvider(
      cryptoService: CryptoService(),
      emailService: FakeEmailService(),
    );

    final db = DatabaseAccess(cryptoService: serviceProvider.cryptoService);
    await db.prepareDatabase();

    final server = OpenApiShelfServer(
        AuthPassCloudRouter(AuthPassEndpointProvider(serviceProvider))
          ..configure());
    server.startServer();
  }
}

class AuthPassEndpointProvider extends ApiEndpointProvider<AuthPassCloudImpl> {
  AuthPassEndpointProvider(this.serviceProvider);

  final ServiceProvider serviceProvider;

  @override
  Future<U> invoke<U>(callback) async {
    final db = DatabaseAccess(
      cryptoService: serviceProvider.cryptoService,
    );
    try {
      return await db.run((conn) async {
        return await callback(AuthPassCloudImpl(
          serviceProvider,
          conn,
          UserRepository(conn),
        ));
      });
    } finally {
      await db.dispose();
    }
  }
}
