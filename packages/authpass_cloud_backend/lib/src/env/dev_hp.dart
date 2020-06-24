import 'package:authpass_cloud_backend/src/env/env.dart';
import 'package:authpass_cloud_backend/src/env/secrets.dart';

class DevHpEnv extends DevEnv {
  @override
  EnvSecrets get secrets => ProdSecrets();
}

Future<void> main() async => await DevHpEnv().run();
