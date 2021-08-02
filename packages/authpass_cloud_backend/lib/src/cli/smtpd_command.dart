import 'dart:io';

import 'package:authpass_cloud_backend/src/cli/serve_command.dart';
import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/env/env.dart';
import 'package:authpass_cloud_backend/src/server.dart';
import 'package:authpass_cloud_backend/src/service/service_provider.dart';
import 'package:logging/logging.dart';
import 'package:smtpd/smtpd.dart';

final _logger = Logger('smtpd_command');

const healthCheckLocal = 'HealthCheck';
const healthCheckHost = 'mail.authpass.app';
final healthCheckPattern = RegExp([
  RegExp.escape(healthCheckLocal),
  r'-([a-z0-9\-\.]+)@',
  RegExp.escape(healthCheckHost)
].join(''));
String healthcheckAddress([String? prefix = '']) =>
    '$healthCheckLocal-$prefix${DateTime.now().millisecondsSinceEpoch}'
    '@$healthCheckHost';

class SmtpdCommand extends BaseBackendCommand {
  SmtpdCommand() {
    argParser.addOption(
      'port',
      abbr: 'p',
      help: 'Port to bind to.',
      defaultsTo: '25',
    );
    argParser.addOption(
      'hostname',
      help: 'Local hostname to announce to clients.',
      defaultsTo: Platform.localHostname,
    );
  }

  @override
  final String name = 'smtpd';

  @override
  final String description = 'Launch smtp daemon process to receive mails.';

  @override
  Future<void> run() async {
    final argResults = ArgumentError.checkNotNull(this.argResults);
    final port = int.parse(argResults['port'] as String);
    final hostname = argResults['hostname'] as String;

    final env = await loadEnv();

    await SmtpBackendServer(
        env: env,
        config: SmtpConfig(
          address: InternetAddress.anyIPv4,
          port: port,
          hostname: hostname,
        )).start();
  }
}

class SmtpBackendServer extends BackendServer {
  SmtpBackendServer({required Env env, required this.config}) : super(env: env);

  final SmtpConfig config;

  Future<void> start() async {
    _logger.fine('Starting smtpd. healthcheck: ${healthCheckPattern.pattern}');
    final serviceProvider = await prepareServiceProviderAndDatabase();
    final server = SmtpServer(
      config,
      mailHandler: AuthPassMailHandler(
        serviceProvider,
        serviceProvider.createDatabaseAccess(),
      ),
    );

    await server.start();
  }
}

class AuthPassMailHandler extends MailHandler {
  AuthPassMailHandler(this.serviceProvider, this.databaseAccess);

  final ServiceProvider serviceProvider;
  final DatabaseAccess databaseAccess;

  @override
  Future<SmtpStatusMessage> handleMail(
      SmtpClient client, MailObject mailObject) async {
    if (healthCheckPattern.hasMatch(mailObject.envelope.recipient.first)) {
      return SmtpStatusMessage.successCompleted;
    }
    return await databaseAccess.run((db) async {
      for (final recipient in mailObject.envelope.recipient) {
        await serviceProvider.emailDeliveryService.deliverEmailTo(
          db,
          sender: mailObject.envelope.sender,
          recipient: recipient,
          content: mailObject.content ?? '',
        );
      }
      return SmtpStatusMessage.successCompleted;
    });
  }

  @override
  Future<SmtpStatusMessage> verifyAddress(
      SmtpClient client, String address) async {
    return await databaseAccess.run((db) async {
      if (!await serviceProvider.emailDeliveryService
          .verifyAddressValid(db, address)) {
        if (healthCheckPattern.hasMatch(address)) {
          return SmtpStatusMessage.successCompleted;
        }

        return SmtpStatusMessage.errorMailboxUnavailable;
      }
      return SmtpStatusMessage.successCompleted;
    });
  }
}
