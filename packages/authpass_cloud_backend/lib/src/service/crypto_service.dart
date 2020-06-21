import 'dart:convert';
import 'dart:math';

import 'dart:typed_data';

import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

class CryptoService {
  final Random _random = Random.secure();
  final Uuid _uuid =
      Uuid(options: <String, dynamic>{'grng': UuidUtil.cryptoRNG});

  String createSecureUuid() => _uuid.v4();

  String createSecureToken({int length = 32}) {
    assert(length != null);
    final byteLength = length ~/ 4 * 3;
    final list = Uint8List(byteLength);
    for (var i = 0; i < byteLength; i++) {
      list[i] = _random.nextInt(256);
    }
    final token = base64.encode(list);
    assert(token.length == length);
    return token;
  }
}
