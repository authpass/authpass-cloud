import 'package:authpass_cloud_backend/src/env/config.dart';
import 'package:authpass_cloud_backend/src/server.dart';
import 'package:logging/logging.dart';

final _logger = Logger('env');

abstract class EnvSecrets {
  String get recaptchaSiteKey;
  String get recaptchaSecretKey;
}

class EmptySecrets extends SecretsConfig {
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

  bool assertEnabled = false;

  bool get debug;

  Uri get baseUri;

  ConfigFileRoot get config;

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
  final config = ConfigFileRoot(
      http: HttpConfig.defaults(),
      email: EmailConfig(
        fromAddress: 'fake@address.com',
      ),
      secrets: EmptySecrets(),
      database: DatabaseConfig.defaults());
}
