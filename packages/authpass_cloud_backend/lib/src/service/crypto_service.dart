import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

enum TokenType {
  emailConfirm,
  authToken,
  fileToken,
}

int _tokenTypeByteLength(TokenType type) {
  switch (type) {
    case TokenType.emailConfirm:
      return 32;
    case TokenType.authToken:
      return 512;
    case TokenType.fileToken:
      return 128;
  }
  // throw StateError('Invalid token type $type.');
}

class CryptoService {
  final Random _random = Random.secure();
  final Uuid _uuid =
      const Uuid(options: <String, dynamic>{'grng': UuidUtil.cryptoRNG});

//  static const _ADDRESS_LENGTH = 32;
  // for now limit length to 10 characters, that should be more than enough.
  static const _ADDRESS_LENGTH = 10;
//  static const _ADDRESS_CHARACTERS = 'abcdefghijklmnopqrstuvwxyz0123456789._-+';
  static const _ADDRESS_CHARACTERS = 'abcdefghijklmnopqrstuvwxyz0123456789';

  String createSecureUuid() => _uuid.v4();

  String createSecureToken({int? length, required TokenType type}) {
    final byteLength =
        length == null ? _tokenTypeByteLength(type) : length ~/ 4 * 3;
    final list = Uint8List(byteLength);
    for (var i = 0; i < byteLength; i++) {
      list[i] = _random.nextInt(256);
    }
    final token = base64.encode(list);
    assert(length == null || token.length == length);
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
