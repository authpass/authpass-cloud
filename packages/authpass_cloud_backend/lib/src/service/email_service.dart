import 'package:authpass_cloud_backend/src/env/env.dart';
import 'package:logging/logging.dart';
import 'package:mailer/mailer.dart' as mailer;
import 'package:mailer/smtp_server.dart' as smtp;
import 'package:meta/meta.dart';

final _logger = Logger('email_service');

abstract class EmailService {
  Future<void> sendEmailConfirmationToken(String recipient, String url);
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
    @required String recipient,
    @required String subject,
    @required String body,
  });
}

class FakeEmailService extends EmailServiceImpl {
  @override
  Future<void> sendEmail(
      {String recipient, String subject, String body}) async {
    _logger.info('Sending Email ....\n'
        '      To: $recipient\n'
        ' Subject: $recipient\n'
        '    Body:\n$body\n'
        '\n');
  }
}

class MailerEmailService extends EmailServiceImpl {
  MailerEmailService({this.config});

  final EmailSmtpConfig config;

  @override
  Future<void> sendEmail(
      {String recipient, String subject, String body}) async {
    final message = mailer.Message()
      ..from = mailer.Address(config.fromAddress, config.fromName)
      ..recipients.add(recipient)
      ..subject = subject
      ..text = body;

    final smtpServer = smtp.SmtpServer(
      config.smtpHost,
      port: config.smtpPort ?? 587,
      username: config.smtpUsername,
      password: config.smtpUsername,
      allowInsecure: config.smtpAllowInsecure,
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
}
