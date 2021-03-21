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
          (dynamic v) => v == null
              ? null
              : HttpConfig.fromJson(
                  (v as Map<String, Object>).map<String, Object>(
                  (dynamic k, Object e) =>
                      MapEntry<String, Object>(k as String, e),
                ))),
      email: $checkedConvert(
          json,
          'email',
          ((dynamic v) => v == null ? null : EmailConfig.fromJson(v as Map))
              as EmailConfig Function(dynamic)),
      secrets: $checkedConvert(
          json,
          'secrets',
          ((dynamic v) => v == null ? null : SecretsConfig.fromJson(v as Map))
              as SecretsConfig Function(dynamic)),
      database: $checkedConvert(
          json,
          'database',
          (dynamic v) =>
              DatabaseConfig.fromJson(Map<String, dynamic>.from(v as Map))),
      mailbox: $checkedConvert(
          json,
          'mailbox',
          ((dynamic v) => v == null
              ? null
              : MailboxConfig.fromJson(
                  (v as Map<String, Object>).map<String, Object>(
                  (dynamic k, Object e) => MapEntry(k as String, e),
                ))) as MailboxConfig Function(dynamic)),
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
    defaultHost: json['defaultHost'] as String?,
  );
}

Map<String, dynamic> _$MailboxConfigToJson(MailboxConfig instance) =>
    <String, dynamic>{
      'defaultHost': instance.defaultHost,
    };

HttpConfig _$HttpConfigFromJson(Map json) {
  return $checkedNew('HttpConfig', json, () {
    final val = HttpConfig(
      host: $checkedConvert(json, 'host', (dynamic v) => v as String?) ??
          'localhost',
      port: $checkedConvert(json, 'port', (dynamic v) => v as int?) ?? 8080,
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
      fromAddress: $checkedConvert(json, 'fromAddress',
          ((dynamic v) => (v as String?)!) as String Function(dynamic)),
      fromName: $checkedConvert(json, 'fromName', (dynamic v) => v as String?),
      smtp: $checkedConvert(json, 'smtp',
          (dynamic v) => v == null ? null : EmailSmtpConfig.fromJson(v as Map)),
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
      host: $checkedConvert(json, 'host',
          ((dynamic v) => (v as String?)!) as String Function(dynamic)),
      port: $checkedConvert(json, 'port', (dynamic v) => v as int?) ?? 25,
      ssl: $checkedConvert(json, 'ssl', (dynamic v) => v as bool?) ?? false,
      username: $checkedConvert(json, 'username', (dynamic v) => v as String?),
      password: $checkedConvert(json, 'password', (dynamic v) => v as String?),
      allowInsecure:
          $checkedConvert(json, 'allowInsecure', (dynamic v) => v as bool?) ??
              false,
      ignoreBadCertificate: $checkedConvert(
              json, 'ignoreBadCertificate', (dynamic v) => v as bool?) ??
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
      recaptchaSecretKey: $checkedConvert(
          json, 'recaptchaSecretKey', (dynamic v) => v as String?),
      recaptchaSiteKey: $checkedConvert(
          json, 'recaptchaSiteKey', (dynamic v) => v as String?),
      emailReceiveToken: $checkedConvert(
          json, 'emailReceiveToken', (dynamic v) => v as String?),
      systemStatusSecret: $checkedConvert(
          json, 'systemStatusSecret', (dynamic v) => v as String?),
    );
    return val;
  });
}

Map<String, dynamic> _$SecretsConfigToJson(SecretsConfig instance) =>
    <String, dynamic>{
      'recaptchaSecretKey': instance.recaptchaSecretKey,
      'recaptchaSiteKey': instance.recaptchaSiteKey,
      'emailReceiveToken': instance.emailReceiveToken,
      'systemStatusSecret': instance.systemStatusSecret,
    };
