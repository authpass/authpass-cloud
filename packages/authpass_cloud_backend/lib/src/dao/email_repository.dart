import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/dao/tables/email_tables.dart';
import 'package:authpass_cloud_backend/src/dao/tables/user_tables.dart';
import 'package:authpass_cloud_backend/src/env/env.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:quiver/core.dart';
import 'package:smtpd/smtpd.dart';

final _logger = Logger('email_repository');

class EmailRepository {
  EmailRepository(
      {required this.db, required this.cryptoService, required this.env});
  final DatabaseTransaction db;
  final CryptoService cryptoService;
  final Env env;

  Future<String> createAddress(
    UserEntity userEntity, {
    required String label,
    required String clientEntryUuid,
  }) async {
    final mailboxes = await db.tables.email.findMailboxAll(db, userEntity);
    if (mailboxes.length > 800) {
      _logger.shout('More than 800 mailboxes for $userEntity');
    }
    if (mailboxes.length > 1000) {
      throw StateError(
          'We do not allow more than 1000 mailboxes per user right now.');
    }

    const MAX_RETRY = 10;
    for (var i = 0; i < MAX_RETRY; i++) {
      if (i > 1) {
        _logger.shout('We had more than two collisions while trying '
            'to generate email address.');
      }

      final addressLocal = cryptoService.createRandomAddress();
      // make sure we don't incidentally create a reserved addres.
      if (ReservedEmailAddresses.isReserved(addressLocal)) {
        _logger.warning('Generated a reserved address. $addressLocal');
        continue;
      }
      final address = '$addressLocal@${env.config.mailbox.defaultHost}';

      final mailbox = await db.tables.email.findMailbox(db, address: address);
      if (mailbox == null) {
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
    throw StateError('Unable to find unique address after $MAX_RETRY tries.');
  }

  /// return false if mailbox can't be found (or the given user is not owner)
  Future<bool> updateMailbox(
    UserEntity user, {
    required String mailboxAddress,
    String? label,
    String? entryUuid,
    bool? isDeleted,
    bool? isDisabled,
    bool? isHidden,
  }) async {
    final mailbox =
        await db.tables.email.findMailbox(db, address: mailboxAddress);
    if (mailbox == null || mailbox.user.id != user.id) {
      return false;
    }

    await db.tables.email.updateMailbox(
      db,
      mailbox.id,
      label: label == null ? null : Optional.of(label),
      clientEntryUuid: label == null ? null : Optional.of(entryUuid),
      deletedAt: _nowIfTrue(isDeleted),
      hiddenAt: _nowIfTrue(isHidden),
      disabledAt: _nowIfTrue(isDisabled),
    );
    return true;
  }

  Optional<DateTime>? _nowIfTrue(bool? value) {
    if (value == null) {
      return null;
    }
    return value ? Optional.of(clock.now().toUtc()) : const Optional.absent();
  }

  Future<List<EmailMessageEntity>> findEmailsForUser(
    UserEntity user, {
    required int offset,
    required int limit,
    required DateTime until,
    DateTime? since,
  }) async {
    return await db.tables.email.findEmailsForUser(db, user,
        offset: offset, limit: limit, until: until, since: since);
  }

  Future<String?> findEmailMessageBody(UserEntity user,
      {required String messageId}) async {
    return await db.tables.email
        .findEmailMessageBody(db, user, messageId: messageId);
  }

  Future<List<Mailbox>> findMailboxAll(UserEntity user) async {
    return await db.tables.email.findMailboxAll(db, user);
  }

  /// true if mail was found, false otherwise.
  Future<bool> markAsRead(UserEntity user,
      {required String messageId, required bool isRead}) async {
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

  Future<int> messageMassUpdate(
    UserEntity entity,
    MailMassupdatePostSchemaFilter filter, {
    List<String>? messageIds,
    bool? isRead,
  }) async {
    return await db.tables.email.messageMassUpdate(db, entity, filter,
        messageIds: messageIds, readAt: _nowIfTrue(isRead));
  }

  Future<bool> deleteMessage(UserEntity user,
      {required String messageId}) async {
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

  Future<UserEmailStatusEntity> generateUserStatus(UserEntity user) async {
    return await db.tables.email.userStatus(db, user);
  }
}
