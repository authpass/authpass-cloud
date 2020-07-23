import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:postgres_utils/postgres_utils.dart';

part 'config.g.dart';

@JsonSerializable(anyMap: true, checked: true)
class ConfigFileRoot {
  ConfigFileRoot({
    HttpConfig http,
    @required this.email,
    @required this.secrets,
    @required this.database,
    @required this.mailbox,
  })  : http = http ?? HttpConfig.defaults(),
        assert(email != null),
        assert(secrets != null),
        assert(database != null),
        assert(mailbox != null);
  factory ConfigFileRoot.fromJson(Map json) => _$ConfigFileRootFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigFileRootToJson(this);

  final HttpConfig http;
  final EmailConfig email;
  final SecretsConfig secrets;
  @JsonKey(nullable: false, required: true)
  final DatabaseConfig database;
  final MailboxConfig mailbox;
}

@JsonSerializable(nullable: false)
class MailboxConfig {
  MailboxConfig({
    this.defaultHost,
  });
  factory MailboxConfig.fromJson(Map<String, dynamic> json) =>
      _$MailboxConfigFromJson(json);
  Map<String, dynamic> toJson() => _$MailboxConfigToJson(this);

  final String defaultHost;
}

@JsonSerializable(anyMap: true, checked: true)
class HttpConfig {
  const HttpConfig({
    @required this.host,
    @required this.port,
  })  : assert(host != null),
        assert(port != null);
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
    @required this.fromAddress,
    this.fromName,
    this.smtp,
  }) : assert(fromAddress != null);
  factory EmailConfig.fromJson(Map json) => _$EmailConfigFromJson(json);
  Map<String, dynamic> toJson() => _$EmailConfigToJson(this);

  final EmailSmtpConfig smtp;
  @JsonKey(required: true)
  final String fromAddress;
  final String fromName;
}

@JsonSerializable(anyMap: true, checked: true)
class EmailSmtpConfig {
  EmailSmtpConfig({
    @required this.host,
    this.port,
    this.ssl,
    this.username,
    this.password,
    this.allowInsecure = false,
    this.ignoreBadCertificate = false,
  })  : assert(host != null),
        assert(allowInsecure != null);
  factory EmailSmtpConfig.fromJson(Map json) => _$EmailSmtpConfigFromJson(json);
  Map<String, dynamic> toJson() => _$EmailSmtpConfigToJson(this);

  @JsonKey(required: true)
  final String host;
  @JsonKey(defaultValue: 25)
  final int port;
  @JsonKey(defaultValue: false)
  final bool ssl;
  final String username;
  final String password;

  @JsonKey(defaultValue: false)
  final bool allowInsecure;
  @JsonKey(defaultValue: false)
  final bool ignoreBadCertificate;
}

@JsonSerializable(nullable: false, anyMap: true, checked: true)
class SecretsConfig {
  SecretsConfig({
    @required this.recaptchaSecretKey,
    @required this.recaptchaSiteKey,
    @required this.emailReceiveToken,
  });
  factory SecretsConfig.fromJson(Map json) => _$SecretsConfigFromJson(json);
  Map<String, dynamic> toJson() => _$SecretsConfigToJson(this);

  final String recaptchaSecretKey;

  final String recaptchaSiteKey;

  final String emailReceiveToken;
}
