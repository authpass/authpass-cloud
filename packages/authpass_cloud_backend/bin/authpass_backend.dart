import 'package:args/args.dart';
import 'package:authpass_cloud_backend/src/env/env.dart';
import 'package:authpass_cloud_backend/src/env/prod.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

final _logger = Logger('server');

const ARG_ENV = 'env';

Future<void> main(List<String> args) async {
  PrintAppender.setupLogging();
  _logger.finer('Starting…');

  final environments = {
    'prod': ProdEnv(),
    'dev': DevEnv(),
  };
  final parser = ArgParser()
    ..addOption(
      ARG_ENV,
      defaultsTo: 'dev',
      allowed: environments.keys,
      allowedHelp: environments.map((key, value) => MapEntry(key, value.help)),
    );
  final result = parser.parse(args);
  final env = environments[result[ARG_ENV]];

  await env.run();

//  final server = Server([AuthPassCloudService()]);
//  await server.serve(port: 50051);
//  print('Server listening on port ${server.port}...');
}
