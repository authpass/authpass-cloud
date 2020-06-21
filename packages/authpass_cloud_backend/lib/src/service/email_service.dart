import 'package:logging/logging.dart';
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
