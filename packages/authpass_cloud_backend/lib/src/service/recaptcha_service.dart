import 'dart:convert';

import 'package:http/http.dart';
import 'package:quiver/check.dart';

import 'package:logging/logging.dart';

final _logger = Logger('recaptcha_service');

class RecaptchaService {
  RecaptchaService({this.secret});
  final String secret;
  Client _client;

  Future<bool> verify(String response, [String remoteIp]) async {
    _client ??= Client();
    final resp = await _client.post(
      'https://www.google.com/recaptcha/api/siteverify',
      body: {
        'secret': secret,
        'response': response,
        if (remoteIp != null) 'remoteip': remoteIp,
      },
    );
    checkState(
      resp.statusCode == 200,
      message: () => 'Error during request ${resp.body}',
    );
    final respJson = json.decode(resp.body) as Map<String, dynamic>;
    final isSuccess = respJson['success'] as bool;
    _logger.finer('Recaptcha response: $isSuccess ($respJson)');
    return isSuccess;
  }
}
