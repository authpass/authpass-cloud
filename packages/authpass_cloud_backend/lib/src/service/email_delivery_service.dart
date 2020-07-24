import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/mail/mail_system_status_codes.dart';
import 'package:enough_mail/enough_mail.dart';
import 'package:logging/logging.dart';

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
    final fromAddress = fromLine.split(' ')[1];
    final message = MimeMessage();
    message.bodyRaw = rawMessage;
    message.parse();
    final recipient = message.decodeHeaderValue('delivered-to');

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
      sender: fromAddress,
      subject: subject ?? '',
      message: rawMessage,
    );

    _logger.info('Received email for {$recipient}.'
        ' (from {$fromAddress})'
        ' With the following body:\n\n$body');
    return MailSystemStatusCodes.success;
  }
}