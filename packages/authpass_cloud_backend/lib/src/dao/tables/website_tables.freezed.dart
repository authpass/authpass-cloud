// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'website_tables.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WebsiteEntity {
  String get id => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get urlCanonical => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WebsiteEntityCopyWith<WebsiteEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebsiteEntityCopyWith<$Res> {
  factory $WebsiteEntityCopyWith(
          WebsiteEntity value, $Res Function(WebsiteEntity) then) =
      _$WebsiteEntityCopyWithImpl<$Res>;
  $Res call({String id, String url, String urlCanonical});
}

/// @nodoc
class _$WebsiteEntityCopyWithImpl<$Res>
    implements $WebsiteEntityCopyWith<$Res> {
  _$WebsiteEntityCopyWithImpl(this._value, this._then);

  final WebsiteEntity _value;
  // ignore: unused_field
  final $Res Function(WebsiteEntity) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? url = freezed,
    Object? urlCanonical = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      urlCanonical: urlCanonical == freezed
          ? _value.urlCanonical
          : urlCanonical // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_WebsiteEntityCopyWith<$Res>
    implements $WebsiteEntityCopyWith<$Res> {
  factory _$$_WebsiteEntityCopyWith(
          _$_WebsiteEntity value, $Res Function(_$_WebsiteEntity) then) =
      __$$_WebsiteEntityCopyWithImpl<$Res>;
  @override
  $Res call({String id, String url, String urlCanonical});
}

/// @nodoc
class __$$_WebsiteEntityCopyWithImpl<$Res>
    extends _$WebsiteEntityCopyWithImpl<$Res>
    implements _$$_WebsiteEntityCopyWith<$Res> {
  __$$_WebsiteEntityCopyWithImpl(
      _$_WebsiteEntity _value, $Res Function(_$_WebsiteEntity) _then)
      : super(_value, (v) => _then(v as _$_WebsiteEntity));

  @override
  _$_WebsiteEntity get _value => super._value as _$_WebsiteEntity;

  @override
  $Res call({
    Object? id = freezed,
    Object? url = freezed,
    Object? urlCanonical = freezed,
  }) {
    return _then(_$_WebsiteEntity(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      urlCanonical: urlCanonical == freezed
          ? _value.urlCanonical
          : urlCanonical // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_WebsiteEntity implements _WebsiteEntity {
  const _$_WebsiteEntity(
      {required this.id, required this.url, required this.urlCanonical});

  @override
  final String id;
  @override
  final String url;
  @override
  final String urlCanonical;

  @override
  String toString() {
    return 'WebsiteEntity(id: $id, url: $url, urlCanonical: $urlCanonical)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WebsiteEntity &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality()
                .equals(other.urlCanonical, urlCanonical));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(urlCanonical));

  @JsonKey(ignore: true)
  @override
  _$$_WebsiteEntityCopyWith<_$_WebsiteEntity> get copyWith =>
      __$$_WebsiteEntityCopyWithImpl<_$_WebsiteEntity>(this, _$identity);
}

abstract class _WebsiteEntity implements WebsiteEntity {
  const factory _WebsiteEntity(
      {required final String id,
      required final String url,
      required final String urlCanonical}) = _$_WebsiteEntity;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get url => throw _privateConstructorUsedError;
  @override
  String get urlCanonical => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_WebsiteEntityCopyWith<_$_WebsiteEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
