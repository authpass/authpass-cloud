import 'package:authpass_cloud_backend/src/env/config.dart';
import 'package:enough_mail/enough_mail.dart' as enough;
import 'package:logging/logging.dart';
import 'package:mailer/mailer.dart' as mailer;
import 'package:mailer/smtp_server.dart' as smtp;
import 'package:meta/meta.dart';

final _logger = Logger('email_service');

abstract class EmailService {
  Future<void> sendEmailConfirmationToken(String recipient, String url);
  Future<void> forwardMimeMessage(
      String mimeMessageContent, String recipientEmail);
}

abstract class EmailServiceImpl extends EmailService {
  @override
  Future<void> sendEmailConfirmationToken(String recipient, String url) async {
    await sendEmail(
      recipient: recipient,
      subject: 'Email Confirmation',
      body: '''
Hello,

Please confirm your email address by visiting the following URL:
  $url

Best Regards,
  Your AuthPass Team.
    ''',
    );
  }

  @protected
  Future<void> sendEmail({
    required String recipient,
    required String subject,
    required String body,
  });
}

class FakeEmailService extends EmailServiceImpl {
  @override
  Future<void> sendEmail(
      {String? recipient, String? subject, String? body}) async {
    _logger.info('Sending Email ....\n'
        '      To: $recipient\n'
        ' Subject: $recipient\n'
        '    Body:\n$body\n'
        '\n');
  }

  @override
  Future<void> forwardMimeMessage(
      String? mimeMessageContent, String recipientEmail) {
    throw UnimplementedError();
  }
}

class MailerEmailService extends EmailServiceImpl {
  MailerEmailService({required this.emailConfig})
      : smtpConfig = ArgumentError.checkNotNull(emailConfig.smtp);

  final EmailConfig emailConfig;
  final EmailSmtpConfig smtpConfig;

  @override
  Future<void> sendEmail(
      {String? recipient, String? subject, String? body}) async {
    _logger.fine('sending email. config: ${smtpConfig.toJson()}');
    final message = mailer.Message()
      ..from = mailer.Address(emailConfig.fromAddress, emailConfig.fromName)
      ..recipients.add(recipient)
      ..subject = subject
      ..text = body;

    final smtpServer = smtp.SmtpServer(
      smtpConfig.host,
      ssl: smtpConfig.ssl,
      port: smtpConfig.port,
      username: smtpConfig.username,
      password: smtpConfig.password,
      allowInsecure: smtpConfig.allowInsecure,
      ignoreBadCertificate: smtpConfig.ignoreBadCertificate,
    );
    try {
      final response = await mailer.send(message, smtpServer,
          timeout: const Duration(seconds: 5));
      _logger.fine('Sent email. $response');
    } on mailer.MailerException catch (e, stacktrace) {
      final problems = e.problems.map((e) => '${e.code}: ${e.msg}').join(',');
      _logger.severe('Error while sending email. ($problems)', e, stacktrace);
      rethrow;
    }
  }

  @override
  Future<void> forwardMimeMessage(
      String mimeMessageContent, String recipientEmail) async {
    final originalMessage =
        enough.MimeMessage.parseFromText(mimeMessageContent);
    final newMessage = enough.MessageBuilder.prepareForwardMessage(
        originalMessage,
        from: originalMessage.to?.first);
    newMessage.to = [enough.MailAddress(null, recipientEmail)];
    final message = newMessage.buildMimeMessage();

    final client = enough.SmtpClient(smtpConfig.host);
    // TODO: What happens on connection errors?
    await client.connectToServer(smtpConfig.host, smtpConfig.port,
        isSecure: smtpConfig.ssl);
    await client.ehlo().expectOkStatus('ehlo');
    if (smtpConfig.username != null) {
      await client
          .authenticate(smtpConfig.username, smtpConfig.password)
          .expectOkStatus('login');
    }
    await client
        .sendMessage(message, use8BitEncoding: true)
        .expectOkStatus('send');
    await client.quit().expectOkStatus('quit');

    await client.closeConnection();
  }
}

extension on Future<enough.SmtpResponse> {
  Future<enough.SmtpResponse> expectOkStatus(String message) async {
    final response = await this;
    if (!response.isOkStatus) {
      throw StateError(
          'Error during smtp command: $message (${response.message}');
    }
    return response;
  }
}
