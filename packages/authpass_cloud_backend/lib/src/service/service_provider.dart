import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/env/env.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:authpass_cloud_backend/src/service/email_delivery_service.dart';
import 'package:authpass_cloud_backend/src/service/email_service.dart';
import 'package:authpass_cloud_backend/src/service/recaptcha_service.dart';

class ServiceProvider {
  ServiceProvider({
    required this.env,
    required this.cryptoService,
    required this.emailService,
    RecaptchaService? recaptchaService,
  })  : recaptchaService = recaptchaService ??
            RecaptchaService(secret: env.config.secrets.recaptchaSecretKey),
        emailDeliveryService = EmailDeliveryService();

  final Env env;
  final CryptoService cryptoService;
  final EmailService emailService;
  final RecaptchaService recaptchaService;
  final EmailDeliveryService emailDeliveryService;

  DatabaseAccess createDatabaseAccess() => DatabaseAccess(
        cryptoService: cryptoService,
        config: env.config.database,
      );
}
