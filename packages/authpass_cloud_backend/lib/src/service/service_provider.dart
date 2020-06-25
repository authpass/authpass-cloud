import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/env/env.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:authpass_cloud_backend/src/service/email_service.dart';
import 'package:authpass_cloud_backend/src/service/recaptcha_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class ServiceProvider {
  ServiceProvider({
    @required this.env,
    @required this.cryptoService,
    @required this.emailService,
    RecaptchaService recaptchaService,
  })  : assert(env != null),
        assert(cryptoService != null),
        assert(emailService != null),
        recaptchaService = recaptchaService ??
            RecaptchaService(secret: env.secrets.recaptchaSecretKey);

  final Env env;
  final CryptoService cryptoService;
  final EmailService emailService;
  final RecaptchaService recaptchaService;

  DatabaseAccess createDatabaseAccess() => DatabaseAccess(
        cryptoService: cryptoService,
        config: DatabaseConfig(),
      );
}
