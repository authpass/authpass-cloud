import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:authpass_cloud_backend/src/cli/email_command.dart';
import 'package:authpass_cloud_backend/src/cli/http_command.dart';
import 'package:authpass_cloud_backend/src/cli/version_command.dart';
import 'package:authpass_cloud_backend/src/env/config.dart';
import 'package:authpass_cloud_backend/src/env/env.dart';
import 'package:authpass_cloud_backend/src/env/prod.dart';
import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:openapi_base/openapi_base.dart';
import 'package:yaml/yaml.dart';

final _logger = Logger('server');

const ARG_CONFIG = 'config';
const ARG_QUIET = 'quiet';

class MainCommandRunner extends CommandRunner<void> {
  MainCommandRunner() : super('authpass_backend', 'Backend server') {
    this
      ..argParser.addFlag(
        ARG_QUIET,
        abbr: 'q',
        help: 'No debug output.',
      )
      ..addCommand(HealthCheckCommand())
      ..addCommand(HttpCommand())
      ..addCommand(EmailReceiveCommand())
      ..addCommand(VersionCommand())
      ..addCommand(ServeCommand());
  }

  @override
  Future<void> runCommand(ArgResults argResults) async {
    if (argResults[ARG_QUIET] as bool) {
      PrintAppender.setupLogging(level: Level.SEVERE);
    } else {
      PrintAppender.setupLogging();
      _logger.finer('Starting…');
    }
    return await super.runCommand(argResults);
  }
}

Future<void> main(List<String> args) async {
  try {
    await MainCommandRunner().run(args);
  } on UsageException catch (e) {
    print(e);
    exit(64);
  }

//  final server = Server([AuthPassCloudService()]);
//  await server.serve(port: 50051);
//  print('Server listening on port ${server.port}...');
}

class HealthCheckCommand extends Command<void> {
  HealthCheckCommand() {
    argParser.addOption(
      'url',
      help: 'Base Url of the backend server',
      defaultsTo: 'http://localhost:8080',
    );
  }

  @override
  final String name = 'healthcheck';

  @override
  final String description = 'Sends a check http request to the server.';

  @override
  Future<void> run() async {
    final baseUri = argResults['url'] as String;
    final requestSender = HttpRequestSender();
    try {
      final client = AuthPassCloudClient(Uri.parse(baseUri), requestSender);
      final response = await client.checkGet();
      if (response.status == 200) {
        _logger.finest('All good.');
        exitCode = 0;
      } else {
        _logger.warning('No success response. ${response.status}');
        exitCode = 1;
      }
    } catch (e, stackTrace) {
      _logger.severe('Error during health check', e, stackTrace);
      exitCode = 1;
    } finally {
      requestSender.dispose();
    }
  }
}

class ServeCommand extends Command<void> {
  ServeCommand() {
    argParser.addOption(
      ARG_CONFIG,
      defaultsTo: '',
      abbr: 'c',
    );
  }
  @override
  final String name = 'serve';

  @override
  final String description = 'Starts the backend server.';

  @override
  Future<void> run() async {
    final configFile = argResults[ARG_CONFIG] as String;
    if (configFile == '') {
      await DevEnv().run();
    } else {
      final file = File(configFile);
      if (!file.existsSync()) {
        throw StateError('File not found ${file.absolute}');
      }
//      final config = checkedYamlDecode(
      final config = _loadYaml(
        await file.readAsString(),
        (m) => ConfigFileRoot.fromJson(m),
        sourceUrl: file.path,
      );

      await ProdEnv(config).run();
    }
  }

  T _loadYaml<T>(String yamlContent, T Function(Map map) constructor,
      {String sourceUrl}) {
    final yamlMap = loadYaml(yamlContent, sourceUrl: sourceUrl) as Map;
    return constructor(yamlMap);
  }
}
