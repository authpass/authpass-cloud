import 'dart:convert';
import 'dart:math';

import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

enum TokenType {
  emailConfirm,
  authToken,
}

class CryptoService {
  final Random _random = Random.secure();
  final Uuid _uuid =
      Uuid(options: <String, dynamic>{'grng': UuidUtil.cryptoRNG});

//  static const _ADDRESS_LENGTH = 32;
  // for now limit length to 10 characters, that should be more than enough.
  static const _ADDRESS_LENGTH = 10;
//  static const _ADDRESS_CHARACTERS = 'abcdefghijklmnopqrstuvwxyz0123456789._-+';
  static const _ADDRESS_CHARACTERS = 'abcdefghijklmnopqrstuvwxyz0123456789';

  String createSecureUuid() => _uuid.v4();

  String createSecureToken({int length = 32, @required TokenType type}) {
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

  String createRandomAddress() {
    final address = String.fromCharCodes(Iterable.generate(
        _ADDRESS_LENGTH,
        (_) => _ADDRESS_CHARACTERS
            .codeUnitAt(_random.nextInt(_ADDRESS_CHARACTERS.length))));
    return address;
  }
}
