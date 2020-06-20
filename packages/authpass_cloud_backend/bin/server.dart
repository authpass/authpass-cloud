import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/service/authpass_service.dart';
import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'package:logging/logging.dart';
import 'package:openapi_base/openapi_base.dart';

final _logger = Logger('server');

Future<void> main(List<String> args) async {
  PrintAppender.setupLogging();
  final db = DatabaseAccess();
  await db.prepareDatabase();
  _logger.fine('Starting Server ...');
  final server = OpenApiShelfServer(
      AuthPassCloudRouter(AuthPassServiceProvider())..configure());
  server.startServer();
//  final server = Server([AuthPassCloudService()]);
//  await server.serve(port: 50051);
//  print('Server listening on port ${server.port}...');
}

class AuthPassServiceProvider extends ServiceProvider<AuthPassCloudImpl> {
  @override
  Future<U> invoke<U>(cb) async {
    final db = DatabaseAccess();
    try {
      return await db.run((conn) async {
        return await cb(AuthPassCloudImpl(conn));
      });
    } finally {
      await db.dispose();
    }
  }
}
