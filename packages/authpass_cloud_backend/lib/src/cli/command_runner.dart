import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:authpass_cloud_backend/src/cli/email_command.dart';
import 'package:authpass_cloud_backend/src/cli/http_command.dart';
import 'package:authpass_cloud_backend/src/cli/serve_command.dart';
import 'package:authpass_cloud_backend/src/cli/smtpd_command.dart';
import 'package:authpass_cloud_backend/src/cli/version_command.dart';
import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:openapi_base/openapi_base.dart';

final _logger = Logger('command_runner');

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
      ..addCommand(ServeCommand())
      ..addCommand(SmtpdCommand())
      ..addCommand(SetupDbCommand());
  }

  @override
  Future<void> runCommand(ArgResults topLevelResults) async {
    if (topLevelResults[ARG_QUIET] as bool) {
      PrintAppender.setupLogging(level: Level.SEVERE);
    } else {
      PrintAppender.setupLogging();
      _logger.finer('Starting…');
    }
    return await super.runCommand(topLevelResults);
  }
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
