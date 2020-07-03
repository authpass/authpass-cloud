import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:authpass_cloud_backend/src/cli/command_runner.dart';

Future<void> main(List<String> args) async {
  try {
    await MainCommandRunner().run(args);
  } on UsageException catch (e) {
    print(e);
    exit(64);
  }

//  final server = Server([AuthPassCloudService()]);
//  await server.serve(port: 50051);
//  print('Server listening on port ${server.port}...');
}
