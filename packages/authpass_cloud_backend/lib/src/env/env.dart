import 'package:authpass_cloud_backend/src/env/config.dart';
import 'package:authpass_cloud_backend/src/server.dart';
import 'package:logging/logging.dart';

final _logger = Logger('env');

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
  final Uri baseUri = Uri.parse('https://cloud.authpass.app');

  @override
  EnvSecrets get secrets => EmptySecrets();

  @override
  EmailConfig get email => EmailConfig(
        fromAddress: 'fake@address.com',
      );
}
