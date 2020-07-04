import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/dao/tables/email_tables.dart';
import 'package:authpass_cloud_backend/src/dao/tables/user_tables.dart';
import 'package:authpass_cloud_backend/src/env/env.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:clock/clock.dart';
import 'package:meta/meta.dart';

import 'package:logging/logging.dart';
import 'package:quiver/core.dart';

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

    final mailboxes = await db.tables.email.findMailboxAll(db, userEntity);
    if (mailboxes.length > 800) {
      _logger.shout('More than 800 mailboxes for $userEntity');
    }
    if (mailboxes.length > 1000) {
      throw StateError(
          'We do not allow more than 1000 mailboxes per user right now.');
    }

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

  /// return false if mailbox can't be found (or the given user is not owner)
  Future<bool> updateMailbox(
    UserEntity user, {
    @required String mailboxAddress,
    String label,
    String entryUuid,
    bool isDeleted,
    bool isDisabled,
    bool isHidden,
  }) async {
    assert(user != null);
    assert(mailboxAddress != null);
    final mailbox =
        await db.tables.email.findMailbox(db, address: mailboxAddress);
    if (mailbox == null || mailbox.user.id != user.id) {
      return false;
    }
    final now = clock.now().toUtc();
    Optional<DateTime> nowIfTrue(bool value) {
      if (value == null) {
        return null;
      }
      return value ? Optional.of(now) : const Optional.absent();
    }

    await db.tables.email.updateMailbox(
      db,
      mailbox.id,
      label: label == null ? null : Optional.of(label),
      clientEntryUuid: label == null ? null : Optional.of(entryUuid),
      deletedAt: nowIfTrue(isDeleted),
      hiddenAt: nowIfTrue(isHidden),
      disabledAt: nowIfTrue(isDisabled),
    );
    return true;
  }

  Future<List<EmailMessageEntity>> findEmailsForUser(
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
      await db.tables.email.updateMailMessage(db,
          messageId: messageId,
          readAt: isRead ? clock.now().toUtc() : null,
          deletedAt: mail.deletedAt);
      return true;
    }
    return false;
  }

  Future<bool> deleteMessage(UserEntity user,
      {@required String messageId}) async {
    final mail =
        await db.tables.email.findEmailForUser(db, user, messageId: messageId);
    if (mail != null) {
      await db.tables.email.updateMailMessage(db,
          messageId: messageId,
          readAt: mail.readAt,
          deletedAt: clock.now().toUtc());
      return true;
    }
    return false;
  }
}
