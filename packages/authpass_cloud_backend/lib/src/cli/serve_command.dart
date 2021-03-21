import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:authpass_cloud_backend/src/cli/command_runner.dart';
import 'package:authpass_cloud_backend/src/env/config.dart';
import 'package:authpass_cloud_backend/src/env/env.dart';
import 'package:authpass_cloud_backend/src/env/prod.dart';
import 'package:authpass_cloud_backend/src/server.dart';
import 'package:logging/logging.dart';
import 'package:yaml/yaml.dart';

final _logger = Logger('serve_command');

abstract class BaseBackendCommand extends Command<void> {
  BaseBackendCommand() {
    argParser.addOption(
      ARG_CONFIG,
      defaultsTo: '',
      abbr: 'c',
    );
  }

  Future<Env> loadEnv() async {
    final configFile = argResults![ARG_CONFIG] as String;
    if (configFile == '') {
      return DevEnv();
    } else {
      final file = File(configFile);
      if (!file.existsSync()) {
        throw StateError('File not found ${file.absolute}');
      }
//      final config = checkedYamlDecode(
      final config = _loadYaml(
        await file.readAsString(),
        (m) => ConfigFileRoot.fromJson(m!),
        sourceUrl: file.path,
      );

      return ProdEnv(config);
    }
  }

  T _loadYaml<T>(String yamlContent, T Function(Map? map) constructor,
      {required String sourceUrl}) {
    final yamlMap =
        loadYaml(yamlContent, sourceUrl: Uri.parse(sourceUrl)) as Map?;
    return constructor(yamlMap);
  }
}

class ServeCommand extends BaseBackendCommand {
  @override
  final String name = 'serve';

  @override
  final String description = 'Starts the backend server.';

  @override
  Future<void> run() async {
    final env = await loadEnv();
    await env.run();
  }
}

class SetupDbCommand extends BaseBackendCommand {
  @override
  final String name = 'setupdb';

  @override
  final String description = 'Sets up database and runs migration.';

  @override
  Future<void> run() async {
    final env = await loadEnv();
    await Server(env: env).prepareServiceProviderAndDatabase();
    _logger.info('Done.');
  }
}
