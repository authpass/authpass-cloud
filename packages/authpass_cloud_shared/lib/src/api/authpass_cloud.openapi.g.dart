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
