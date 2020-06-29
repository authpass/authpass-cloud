// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authpass_cloud.openapi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) {
  return RegisterRequest(
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) {
  return RegisterResponse(
    userUuid: json['userUuid'] as String,
    authToken: json['authToken'] as String,
    status:
        _$enumDecodeNullable(_$RegisterResponseStatusEnumMap, json['status']),
  );
}

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'userUuid': instance.userUuid,
      'authToken': instance.authToken,
      'status': _$RegisterResponseStatusEnumMap[instance.status],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$RegisterResponseStatusEnumMap = {
  RegisterResponseStatus.created: 'created',
  RegisterResponseStatus.confirmed: 'confirmed',
};

EmailStatusGetResponseBody200 _$EmailStatusGetResponseBody200FromJson(
    Map<String, dynamic> json) {
  return EmailStatusGetResponseBody200(
    status: _$enumDecodeNullable(
        _$EmailStatusGetResponseBody200StatusEnumMap, json['status']),
  );
}

Map<String, dynamic> _$EmailStatusGetResponseBody200ToJson(
        EmailStatusGetResponseBody200 instance) =>
    <String, dynamic>{
      'status': _$EmailStatusGetResponseBody200StatusEnumMap[instance.status],
    };

const _$EmailStatusGetResponseBody200StatusEnumMap = {
  EmailStatusGetResponseBody200Status.created: 'created',
  EmailStatusGetResponseBody200Status.confirmed: 'confirmed',
};

EmailConfirmSchema _$EmailConfirmSchemaFromJson(Map<String, dynamic> json) {
  return EmailConfirmSchema(
    token: json['token'] as String,
    gRecaptchaResponse: json['g-recaptcha-response'] as String,
  );
}

Map<String, dynamic> _$EmailConfirmSchemaToJson(EmailConfirmSchema instance) =>
    <String, dynamic>{
      'token': instance.token,
      'g-recaptcha-response': instance.gRecaptchaResponse,
    };

MailboxCreatePostResponseBody200 _$MailboxCreatePostResponseBody200FromJson(
    Map<String, dynamic> json) {
  return MailboxCreatePostResponseBody200(
    address: json['address'] as String,
  );
}

Map<String, dynamic> _$MailboxCreatePostResponseBody200ToJson(
        MailboxCreatePostResponseBody200 instance) =>
    <String, dynamic>{
      'address': instance.address,
    };

MailboxCreateSchema _$MailboxCreateSchemaFromJson(Map<String, dynamic> json) {
  return MailboxCreateSchema(
    label: json['label'] as String,
    entryUuid: json['entryUuid'] as String,
  );
}

Map<String, dynamic> _$MailboxCreateSchemaToJson(
        MailboxCreateSchema instance) =>
    <String, dynamic>{
      'label': instance.label,
      'entryUuid': instance.entryUuid,
    };
