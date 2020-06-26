// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigFileRoot _$ConfigFileRootFromJson(Map json) {
  return ConfigFileRoot(
    http: json['http'] == null
        ? null
        : HttpConfig.fromJson((json['http'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    email: json['email'] == null
        ? null
        : EmailConfig.fromJson(json['email'] as Map),
    secrets: json['secrets'] == null
        ? null
        : SecretsConfig.fromJson(json['secrets'] as Map),
    database: json['database'] == null
        ? null
        : DatabaseConfig.fromJson((json['database'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
  );
}

Map<String, dynamic> _$ConfigFileRootToJson(ConfigFileRoot instance) =>
    <String, dynamic>{
      'http': instance.http,
      'email': instance.email,
      'secrets': instance.secrets,
      'database': instance.database,
    };

HttpConfig _$HttpConfigFromJson(Map json) {
  return HttpConfig(
    host: json['host'] as String ?? 'localhost',
    port: json['port'] as int ?? 8080,
  );
}

Map<String, dynamic> _$HttpConfigToJson(HttpConfig instance) =>
    <String, dynamic>{
      'host': instance.host,
      'port': instance.port,
    };

EmailConfig _$EmailConfigFromJson(Map json) {
  return EmailConfig(
    fromAddress: json['fromAddress'] as String,
    fromName: json['fromName'] as String,
    smtp: json['smtp'] == null
        ? null
        : EmailSmtpConfig.fromJson(json['smtp'] as Map),
  );
}

Map<String, dynamic> _$EmailConfigToJson(EmailConfig instance) =>
    <String, dynamic>{
      'smtp': instance.smtp,
      'fromAddress': instance.fromAddress,
      'fromName': instance.fromName,
    };

EmailSmtpConfig _$EmailSmtpConfigFromJson(Map json) {
  return EmailSmtpConfig(
    host: json['host'] as String,
    port: json['port'] as int,
    ssl: json['ssl'] as bool,
    username: json['username'] as String,
    password: json['password'] as String,
    allowInsecure: json['allowInsecure'] as bool,
  );
}

Map<String, dynamic> _$EmailSmtpConfigToJson(EmailSmtpConfig instance) =>
    <String, dynamic>{
      'host': instance.host,
      'port': instance.port,
      'ssl': instance.ssl,
      'username': instance.username,
      'password': instance.password,
      'allowInsecure': instance.allowInsecure,
    };

SecretsConfig _$SecretsConfigFromJson(Map json) {
  return SecretsConfig(
    recaptchaSecretKey: json['recaptchaSecretKey'] as String,
    recaptchaSiteKey: json['recaptchaSiteKey'] as String,
  );
}

Map<String, dynamic> _$SecretsConfigToJson(SecretsConfig instance) =>
    <String, dynamic>{
      'recaptchaSecretKey': instance.recaptchaSecretKey,
      'recaptchaSiteKey': instance.recaptchaSiteKey,
    };

DatabaseConfig _$DatabaseConfigFromJson(Map json) {
  return DatabaseConfig(
    host: json['host'] as String ?? 'localhost',
    port: json['port'] as int ?? 5432,
    databaseName: json['databaseName'] as String ?? 'authpass',
    username: json['username'] as String ?? 'authpass',
    password: json['password'] as String ?? 'blubb',
  );
}

Map<String, dynamic> _$DatabaseConfigToJson(DatabaseConfig instance) =>
    <String, dynamic>{
      'host': instance.host,
      'port': instance.port,
      'databaseName': instance.databaseName,
      'username': instance.username,
      'password': instance.password,
    };
