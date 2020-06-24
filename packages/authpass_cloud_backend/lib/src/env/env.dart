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
}
