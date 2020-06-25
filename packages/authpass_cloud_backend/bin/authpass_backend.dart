import 'dart:io';

import 'package:args/args.dart';
import 'package:authpass_cloud_backend/src/env/config.dart';
import 'package:authpass_cloud_backend/src/env/env.dart';
import 'package:authpass_cloud_backend/src/env/prod.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:yaml/yaml.dart';

final _logger = Logger('server');

const ARG_CONFIG = 'config';
const ARG_HELP = 'help';

Future<void> main(List<String> args) async {
  PrintAppender.setupLogging();
  _logger.finer('Starting…');

  final parser = ArgParser()
    ..addOption(
      ARG_CONFIG,
      defaultsTo: '',
      abbr: 'c',
    )
    ..addFlag(ARG_HELP, abbr: 'h');
  final result = parser.parse(args);
  final configFile = result[ARG_CONFIG] as String;
  if (result[ARG_HELP] as bool) {
    print(parser.usage);
    exit(1);
  }
  if (configFile == '') {
    await DevEnv().run();
  } else {
    final file = File(configFile);
    if (!file.existsSync()) {
      throw StateError('File not found ${file.absolute}');
    }
    final configYaml = loadYaml(await file.readAsString()) as Map;
    final config = ConfigFileRoot.fromJson(configYaml);
    await ProdEnv(config).run();
  }

//  final server = Server([AuthPassCloudService()]);
//  await server.serve(port: 50051);
//  print('Server listening on port ${server.port}...');
}
