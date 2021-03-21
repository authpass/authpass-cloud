// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'website_tables.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$WebsiteEntityTearOff {
  const _$WebsiteEntityTearOff();

// ignore: unused_element
  _WebsiteEntity call(
      {required String id, required String url, required String urlCanonical}) {
    return _WebsiteEntity(
      id: id,
      url: url,
      urlCanonical: urlCanonical,
    );
  }
}

// ignore: unused_element
const $WebsiteEntity = _$WebsiteEntityTearOff();

mixin _$WebsiteEntity {
  String get id;
  String get url;
  String get urlCanonical;

  $WebsiteEntityCopyWith<WebsiteEntity> get copyWith;
}

abstract class $WebsiteEntityCopyWith<$Res> {
  factory $WebsiteEntityCopyWith(
          WebsiteEntity value, $Res Function(WebsiteEntity) then) =
      _$WebsiteEntityCopyWithImpl<$Res>;
  $Res call({String? id, String? url, String? urlCanonical});
}

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
      id: id == freezed ? _value.id : id as String?,
      url: url == freezed ? _value.url : url as String?,
      urlCanonical: urlCanonical == freezed
          ? _value.urlCanonical
          : urlCanonical as String?,
    ));
  }
}

abstract class _$WebsiteEntityCopyWith<$Res>
    implements $WebsiteEntityCopyWith<$Res> {
  factory _$WebsiteEntityCopyWith(
          _WebsiteEntity value, $Res Function(_WebsiteEntity) then) =
      __$WebsiteEntityCopyWithImpl<$Res>;
  @override
  $Res call({String? id, String? url, String? urlCanonical});
}

class __$WebsiteEntityCopyWithImpl<$Res>
    extends _$WebsiteEntityCopyWithImpl<$Res>
    implements _$WebsiteEntityCopyWith<$Res> {
  __$WebsiteEntityCopyWithImpl(
      _WebsiteEntity _value, $Res Function(_WebsiteEntity) _then)
      : super(_value, (v) => _then(v as _WebsiteEntity));

  @override
  _WebsiteEntity get _value => super._value as _WebsiteEntity;

  @override
  $Res call({
    Object? id = freezed,
    Object? url = freezed,
    Object? urlCanonical = freezed,
  }) {
    return _then(_WebsiteEntity(
      id: id == freezed ? _value.id : (id as String?)!,
      url: url == freezed ? _value.url : (url as String?)!,
      urlCanonical: urlCanonical == freezed
          ? _value.urlCanonical
          : (urlCanonical as String?)!,
    ));
  }
}

class _$_WebsiteEntity implements _WebsiteEntity {
  const _$_WebsiteEntity(
      {required this.id, required this.url, required this.urlCanonical})
      : assert(id != null),
        assert(url != null),
        assert(urlCanonical != null);

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
        (other is _WebsiteEntity &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.urlCanonical, urlCanonical) ||
                const DeepCollectionEquality()
                    .equals(other.urlCanonical, urlCanonical)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(urlCanonical);

  @override
  _$WebsiteEntityCopyWith<_WebsiteEntity> get copyWith =>
      __$WebsiteEntityCopyWithImpl<_WebsiteEntity>(this, _$identity);
}

abstract class _WebsiteEntity implements WebsiteEntity {
  const factory _WebsiteEntity(
      {required String id,
      required String url,
      required String urlCanonical}) = _$_WebsiteEntity;

  @override
  String get id;
  @override
  String get url;
  @override
  String get urlCanonical;
  @override
  _$WebsiteEntityCopyWith<_WebsiteEntity> get copyWith;
}
