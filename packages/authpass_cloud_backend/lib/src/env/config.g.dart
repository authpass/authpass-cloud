// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigFileRoot _$ConfigFileRootFromJson(Map json) {
  return ConfigFileRoot(
    email: EmailConfig.fromJson(json['email'] as Map),
    secrets: SecretsConfig.fromJson(json['secrets'] as Map),
  );
}

Map<String, dynamic> _$ConfigFileRootToJson(ConfigFileRoot instance) =>
    <String, dynamic>{
      'email': instance.email,
      'secrets': instance.secrets,
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
