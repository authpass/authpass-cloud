import 'package:authpass_cloud_backend/src/env/env.dart';
import 'package:authpass_cloud_backend/src/env/secrets.dart';

class ProdEnv extends Env {
  @override
  bool get debug => throw UnimplementedError();

  @override
  String get help => 'Production environment';

  @override
  final Uri baseUri = Uri.parse('https://cloud.authpass.app');

  @override
  EnvSecrets get secrets => ProdSecrets();
}

Future<void> main() async => await ProdEnv().run();
