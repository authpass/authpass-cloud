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
  );
}

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'userUuid': instance.userUuid,
    };
