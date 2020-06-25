import 'package:authpass_cloud_backend/src/env/env.dart';
import 'package:authpass_cloud_backend/src/env/secrets.dart' as prodSecrets;

class ProdEnv extends Env {
  @override
  bool get debug => throw UnimplementedError();

  @override
  String get help => 'Production environment';

  @override
  final Uri baseUri = Uri.parse('https://cloud.authpass.app');

  @override
  EnvSecrets get secrets => prodSecrets.ProdSecrets();

  @override
  EmailConfig get email => prodSecrets.prodEmailConfig;
}

Future<void> main() async => await ProdEnv().run();
