// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'email_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
UserEntity _$UserEntityFromJson(Map<String, dynamic> json) {
  return _UserEntity.fromJson(json);
}

class _$UserEntityTearOff {
  const _$UserEntityTearOff();

  _UserEntity call({@required String name}) {
    return _UserEntity(
      name: name,
    );
  }
}

// ignore: unused_element
const $UserEntity = _$UserEntityTearOff();

mixin _$UserEntity {
  String get name;

  Map<String, dynamic> toJson();
  $UserEntityCopyWith<UserEntity> get copyWith;
}

abstract class $UserEntityCopyWith<$Res> {
  factory $UserEntityCopyWith(
          UserEntity value, $Res Function(UserEntity) then) =
      _$UserEntityCopyWithImpl<$Res>;
  $Res call({String name});
}

class _$UserEntityCopyWithImpl<$Res> implements $UserEntityCopyWith<$Res> {
  _$UserEntityCopyWithImpl(this._value, this._then);

  final UserEntity _value;
  // ignore: unused_field
  final $Res Function(UserEntity) _then;

  @override
  $Res call({
    Object name = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed ? _value.name : name as String,
    ));
  }
}

abstract class _$UserEntityCopyWith<$Res> implements $UserEntityCopyWith<$Res> {
  factory _$UserEntityCopyWith(
          _UserEntity value, $Res Function(_UserEntity) then) =
      __$UserEntityCopyWithImpl<$Res>;
  @override
  $Res call({String name});
}

class __$UserEntityCopyWithImpl<$Res> extends _$UserEntityCopyWithImpl<$Res>
    implements _$UserEntityCopyWith<$Res> {
  __$UserEntityCopyWithImpl(
      _UserEntity _value, $Res Function(_UserEntity) _then)
      : super(_value, (v) => _then(v as _UserEntity));

  @override
  _UserEntity get _value => super._value as _UserEntity;

  @override
  $Res call({
    Object name = freezed,
  }) {
    return _then(_UserEntity(
      name: name == freezed ? _value.name : name as String,
    ));
  }
}

@JsonSerializable()
class _$_UserEntity implements _UserEntity {
  const _$_UserEntity({@required this.name}) : assert(name != null);

  factory _$_UserEntity.fromJson(Map<String, dynamic> json) =>
      _$_$_UserEntityFromJson(json);

  @override
  final String name;

  @override
  String toString() {
    return 'UserEntity(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UserEntity &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(name);

  @override
  _$UserEntityCopyWith<_UserEntity> get copyWith =>
      __$UserEntityCopyWithImpl<_UserEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_UserEntityToJson(this);
  }
}

abstract class _UserEntity implements UserEntity {
  const factory _UserEntity({@required String name}) = _$_UserEntity;

  factory _UserEntity.fromJson(Map<String, dynamic> json) =
      _$_UserEntity.fromJson;

  @override
  String get name;
  @override
  _$UserEntityCopyWith<_UserEntity> get copyWith;
}
