// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'filecloud_tables.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CleanupStats _$CleanupStatsFromJson(Map<String, dynamic> json) {
  return _CleanupStats.fromJson(json);
}

/// @nodoc
mixin _$CleanupStats {
  int get timeMs => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  VersionSignificance get versionSignificance =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CleanupStatsCopyWith<CleanupStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CleanupStatsCopyWith<$Res> {
  factory $CleanupStatsCopyWith(
          CleanupStats value, $Res Function(CleanupStats) then) =
      _$CleanupStatsCopyWithImpl<$Res>;
  $Res call({int timeMs, int count, VersionSignificance versionSignificance});
}

/// @nodoc
class _$CleanupStatsCopyWithImpl<$Res> implements $CleanupStatsCopyWith<$Res> {
  _$CleanupStatsCopyWithImpl(this._value, this._then);

  final CleanupStats _value;
  // ignore: unused_field
  final $Res Function(CleanupStats) _then;

  @override
  $Res call({
    Object? timeMs = freezed,
    Object? count = freezed,
    Object? versionSignificance = freezed,
  }) {
    return _then(_value.copyWith(
      timeMs: timeMs == freezed
          ? _value.timeMs
          : timeMs // ignore: cast_nullable_to_non_nullable
              as int,
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      versionSignificance: versionSignificance == freezed
          ? _value.versionSignificance
          : versionSignificance // ignore: cast_nullable_to_non_nullable
              as VersionSignificance,
    ));
  }
}

/// @nodoc
abstract class _$$_CleanupStatsCopyWith<$Res>
    implements $CleanupStatsCopyWith<$Res> {
  factory _$$_CleanupStatsCopyWith(
          _$_CleanupStats value, $Res Function(_$_CleanupStats) then) =
      __$$_CleanupStatsCopyWithImpl<$Res>;
  @override
  $Res call({int timeMs, int count, VersionSignificance versionSignificance});
}

/// @nodoc
class __$$_CleanupStatsCopyWithImpl<$Res>
    extends _$CleanupStatsCopyWithImpl<$Res>
    implements _$$_CleanupStatsCopyWith<$Res> {
  __$$_CleanupStatsCopyWithImpl(
      _$_CleanupStats _value, $Res Function(_$_CleanupStats) _then)
      : super(_value, (v) => _then(v as _$_CleanupStats));

  @override
  _$_CleanupStats get _value => super._value as _$_CleanupStats;

  @override
  $Res call({
    Object? timeMs = freezed,
    Object? count = freezed,
    Object? versionSignificance = freezed,
  }) {
    return _then(_$_CleanupStats(
      timeMs: timeMs == freezed
          ? _value.timeMs
          : timeMs // ignore: cast_nullable_to_non_nullable
              as int,
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      versionSignificance: versionSignificance == freezed
          ? _value.versionSignificance
          : versionSignificance // ignore: cast_nullable_to_non_nullable
              as VersionSignificance,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CleanupStats implements _CleanupStats {
  const _$_CleanupStats(
      {required this.timeMs,
      required this.count,
      required this.versionSignificance});

  factory _$_CleanupStats.fromJson(Map<String, dynamic> json) =>
      _$$_CleanupStatsFromJson(json);

  @override
  final int timeMs;
  @override
  final int count;
  @override
  final VersionSignificance versionSignificance;

  @override
  String toString() {
    return 'CleanupStats(timeMs: $timeMs, count: $count, versionSignificance: $versionSignificance)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CleanupStats &&
            const DeepCollectionEquality().equals(other.timeMs, timeMs) &&
            const DeepCollectionEquality().equals(other.count, count) &&
            const DeepCollectionEquality()
                .equals(other.versionSignificance, versionSignificance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(timeMs),
      const DeepCollectionEquality().hash(count),
      const DeepCollectionEquality().hash(versionSignificance));

  @JsonKey(ignore: true)
  @override
  _$$_CleanupStatsCopyWith<_$_CleanupStats> get copyWith =>
      __$$_CleanupStatsCopyWithImpl<_$_CleanupStats>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CleanupStatsToJson(this);
  }
}

abstract class _CleanupStats implements CleanupStats {
  const factory _CleanupStats(
          {required final int timeMs,
          required final int count,
          required final VersionSignificance versionSignificance}) =
      _$_CleanupStats;

  factory _CleanupStats.fromJson(Map<String, dynamic> json) =
      _$_CleanupStats.fromJson;

  @override
  int get timeMs => throw _privateConstructorUsedError;
  @override
  int get count => throw _privateConstructorUsedError;
  @override
  VersionSignificance get versionSignificance =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CleanupStatsCopyWith<_$_CleanupStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FileContentDebug {
  DateTime get createdAt => throw _privateConstructorUsedError;
  VersionSignificance? get versionSignificance =>
      throw _privateConstructorUsedError;
  int get contentCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FileContentDebugCopyWith<FileContentDebug> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FileContentDebugCopyWith<$Res> {
  factory $FileContentDebugCopyWith(
          FileContentDebug value, $Res Function(FileContentDebug) then) =
      _$FileContentDebugCopyWithImpl<$Res>;
  $Res call(
      {DateTime createdAt,
      VersionSignificance? versionSignificance,
      int contentCount});
}

/// @nodoc
class _$FileContentDebugCopyWithImpl<$Res>
    implements $FileContentDebugCopyWith<$Res> {
  _$FileContentDebugCopyWithImpl(this._value, this._then);

  final FileContentDebug _value;
  // ignore: unused_field
  final $Res Function(FileContentDebug) _then;

  @override
  $Res call({
    Object? createdAt = freezed,
    Object? versionSignificance = freezed,
    Object? contentCount = freezed,
  }) {
    return _then(_value.copyWith(
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      versionSignificance: versionSignificance == freezed
          ? _value.versionSignificance
          : versionSignificance // ignore: cast_nullable_to_non_nullable
              as VersionSignificance?,
      contentCount: contentCount == freezed
          ? _value.contentCount
          : contentCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_FileContentDebugCopyWith<$Res>
    implements $FileContentDebugCopyWith<$Res> {
  factory _$$_FileContentDebugCopyWith(
          _$_FileContentDebug value, $Res Function(_$_FileContentDebug) then) =
      __$$_FileContentDebugCopyWithImpl<$Res>;
  @override
  $Res call(
      {DateTime createdAt,
      VersionSignificance? versionSignificance,
      int contentCount});
}

/// @nodoc
class __$$_FileContentDebugCopyWithImpl<$Res>
    extends _$FileContentDebugCopyWithImpl<$Res>
    implements _$$_FileContentDebugCopyWith<$Res> {
  __$$_FileContentDebugCopyWithImpl(
      _$_FileContentDebug _value, $Res Function(_$_FileContentDebug) _then)
      : super(_value, (v) => _then(v as _$_FileContentDebug));

  @override
  _$_FileContentDebug get _value => super._value as _$_FileContentDebug;

  @override
  $Res call({
    Object? createdAt = freezed,
    Object? versionSignificance = freezed,
    Object? contentCount = freezed,
  }) {
    return _then(_$_FileContentDebug(
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      versionSignificance: versionSignificance == freezed
          ? _value.versionSignificance
          : versionSignificance // ignore: cast_nullable_to_non_nullable
              as VersionSignificance?,
      contentCount: contentCount == freezed
          ? _value.contentCount
          : contentCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_FileContentDebug implements _FileContentDebug {
  const _$_FileContentDebug(
      {required this.createdAt,
      required this.versionSignificance,
      required this.contentCount});

  @override
  final DateTime createdAt;
  @override
  final VersionSignificance? versionSignificance;
  @override
  final int contentCount;

  @override
  String toString() {
    return 'FileContentDebug(createdAt: $createdAt, versionSignificance: $versionSignificance, contentCount: $contentCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FileContentDebug &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality()
                .equals(other.versionSignificance, versionSignificance) &&
            const DeepCollectionEquality()
                .equals(other.contentCount, contentCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(versionSignificance),
      const DeepCollectionEquality().hash(contentCount));

  @JsonKey(ignore: true)
  @override
  _$$_FileContentDebugCopyWith<_$_FileContentDebug> get copyWith =>
      __$$_FileContentDebugCopyWithImpl<_$_FileContentDebug>(this, _$identity);
}

abstract class _FileContentDebug implements FileContentDebug {
  const factory _FileContentDebug(
      {required final DateTime createdAt,
      required final VersionSignificance? versionSignificance,
      required final int contentCount}) = _$_FileContentDebug;

  @override
  DateTime get createdAt => throw _privateConstructorUsedError;
  @override
  VersionSignificance? get versionSignificance =>
      throw _privateConstructorUsedError;
  @override
  int get contentCount => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_FileContentDebugCopyWith<_$_FileContentDebug> get copyWith =>
      throw _privateConstructorUsedError;
}

CleanupStatsLog _$CleanupStatsLogFromJson(Map<String, dynamic> json) {
  return _CleanupStatsLog.fromJson(json);
}

/// @nodoc
mixin _$CleanupStatsLog {
  int get timeMs => throw _privateConstructorUsedError;
  int get cleanupCount => throw _privateConstructorUsedError;
  List<CleanupStats> get cleanupStats => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CleanupStatsLogCopyWith<CleanupStatsLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CleanupStatsLogCopyWith<$Res> {
  factory $CleanupStatsLogCopyWith(
          CleanupStatsLog value, $Res Function(CleanupStatsLog) then) =
      _$CleanupStatsLogCopyWithImpl<$Res>;
  $Res call({int timeMs, int cleanupCount, List<CleanupStats> cleanupStats});
}

/// @nodoc
class _$CleanupStatsLogCopyWithImpl<$Res>
    implements $CleanupStatsLogCopyWith<$Res> {
  _$CleanupStatsLogCopyWithImpl(this._value, this._then);

  final CleanupStatsLog _value;
  // ignore: unused_field
  final $Res Function(CleanupStatsLog) _then;

  @override
  $Res call({
    Object? timeMs = freezed,
    Object? cleanupCount = freezed,
    Object? cleanupStats = freezed,
  }) {
    return _then(_value.copyWith(
      timeMs: timeMs == freezed
          ? _value.timeMs
          : timeMs // ignore: cast_nullable_to_non_nullable
              as int,
      cleanupCount: cleanupCount == freezed
          ? _value.cleanupCount
          : cleanupCount // ignore: cast_nullable_to_non_nullable
              as int,
      cleanupStats: cleanupStats == freezed
          ? _value.cleanupStats
          : cleanupStats // ignore: cast_nullable_to_non_nullable
              as List<CleanupStats>,
    ));
  }
}

/// @nodoc
abstract class _$$_CleanupStatsLogCopyWith<$Res>
    implements $CleanupStatsLogCopyWith<$Res> {
  factory _$$_CleanupStatsLogCopyWith(
          _$_CleanupStatsLog value, $Res Function(_$_CleanupStatsLog) then) =
      __$$_CleanupStatsLogCopyWithImpl<$Res>;
  @override
  $Res call({int timeMs, int cleanupCount, List<CleanupStats> cleanupStats});
}

/// @nodoc
class __$$_CleanupStatsLogCopyWithImpl<$Res>
    extends _$CleanupStatsLogCopyWithImpl<$Res>
    implements _$$_CleanupStatsLogCopyWith<$Res> {
  __$$_CleanupStatsLogCopyWithImpl(
      _$_CleanupStatsLog _value, $Res Function(_$_CleanupStatsLog) _then)
      : super(_value, (v) => _then(v as _$_CleanupStatsLog));

  @override
  _$_CleanupStatsLog get _value => super._value as _$_CleanupStatsLog;

  @override
  $Res call({
    Object? timeMs = freezed,
    Object? cleanupCount = freezed,
    Object? cleanupStats = freezed,
  }) {
    return _then(_$_CleanupStatsLog(
      timeMs: timeMs == freezed
          ? _value.timeMs
          : timeMs // ignore: cast_nullable_to_non_nullable
              as int,
      cleanupCount: cleanupCount == freezed
          ? _value.cleanupCount
          : cleanupCount // ignore: cast_nullable_to_non_nullable
              as int,
      cleanupStats: cleanupStats == freezed
          ? _value._cleanupStats
          : cleanupStats // ignore: cast_nullable_to_non_nullable
              as List<CleanupStats>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CleanupStatsLog extends _CleanupStatsLog {
  const _$_CleanupStatsLog(
      {required this.timeMs,
      required this.cleanupCount,
      required final List<CleanupStats> cleanupStats})
      : _cleanupStats = cleanupStats,
        super._();

  factory _$_CleanupStatsLog.fromJson(Map<String, dynamic> json) =>
      _$$_CleanupStatsLogFromJson(json);

  @override
  final int timeMs;
  @override
  final int cleanupCount;
  final List<CleanupStats> _cleanupStats;
  @override
  List<CleanupStats> get cleanupStats {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cleanupStats);
  }

  @override
  String toString() {
    return 'CleanupStatsLog(timeMs: $timeMs, cleanupCount: $cleanupCount, cleanupStats: $cleanupStats)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CleanupStatsLog &&
            const DeepCollectionEquality().equals(other.timeMs, timeMs) &&
            const DeepCollectionEquality()
                .equals(other.cleanupCount, cleanupCount) &&
            const DeepCollectionEquality()
                .equals(other._cleanupStats, _cleanupStats));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(timeMs),
      const DeepCollectionEquality().hash(cleanupCount),
      const DeepCollectionEquality().hash(_cleanupStats));

  @JsonKey(ignore: true)
  @override
  _$$_CleanupStatsLogCopyWith<_$_CleanupStatsLog> get copyWith =>
      __$$_CleanupStatsLogCopyWithImpl<_$_CleanupStatsLog>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CleanupStatsLogToJson(this);
  }
}

abstract class _CleanupStatsLog extends CleanupStatsLog {
  const factory _CleanupStatsLog(
      {required final int timeMs,
      required final int cleanupCount,
      required final List<CleanupStats> cleanupStats}) = _$_CleanupStatsLog;
  const _CleanupStatsLog._() : super._();

  factory _CleanupStatsLog.fromJson(Map<String, dynamic> json) =
      _$_CleanupStatsLog.fromJson;

  @override
  int get timeMs => throw _privateConstructorUsedError;
  @override
  int get cleanupCount => throw _privateConstructorUsedError;
  @override
  List<CleanupStats> get cleanupStats => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CleanupStatsLogCopyWith<_$_CleanupStatsLog> get copyWith =>
      throw _privateConstructorUsedError;
}
