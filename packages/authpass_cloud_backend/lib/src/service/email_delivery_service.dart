import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:enough_mail/enough_mail.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:smtpd/smtpd.dart';

final _logger = Logger('email_delivery_service');

class EmailDeliveryService {
  Future<MailSystemStatusCodes> deliverEmail(
      DatabaseTransaction db, String body) async {
    final firstLineIdx = body.indexOf('\n');
    final fromLine = body.substring(0, firstLineIdx);
    final rawMessage =
        body.substring(firstLineIdx + 1).replaceAll('\n', '\r\n');

    if (!fromLine.startsWith('From ')) {
      _logger.shout('Invalid format. expected From header as first line.');
      _logger.finer('Email content was: $body');
      return MailSystemStatusCodes.errorNetworkMisc
          .withMessage('Missing From header.');
    }
    final sender = fromLine.split(' ')[1];
    final message = MimeMessage.parseFromText(rawMessage);
    final recipient = message.decodeHeaderValue('delivered-to');
    return await _deliverEmailTo(db, sender, recipient, message);
  }

  Future<MailSystemStatusCodes> deliverEmailTo(
    DatabaseTransaction db, {
    required String? sender,
    required String recipient,
    required String content,
  }) async {
    final message = MimeMessage.parseFromText(content);
    return await _deliverEmailTo(db, sender, recipient, message);
  }

  Future<bool> verifyAddressValid(
      DatabaseTransaction db, String recipient) async {
    final mailbox = await db.tables.email.findMailbox(db, address: recipient);
    return mailbox != null;
  }

  Future<MailSystemStatusCodes> _deliverEmailTo(DatabaseTransaction db,
      String? sender, String? recipient, MimeMessage message) async {
    final mailbox = await db.tables.email.findMailbox(db, address: recipient);
    if (mailbox == null) {
      _logger.warning('Invalid destination address {$recipient}');
      return MailSystemStatusCodes.failureBadDestinationAddress;
    }
    if (mailbox.disabledAt != null) {
      _logger.warning('Disabled mailbox $mailbox');
      return MailSystemStatusCodes.failureBadDestinationAddress;
    }
    final subject = message.decodeHeaderValue('subject');
    await db.tables.email.insertMessage(
      db,
      mailbox: mailbox,
      sender: sender,
      subject: subject ?? '',
      message: message.body!.bodyRaw!,
    );

    _logger.info('Received email for {$recipient}.'
        ' (from {$sender})'
        ' With the following body:\n\n${message.body!.bodyRaw}');
    return MailSystemStatusCodes.success;
  }
}
