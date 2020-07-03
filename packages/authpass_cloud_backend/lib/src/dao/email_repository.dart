import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/dao/tables/user_tables.dart';
import 'package:authpass_cloud_backend/src/env/env.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:clock/clock.dart';
import 'package:meta/meta.dart';

import 'package:logging/logging.dart';

final _logger = Logger('email_repository');

class EmailRepository {
  EmailRepository(
      {@required this.db, @required this.cryptoService, @required this.env})
      : assert(db != null),
        assert(cryptoService != null),
        assert(env != null);
  final DatabaseTransaction db;
  final CryptoService cryptoService;
  final Env env;

  Future<String> createAddress(
    UserEntity userEntity, {
    @required String label,
    @required String clientEntryUuid,
  }) async {
    assert(userEntity != null);
    assert(label != null);
    assert(clientEntryUuid != null);

    const _MAX_RETRY = 10;
    for (var i = 0; i < _MAX_RETRY; i++) {
      final addressLocal = cryptoService.createRandomAddress();
      final address = '$addressLocal@${env.config.mailbox.defaultHost}';

      final mailbox = db.tables.email.findMailbox(db, address: address);
      if (mailbox != null) {
        await db.tables.email.insertMailbox(
          db,
          userEntity: userEntity,
          address: address,
          label: label,
          clientEntryUuid: clientEntryUuid,
        );
        return address;
      }
    }
    throw StateError('Unable to find unique address after $_MAX_RETRY tries.');
  }

  Future<List<EmailMessage>> findEmailsForUser(
    UserEntity user, {
    @required int offset,
    @required int limit,
    @required DateTime until,
    DateTime since,
  }) async {
    return await db.tables.email.findEmailsForUser(db, user,
        offset: offset, limit: limit, until: until, since: since);
  }

  Future<String> findEmailMessageBody(UserEntity user,
      {String messageId}) async {
    return await db.tables.email
        .findEmailMessageBody(db, user, messageId: messageId);
  }

  Future<List<Mailbox>> findMailboxAll(UserEntity user) async {
    return await db.tables.email.findMailboxAll(db, user);
  }

  /// true if mail was found, false otherwise.
  Future<bool> markAsRead(UserEntity user,
      {@required String messageId, @required bool isRead}) async {
    assert(messageId != null);
    assert(isRead != null);
    final mail =
        await db.tables.email.findEmailForUser(db, user, messageId: messageId);
    if (mail != null) {
      if (mail.isRead != isRead) {
        _logger.warning('Marking email as read=$isRead although it already is.'
            ' $messageId (${mail.isRead} vs $isRead)');
      }
      await db.tables.email.updateReadFor(db,
          messageId: messageId, readAt: isRead ? clock.now().toUtc() : null);
      return true;
    }
    return false;
  }
}
