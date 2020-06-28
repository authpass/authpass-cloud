import 'package:args/command_runner.dart';
import 'package:authpass_cloud_backend/src/env/env.dart';

class VersionCommand extends Command<void> {
  @override
  String get name => 'version';

  @override
  String get description => 'Prints the version and other build information.';

  @override
  Future<void> run() async {
    print(BuildInfo.asString());
  }
}
