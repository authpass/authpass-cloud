import 'package:authpass_cloud_backend/src/env/config.dart';
import 'package:authpass_cloud_backend/src/env/env.dart';

class ProdEnv extends Env {
  ProdEnv(this.config);

  final ConfigFileRoot config;

  @override
  bool get debug => false;

  @override
  final Uri baseUri = Uri.parse('https://cloud.authpass.app');

  @override
  EnvSecrets get secrets => config.secrets;

  @override
  EmailConfig get email => config.email;
}
