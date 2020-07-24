import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:authpass_cloud_backend/src/cli/smtpd_command.dart';
import 'package:logging/logging.dart';
import 'package:mailer/mailer.dart' as mailer;
import 'package:mailer/smtp_server.dart' as mailer;

final _logger = Logger('smtpd_healthcheck_command');

class SmtpdHealthCheckCommand extends Command<void> {
  SmtpdHealthCheckCommand() {
    argParser.addOption('port', defaultsTo: '25');
  }

  @override
  String get name => 'smtpd-healthcheck';

  @override
  String get description => 'Checks if smtpd is correctly running';

  @override
  Future<void> run() async {
    try {
      final port = int.parse(argResults['port'] as String);
      final message = mailer.Message()
        ..from = HEALTHCHECK_ADDRESS
        ..recipients.add(HEALTHCHECK_ADDRESS)
        ..subject = 'Health check'
        ..text = 'Health Check';
//      mailer.
      final server = mailer.SmtpServer(
        'localhost',
        port: port,
        allowInsecure: true,
      );
      final report = await mailer.send(message, server);
      _logger.fine('Successfully sent mail. $report');

      exitCode = 0;
      exit(0);
    } catch (e, stackTrace) {
      _logger.severe('Error during smtp.', e, stackTrace);
      exitCode = 1;
    }
  }
}
