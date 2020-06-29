import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:authpass_cloud_backend/src/mail/mail_system_status_codes.dart';
import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:logging/logging.dart';
import 'package:openapi_base/openapi_base.dart';

final _logger = Logger('email_command');

/// Expected to be called using postfix local delivery
/// http://www.postfix.org/local.8.html
class EmailReceiveCommand extends Command<void> {
  EmailReceiveCommand() {
    argParser.addOption(
      ARG_BACKEND_URL,
      help: 'Base URL to backend. (required)',
      valueHelp: 'URL',
    );
    argParser.addOption(
      ARG_SECRET_TOKEN,
      help: 'Secret token to identify with backend. (required)',
      valueHelp: 'XXX',
    );
  }

  static const ARG_BACKEND_URL = 'backend';
  static const ARG_SECRET_TOKEN = 'token';

  @override
  String get name => 'email-receive';

  @override
  String get description => 'Receives email and delivers it to http endpoint';

  @override
  Future<void> run() async {
    final backend = argResults[ARG_BACKEND_URL] as String;
    final token = argResults[ARG_SECRET_TOKEN] as String;
    if (backend == null) {
      usageException('Required parameter $ARG_BACKEND_URL missing.');
    }
    if (token == null) {
      usageException('Required parameter $ARG_SECRET_TOKEN missing.');
    }

    _logger.finer('Reading body ..');
    final body = await utf8.decodeStream(stdin);
    _logger.fine('Got body ${body.length}');

    final requestSender = HttpRequestSender();
    final client = AuthPassCloudClient(Uri.parse(backend), requestSender);
    try {
      final response = await client.emailReceivePost(
        body,
        xAuthpassToken: token,
      );
      response.map(
        on200: (responses) {
          print(MailSystemStatusCodes.success.toString());
          print('Successfully delivered email message.');
        },
        on403: (response) {
          print(response.body);
        },
      );
    } catch (e, stackTrace) {
      print(MailSystemStatusCodes.errorNetworkMisc.toString());
      _logger.severe('Error while sending request.', e, stackTrace);
      exit(255);
    } finally {
      requestSender.dispose();
    }
  }
}
