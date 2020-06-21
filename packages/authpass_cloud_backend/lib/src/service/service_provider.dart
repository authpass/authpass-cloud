import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:authpass_cloud_backend/src/service/email_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class ServiceProvider {
  ServiceProvider({
    @required this.cryptoService,
    @required this.emailService,
  });

  final CryptoService cryptoService;
  final EmailService emailService;
}
