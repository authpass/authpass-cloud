import 'package:authpass_cloud_backend/src/server.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

final _logger = Logger('env');

abstract class EmailConfig {}

class DummyEmailConfig implements EmailConfig {}

class EmailSmtpConfig implements EmailConfig {
  EmailSmtpConfig({
    @required this.smtpHost,
    this.smtpPort,
    this.smtpSsl,
    this.smtpUsername,
    this.smtpPassword,
    this.smtpAllowInsecure = false,
    @required this.fromAddress,
    this.fromName,
  })  : assert(smtpHost != null),
        assert(fromAddress != null),
        assert(smtpAllowInsecure != null);

  final String smtpHost;
  final int smtpPort;
  final bool smtpSsl;
  final String smtpUsername;
  final String smtpPassword;
  final bool smtpAllowInsecure;
  final String fromAddress;
  final String fromName;
}

abstract class EnvSecrets {
  String get recaptchaSiteKey;
  String get recaptchaSecretKey;
}

class EmptySecrets extends EnvSecrets {
  @override
  String get recaptchaSecretKey => '';

  @override
  String get recaptchaSiteKey => '';
}

abstract class Env {
  Env() {
    assert((() {
      assertEnabled = true;
      return true;
    })());
    if (!assertEnabled && debug) {
      _logger.warning(
          'Assertions are disabled, but you still use dev environment!');
    }
  }

  EmailConfig get email;

  bool assertEnabled = false;

  bool get debug;

  /// help text displayed in the command line help.
  String get help;

  Uri get baseUri;

  EnvSecrets get secrets;

  Future<void> run() async {
    await Server(env: this).run();
  }
}

class DevEnv extends Env {
  @override
  bool get debug => true;

  @override
  String get help => 'Development environment';

  @override
  final Uri baseUri = Uri.parse('https://cloud.authpass.app');

  @override
  EnvSecrets get secrets => EmptySecrets();

  @override
  EmailConfig get email => DummyEmailConfig();
}
