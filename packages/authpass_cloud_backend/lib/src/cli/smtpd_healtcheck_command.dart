import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:enough_mail/enough_mail.dart';

import 'package:logging/logging.dart';

final _logger = Logger('smtpd_healtcheck_command');

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
      final client = SmtpClient('healthcheck.localhost');
      final response =
          await client.connectToServer('localhost', port, isSecure: false);
      _logger.fine('Connection response: ${response.debugString}');
      final ehloResponse = await client.ehlo();
      _logger.fine('ehlo response: ${ehloResponse.debugString}');
      await client.quit();
      exitCode = 0;
      exit(0);
    } catch (e, stackTrace) {
      _logger.severe('Error during smtp.', e, stackTrace);
      exitCode = 1;
    }
  }
}

extension on SmtpResponse {
  String get debugString =>
      '${responseLines.map((e) => e.debugString).join('\n')}';
}

extension on SmtpResponseLine {
  String get debugString => '$type $code $message';
}
