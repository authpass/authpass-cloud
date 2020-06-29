// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigFileRoot _$ConfigFileRootFromJson(Map json) {
  return $checkedNew('ConfigFileRoot', json, () {
    $checkKeys(json, requiredKeys: const ['database']);
    final val = ConfigFileRoot(
      http: $checkedConvert(
          json,
          'http',
          (v) => v == null
              ? null
              : HttpConfig.fromJson((v as Map)?.map(
                  (k, e) => MapEntry(k as String, e),
                ))),
      email: $checkedConvert(json, 'email',
          (v) => v == null ? null : EmailConfig.fromJson(v as Map)),
      secrets: $checkedConvert(json, 'secrets',
          (v) => v == null ? null : SecretsConfig.fromJson(v as Map)),
      database: $checkedConvert(json, 'database',
          (v) => DatabaseConfig.fromJson(Map<String, dynamic>.from(v as Map))),
      mailbox: $checkedConvert(
          json,
          'mailbox',
          (v) => v == null
              ? null
              : MailboxConfig.fromJson((v as Map)?.map(
                  (k, e) => MapEntry(k as String, e),
                ))),
    );
    return val;
  });
}

Map<String, dynamic> _$ConfigFileRootToJson(ConfigFileRoot instance) =>
    <String, dynamic>{
      'http': instance.http,
      'email': instance.email,
      'secrets': instance.secrets,
      'database': instance.database,
      'mailbox': instance.mailbox,
    };

MailboxConfig _$MailboxConfigFromJson(Map<String, dynamic> json) {
  return MailboxConfig(
    defaultHost: json['defaultHost'] as String,
  );
}

Map<String, dynamic> _$MailboxConfigToJson(MailboxConfig instance) =>
    <String, dynamic>{
      'defaultHost': instance.defaultHost,
    };

HttpConfig _$HttpConfigFromJson(Map json) {
  return $checkedNew('HttpConfig', json, () {
    final val = HttpConfig(
      host: $checkedConvert(json, 'host', (v) => v as String) ?? 'localhost',
      port: $checkedConvert(json, 'port', (v) => v as int) ?? 8080,
    );
    return val;
  });
}

Map<String, dynamic> _$HttpConfigToJson(HttpConfig instance) =>
    <String, dynamic>{
      'host': instance.host,
      'port': instance.port,
    };

EmailConfig _$EmailConfigFromJson(Map json) {
  return $checkedNew('EmailConfig', json, () {
    $checkKeys(json, requiredKeys: const ['fromAddress']);
    final val = EmailConfig(
      fromAddress: $checkedConvert(json, 'fromAddress', (v) => v as String),
      fromName: $checkedConvert(json, 'fromName', (v) => v as String),
      smtp: $checkedConvert(json, 'smtp',
          (v) => v == null ? null : EmailSmtpConfig.fromJson(v as Map)),
    );
    return val;
  });
}

Map<String, dynamic> _$EmailConfigToJson(EmailConfig instance) =>
    <String, dynamic>{
      'smtp': instance.smtp,
      'fromAddress': instance.fromAddress,
      'fromName': instance.fromName,
    };

EmailSmtpConfig _$EmailSmtpConfigFromJson(Map json) {
  return $checkedNew('EmailSmtpConfig', json, () {
    $checkKeys(json, requiredKeys: const ['host']);
    final val = EmailSmtpConfig(
      host: $checkedConvert(json, 'host', (v) => v as String),
      port: $checkedConvert(json, 'port', (v) => v as int) ?? 25,
      ssl: $checkedConvert(json, 'ssl', (v) => v as bool) ?? false,
      username: $checkedConvert(json, 'username', (v) => v as String),
      password: $checkedConvert(json, 'password', (v) => v as String),
      allowInsecure:
          $checkedConvert(json, 'allowInsecure', (v) => v as bool) ?? false,
      ignoreBadCertificate:
          $checkedConvert(json, 'ignoreBadCertificate', (v) => v as bool) ??
              false,
    );
    return val;
  });
}

Map<String, dynamic> _$EmailSmtpConfigToJson(EmailSmtpConfig instance) =>
    <String, dynamic>{
      'host': instance.host,
      'port': instance.port,
      'ssl': instance.ssl,
      'username': instance.username,
      'password': instance.password,
      'allowInsecure': instance.allowInsecure,
      'ignoreBadCertificate': instance.ignoreBadCertificate,
    };

SecretsConfig _$SecretsConfigFromJson(Map json) {
  return $checkedNew('SecretsConfig', json, () {
    final val = SecretsConfig(
      recaptchaSecretKey:
          $checkedConvert(json, 'recaptchaSecretKey', (v) => v as String),
      recaptchaSiteKey:
          $checkedConvert(json, 'recaptchaSiteKey', (v) => v as String),
      emailReceiveToken:
          $checkedConvert(json, 'emailReceiveToken', (v) => v as String),
    );
    return val;
  });
}

Map<String, dynamic> _$SecretsConfigToJson(SecretsConfig instance) =>
    <String, dynamic>{
      'recaptchaSecretKey': instance.recaptchaSecretKey,
      'recaptchaSiteKey': instance.recaptchaSiteKey,
      'emailReceiveToken': instance.emailReceiveToken,
    };

DatabaseConfig _$DatabaseConfigFromJson(Map json) {
  return $checkedNew('DatabaseConfig', json, () {
    final val = DatabaseConfig(
      host: $checkedConvert(json, 'host', (v) => v as String) ?? 'localhost',
      port: $checkedConvert(json, 'port', (v) => v as int) ?? 5432,
      databaseName: $checkedConvert(json, 'databaseName', (v) => v as String) ??
          'authpass',
      username:
          $checkedConvert(json, 'username', (v) => v as String) ?? 'authpass',
      password:
          $checkedConvert(json, 'password', (v) => v as String) ?? 'blubb',
    );
    return val;
  });
}

Map<String, dynamic> _$DatabaseConfigToJson(DatabaseConfig instance) =>
    <String, dynamic>{
      'host': instance.host,
      'port': instance.port,
      'databaseName': instance.databaseName,
      'username': instance.username,
      'password': instance.password,
    };
