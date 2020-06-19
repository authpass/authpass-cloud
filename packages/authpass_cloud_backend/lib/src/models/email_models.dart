import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_models.freezed.dart';
part 'email_models.g.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    @required String name,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}
