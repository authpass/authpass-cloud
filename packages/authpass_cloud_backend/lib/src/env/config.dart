import 'package:authpass_cloud_backend/src/env/env.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'config.g.dart';

@JsonSerializable(nullable: false, anyMap: true)
class ConfigFileRoot {
  ConfigFileRoot({
    @required this.email,
    @required this.secrets,
  })  : assert(email != null),
        assert(secrets != null);
  factory ConfigFileRoot.fromJson(Map json) => _$ConfigFileRootFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigFileRootToJson(this);

  final EmailConfig email;
  final SecretsConfig secrets;
}

@JsonSerializable(anyMap: true)
class EmailConfig {
  EmailConfig({
    @required this.fromAddress,
    this.fromName,
    this.smtp,
  }) : assert(fromAddress != null);
  factory EmailConfig.fromJson(Map json) => _$EmailConfigFromJson(json);
  Map<String, dynamic> toJson() => _$EmailConfigToJson(this);

  final EmailSmtpConfig smtp;
  final String fromAddress;
  final String fromName;
}

@JsonSerializable(anyMap: true)
class EmailSmtpConfig {
  EmailSmtpConfig({
    @required this.host,
    this.port,
    this.ssl,
    this.username,
    this.password,
    this.allowInsecure = false,
  })  : assert(host != null),
        assert(allowInsecure != null);
  factory EmailSmtpConfig.fromJson(Map json) => _$EmailSmtpConfigFromJson(json);
  Map<String, dynamic> toJson() => _$EmailSmtpConfigToJson(this);

  final String host;
  final int port;
  final bool ssl;
  final String username;
  final String password;
  final bool allowInsecure;
}

@JsonSerializable(nullable: false, anyMap: true)
class SecretsConfig implements EnvSecrets {
  SecretsConfig({
    @required this.recaptchaSecretKey,
    @required this.recaptchaSiteKey,
  });
  factory SecretsConfig.fromJson(Map json) => _$SecretsConfigFromJson(json);
  Map<String, dynamic> toJson() => _$SecretsConfigToJson(this);

  @override
  final String recaptchaSecretKey;

  @override
  final String recaptchaSiteKey;
}
