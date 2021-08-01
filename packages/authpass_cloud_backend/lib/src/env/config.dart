import 'package:json_annotation/json_annotation.dart';
import 'package:postgres_utils/postgres_utils.dart';

part 'config.g.dart';

@JsonSerializable(anyMap: true, checked: true)
class ConfigFileRoot {
  ConfigFileRoot({
    HttpConfig? http,
    required this.email,
    required this.secrets,
    required this.database,
    required this.mailbox,
  }) : http = http ?? HttpConfig.defaults();
  factory ConfigFileRoot.fromJson(Map json) => _$ConfigFileRootFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigFileRootToJson(this);

  final HttpConfig http;
  final EmailConfig email;
  final SecretsConfig secrets;
  @JsonKey(required: true)
  final DatabaseConfig database;
  final MailboxConfig mailbox;
}

@JsonSerializable()
class MailboxConfig {
  MailboxConfig({
    required this.defaultHost,
  });
  factory MailboxConfig.fromJson(Map<String, dynamic> json) =>
      _$MailboxConfigFromJson(json);
  Map<String, dynamic> toJson() => _$MailboxConfigToJson(this);

  final String defaultHost;
}

@JsonSerializable(anyMap: true, checked: true)
class HttpConfig {
  const HttpConfig({
    required this.host,
    required this.port,
  });
  factory HttpConfig.fromJson(Map<String, dynamic> json) =>
      _$HttpConfigFromJson(json);
  factory HttpConfig.defaults() => HttpConfig.fromJson(<String, dynamic>{});
  Map<String, dynamic> toJson() => _$HttpConfigToJson(this);

  @JsonKey(defaultValue: 'localhost')
  final String host;
  @JsonKey(defaultValue: 8080)
  final int port;
}

@JsonSerializable(anyMap: true, checked: true)
class EmailConfig {
  EmailConfig({
    required this.fromAddress,
    this.fromName,
    this.smtp,
  });
  factory EmailConfig.fromJson(Map json) => _$EmailConfigFromJson(json);
  Map<String, dynamic> toJson() => _$EmailConfigToJson(this);

  final EmailSmtpConfig? smtp;
  @JsonKey(required: true)
  final String fromAddress;
  final String? fromName;
}

@JsonSerializable(anyMap: true, checked: true)
class EmailSmtpConfig {
  EmailSmtpConfig({
    required this.host,
    this.port,
    this.ssl,
    this.username,
    this.password,
    this.allowInsecure = false,
    this.ignoreBadCertificate = false,
  });
  factory EmailSmtpConfig.fromJson(Map json) => _$EmailSmtpConfigFromJson(json);
  Map<String, dynamic> toJson() => _$EmailSmtpConfigToJson(this);

  @JsonKey(required: true)
  final String host;
  @JsonKey(defaultValue: 25)
  final int? port;
  @JsonKey(defaultValue: false)
  final bool? ssl;
  final String? username;
  final String? password;

  @JsonKey(defaultValue: false)
  final bool allowInsecure;
  @JsonKey(defaultValue: false)
  final bool ignoreBadCertificate;
}

@JsonSerializable(anyMap: true, checked: true)
class SecretsConfig {
  SecretsConfig({
    required this.recaptchaSecretKey,
    required this.recaptchaSiteKey,
    required this.emailReceiveToken,
    required this.systemStatusSecret,
  });
  factory SecretsConfig.fromJson(Map json) => _$SecretsConfigFromJson(json);
  Map<String, dynamic> toJson() => _$SecretsConfigToJson(this);

  final String recaptchaSecretKey;

  final String recaptchaSiteKey;

  final String emailReceiveToken;

  final String systemStatusSecret;
}
