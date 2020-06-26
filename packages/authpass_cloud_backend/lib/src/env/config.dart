import 'package:authpass_cloud_backend/src/env/env.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'config.g.dart';

@JsonSerializable(anyMap: true)
class ConfigFileRoot {
  ConfigFileRoot({
    HttpConfig http,
    @required this.email,
    @required this.secrets,
    @required this.database,
  })  : http = http ?? HttpConfig.defaults(),
        assert(email != null),
        assert(secrets != null);
  factory ConfigFileRoot.fromJson(Map json) => _$ConfigFileRootFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigFileRootToJson(this);

  final HttpConfig http;
  final EmailConfig email;
  final SecretsConfig secrets;
  final DatabaseConfig database;
}

@JsonSerializable(anyMap: true)
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

@JsonSerializable(anyMap: true)
class DatabaseConfig {
  DatabaseConfig({
    @required this.host,
    @required this.port,
    @required this.databaseName,
    @required this.username,
    this.password,
  })  : assert(host != null),
        assert(port != null),
        assert(databaseName != null),
        assert(username != null);

  factory DatabaseConfig.fromJson(Map<String, dynamic> json) =>
      _$DatabaseConfigFromJson(json);
  factory DatabaseConfig.defaults() =>
      DatabaseConfig.fromJson(<String, dynamic>{});
  Map<String, dynamic> toJson() => _$DatabaseConfigToJson(this);

  @JsonKey(defaultValue: 'localhost')
  final String host;
  @JsonKey(defaultValue: 5432)
  final int port;

  @JsonKey(defaultValue: 'authpass')
  final String databaseName;
  @JsonKey(defaultValue: 'authpass')
  final String username;
  @JsonKey(defaultValue: 'blubb')
  final String password;

  DatabaseConfig copyWith({String databaseName}) => DatabaseConfig(
        host: host,
        port: port,
        databaseName: databaseName ?? this.databaseName,
        username: username,
        password: password,
      );
}
