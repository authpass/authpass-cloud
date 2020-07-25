import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:authpass_cloud_backend/src/cli/smtpd_command.dart';
import 'package:logging/logging.dart';
import 'package:mailer/mailer.dart' as mailer;
import 'package:mailer/smtp_server.dart' as mailer;

final _logger = Logger('smtpd_healthcheck_command');

const _ARG_PORT = 'port';
const _ARG_HOST = 'host';

class SmtpdHealthCheckCommand extends Command<void> {
  SmtpdHealthCheckCommand() {
    argParser.addOption(_ARG_HOST, defaultsTo: 'localhost');
    argParser.addOption(_ARG_PORT, defaultsTo: '25');
  }

  @override
  String get name => 'smtpd-healthcheck';

  @override
  String get description => 'Checks if smtpd is correctly running';

  @override
  Future<void> run() async {
    try {
      final host = argResults[_ARG_HOST] as String;
      final port = int.parse(argResults[_ARG_PORT] as String);
      final server = mailer.SmtpServer(
        host,
        port: port,
        allowInsecure: true,
      );
      final conn = mailer.PersistentConnection(server);
      final message = mailer.Message()
        ..from = HEALTHCHECK_ADDRESS
        ..recipients.add(HEALTHCHECK_ADDRESS)
        ..subject = 'Health check'
        ..text = 'Health Check';
      try {
        final report = await conn.send(message);
        _logger.fine('Successfully sent mail. $report');
      } catch (e, stackTrace) {
        _logger.warning('Error while sending mail.', e, stackTrace);
        exitCode = 1;
        return;
      } finally {
        await conn.close();
      }

      exitCode = 0;
      exit(0);
    } catch (e, stackTrace) {
      _logger.severe('Error during smtp.', e, stackTrace);
      exitCode = 1;
    }
  }
}
