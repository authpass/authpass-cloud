// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigFileRoot _$ConfigFileRootFromJson(Map json) => $checkedCreate(
      'ConfigFileRoot',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['database'],
        );
        final val = ConfigFileRoot(
          http: $checkedConvert(
              'http',
              (v) => v == null
                  ? null
                  : HttpConfig.fromJson(Map<String, dynamic>.from(v as Map))),
          email:
              $checkedConvert('email', (v) => EmailConfig.fromJson(v as Map)),
          secrets: $checkedConvert(
              'secrets', (v) => SecretsConfig.fromJson(v as Map)),
          database: $checkedConvert(
              'database',
              (v) =>
                  DatabaseConfig.fromJson(Map<String, dynamic>.from(v as Map))),
          mailbox: $checkedConvert(
              'mailbox',
              (v) =>
                  MailboxConfig.fromJson(Map<String, dynamic>.from(v as Map))),
        );
        return val;
      },
    );

Map<String, dynamic> _$ConfigFileRootToJson(ConfigFileRoot instance) =>
    <String, dynamic>{
      'http': instance.http,
      'email': instance.email,
      'secrets': instance.secrets,
      'database': instance.database,
      'mailbox': instance.mailbox,
    };

MailboxConfig _$MailboxConfigFromJson(Map<String, dynamic> json) =>
    MailboxConfig(
      defaultHost: json['defaultHost'] as String,
    );

Map<String, dynamic> _$MailboxConfigToJson(MailboxConfig instance) =>
    <String, dynamic>{
      'defaultHost': instance.defaultHost,
    };

HttpConfig _$HttpConfigFromJson(Map json) => $checkedCreate(
      'HttpConfig',
      json,
      ($checkedConvert) {
        final val = HttpConfig(
          host: $checkedConvert('host', (v) => v as String? ?? 'localhost'),
          port: $checkedConvert('port', (v) => v as int? ?? 8080),
        );
        return val;
      },
    );

Map<String, dynamic> _$HttpConfigToJson(HttpConfig instance) =>
    <String, dynamic>{
      'host': instance.host,
      'port': instance.port,
    };

EmailConfig _$EmailConfigFromJson(Map json) => $checkedCreate(
      'EmailConfig',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['fromAddress'],
        );
        final val = EmailConfig(
          fromAddress: $checkedConvert('fromAddress', (v) => v as String),
          fromName: $checkedConvert('fromName', (v) => v as String?),
          smtp: $checkedConvert('smtp',
              (v) => v == null ? null : EmailSmtpConfig.fromJson(v as Map)),
        );
        return val;
      },
    );

Map<String, dynamic> _$EmailConfigToJson(EmailConfig instance) =>
    <String, dynamic>{
      'smtp': instance.smtp,
      'fromAddress': instance.fromAddress,
      'fromName': instance.fromName,
    };

EmailSmtpConfig _$EmailSmtpConfigFromJson(Map json) => $checkedCreate(
      'EmailSmtpConfig',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['host'],
        );
        final val = EmailSmtpConfig(
          host: $checkedConvert('host', (v) => v as String),
          port: $checkedConvert('port', (v) => v as int? ?? 25),
          ssl: $checkedConvert('ssl', (v) => v as bool? ?? false),
          username: $checkedConvert('username', (v) => v as String?),
          password: $checkedConvert('password', (v) => v as String?),
          allowInsecure:
              $checkedConvert('allowInsecure', (v) => v as bool? ?? false),
          ignoreBadCertificate: $checkedConvert(
              'ignoreBadCertificate', (v) => v as bool? ?? false),
        );
        return val;
      },
    );

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

SecretsConfig _$SecretsConfigFromJson(Map json) => $checkedCreate(
      'SecretsConfig',
      json,
      ($checkedConvert) {
        final val = SecretsConfig(
          recaptchaSecretKey:
              $checkedConvert('recaptchaSecretKey', (v) => v as String),
          recaptchaSiteKey:
              $checkedConvert('recaptchaSiteKey', (v) => v as String),
          emailReceiveToken:
              $checkedConvert('emailReceiveToken', (v) => v as String),
          systemStatusSecret:
              $checkedConvert('systemStatusSecret', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$SecretsConfigToJson(SecretsConfig instance) =>
    <String, dynamic>{
      'recaptchaSecretKey': instance.recaptchaSecretKey,
      'recaptchaSiteKey': instance.recaptchaSiteKey,
      'emailReceiveToken': instance.emailReceiveToken,
      'systemStatusSecret': instance.systemStatusSecret,
    };
