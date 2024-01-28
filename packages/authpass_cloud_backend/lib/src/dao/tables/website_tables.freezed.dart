// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
      _$WebsiteEntityCopyWithImpl<$Res, WebsiteEntity>;
  @useResult
  $Res call({String id, String url, String urlCanonical});
}

/// @nodoc
class _$WebsiteEntityCopyWithImpl<$Res, $Val extends WebsiteEntity>
    implements $WebsiteEntityCopyWith<$Res> {
  _$WebsiteEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? urlCanonical = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      urlCanonical: null == urlCanonical
          ? _value.urlCanonical
          : urlCanonical // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WebsiteEntityImplCopyWith<$Res>
    implements $WebsiteEntityCopyWith<$Res> {
  factory _$$WebsiteEntityImplCopyWith(
          _$WebsiteEntityImpl value, $Res Function(_$WebsiteEntityImpl) then) =
      __$$WebsiteEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String url, String urlCanonical});
}

/// @nodoc
class __$$WebsiteEntityImplCopyWithImpl<$Res>
    extends _$WebsiteEntityCopyWithImpl<$Res, _$WebsiteEntityImpl>
    implements _$$WebsiteEntityImplCopyWith<$Res> {
  __$$WebsiteEntityImplCopyWithImpl(
      _$WebsiteEntityImpl _value, $Res Function(_$WebsiteEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? urlCanonical = null,
  }) {
    return _then(_$WebsiteEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      urlCanonical: null == urlCanonical
          ? _value.urlCanonical
          : urlCanonical // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$WebsiteEntityImpl implements _WebsiteEntity {
  const _$WebsiteEntityImpl(
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebsiteEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.urlCanonical, urlCanonical) ||
                other.urlCanonical == urlCanonical));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, url, urlCanonical);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WebsiteEntityImplCopyWith<_$WebsiteEntityImpl> get copyWith =>
      __$$WebsiteEntityImplCopyWithImpl<_$WebsiteEntityImpl>(this, _$identity);
}

abstract class _WebsiteEntity implements WebsiteEntity {
  const factory _WebsiteEntity(
      {required final String id,
      required final String url,
      required final String urlCanonical}) = _$WebsiteEntityImpl;

  @override
  String get id;
  @override
  String get url;
  @override
  String get urlCanonical;
  @override
  @JsonKey(ignore: true)
  _$$WebsiteEntityImplCopyWith<_$WebsiteEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
