import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'package:logging/logging.dart';
import 'package:openapi_base/openapi_base.dart';

final _logger = Logger('client_test');

Future<void> main() async {
  PrintAppender.setupLogging();
  _logger.fine('Starting Client ...');
  final requestSender = HttpRequestSender();
  final client = AuthPassCloudClient(
      Uri.parse('https://virtserver.swaggerhub.com/hpoul/Testapi/1.0.0'),
      requestSender);
  final blubb =
      await client.userRegisterPost(RegisterRequest(email: 'a@b.com'));
  blubb.map(
    on200: (response) => _logger.info('Success! ${response.body.userUuid}'),
  );
  _logger.info('Response: $blubb');
  requestSender.dispose();
}
