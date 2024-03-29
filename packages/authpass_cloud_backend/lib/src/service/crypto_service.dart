import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:uuid/data.dart';
import 'package:uuid/rng.dart';
import 'package:uuid/uuid.dart';

enum TokenType {
  emailConfirm,
  authToken,
  fileToken,
}

int _tokenTypeByteLength(TokenType type) {
  // since these are byte lengths, and we *always* use the base64 encoded
  // version, make sure it is divisible by 3..
  // (or we remove padding.. but that sounds redundant)
  switch (type) {
    case TokenType.emailConfirm:
      return 33;
    case TokenType.authToken:
      return 510;
    case TokenType.fileToken:
      return 63;
  }
  // throw StateError('Invalid token type $type.');
}

class CryptoService {
  final Random _random = Random.secure();
  final Uuid _uuid = Uuid(goptions: GlobalOptions(CryptoRNG()));

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
    final token = base64Url.encode(list);
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
