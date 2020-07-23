import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'package:logging/logging.dart';
import 'package:openapi_base/openapi_base.dart';

final _logger = Logger('client_test');

Future<void> main() async {
  PrintAppender.setupLogging();
  _logger.fine('Starting Client ...');
  final requestSender = HttpRequestSender();
//  const baseUri = 'https://virtserver.swaggerhub.com/hpoul/Testapi/1.0.0';
  const baseUri = 'https://cloud.authpass.app';
  final client = AuthPassCloudClient(Uri.parse(baseUri), requestSender);
  final registerResponse = (await client
          .userRegisterPost(RegisterRequest(email: 'hpoul.spain@gmail.com')))
      .requireSuccess();
  _logger.info('Success! ${registerResponse.userUuid}');
  final authToken = registerResponse.authToken;
  client.setAuth(SecuritySchemes.authToken,
      SecuritySchemeHttpData(bearerToken: authToken));

  while (true) {
    await Future<int>.delayed(const Duration(seconds: 5));
    final status = (await client.emailStatusGet()).requireSuccess();
    _logger.info('Status: $status');
    if (status.status == EmailStatusGetResponseBody200Status.confirmed) {
      _logger.info('Confirmed 🎉️');
      break;
    }
  }
//  _logger.info('Response: $blubb');
  requestSender.dispose();
}
