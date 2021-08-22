// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'filecloud_tables.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CleanupStats _$CleanupStatsFromJson(Map<String, dynamic> json) {
  return _CleanupStats.fromJson(json);
}

/// @nodoc
class _$CleanupStatsTearOff {
  const _$CleanupStatsTearOff();

  _CleanupStats call(
      {required int timeMs,
      required int count,
      required VersionSignificance versionSignificance}) {
    return _CleanupStats(
      timeMs: timeMs,
      count: count,
      versionSignificance: versionSignificance,
    );
  }

  CleanupStats fromJson(Map<String, Object> json) {
    return CleanupStats.fromJson(json);
  }
}

/// @nodoc
const $CleanupStats = _$CleanupStatsTearOff();

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
abstract class _$CleanupStatsCopyWith<$Res>
    implements $CleanupStatsCopyWith<$Res> {
  factory _$CleanupStatsCopyWith(
          _CleanupStats value, $Res Function(_CleanupStats) then) =
      __$CleanupStatsCopyWithImpl<$Res>;
  @override
  $Res call({int timeMs, int count, VersionSignificance versionSignificance});
}

/// @nodoc
class __$CleanupStatsCopyWithImpl<$Res> extends _$CleanupStatsCopyWithImpl<$Res>
    implements _$CleanupStatsCopyWith<$Res> {
  __$CleanupStatsCopyWithImpl(
      _CleanupStats _value, $Res Function(_CleanupStats) _then)
      : super(_value, (v) => _then(v as _CleanupStats));

  @override
  _CleanupStats get _value => super._value as _CleanupStats;

  @override
  $Res call({
    Object? timeMs = freezed,
    Object? count = freezed,
    Object? versionSignificance = freezed,
  }) {
    return _then(_CleanupStats(
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
        (other is _CleanupStats &&
            (identical(other.timeMs, timeMs) ||
                const DeepCollectionEquality().equals(other.timeMs, timeMs)) &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.versionSignificance, versionSignificance) ||
                const DeepCollectionEquality()
                    .equals(other.versionSignificance, versionSignificance)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(timeMs) ^
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(versionSignificance);

  @JsonKey(ignore: true)
  @override
  _$CleanupStatsCopyWith<_CleanupStats> get copyWith =>
      __$CleanupStatsCopyWithImpl<_CleanupStats>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CleanupStatsToJson(this);
  }
}

abstract class _CleanupStats implements CleanupStats {
  const factory _CleanupStats(
      {required int timeMs,
      required int count,
      required VersionSignificance versionSignificance}) = _$_CleanupStats;

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
  _$CleanupStatsCopyWith<_CleanupStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$FileContentDebugTearOff {
  const _$FileContentDebugTearOff();

  _FileContentDebug call(
      {required DateTime createdAt,
      required VersionSignificance? versionSignificance,
      required int contentCount}) {
    return _FileContentDebug(
      createdAt: createdAt,
      versionSignificance: versionSignificance,
      contentCount: contentCount,
    );
  }
}

/// @nodoc
const $FileContentDebug = _$FileContentDebugTearOff();

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
abstract class _$FileContentDebugCopyWith<$Res>
    implements $FileContentDebugCopyWith<$Res> {
  factory _$FileContentDebugCopyWith(
          _FileContentDebug value, $Res Function(_FileContentDebug) then) =
      __$FileContentDebugCopyWithImpl<$Res>;
  @override
  $Res call(
      {DateTime createdAt,
      VersionSignificance? versionSignificance,
      int contentCount});
}

/// @nodoc
class __$FileContentDebugCopyWithImpl<$Res>
    extends _$FileContentDebugCopyWithImpl<$Res>
    implements _$FileContentDebugCopyWith<$Res> {
  __$FileContentDebugCopyWithImpl(
      _FileContentDebug _value, $Res Function(_FileContentDebug) _then)
      : super(_value, (v) => _then(v as _FileContentDebug));

  @override
  _FileContentDebug get _value => super._value as _FileContentDebug;

  @override
  $Res call({
    Object? createdAt = freezed,
    Object? versionSignificance = freezed,
    Object? contentCount = freezed,
  }) {
    return _then(_FileContentDebug(
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
        (other is _FileContentDebug &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.versionSignificance, versionSignificance) ||
                const DeepCollectionEquality()
                    .equals(other.versionSignificance, versionSignificance)) &&
            (identical(other.contentCount, contentCount) ||
                const DeepCollectionEquality()
                    .equals(other.contentCount, contentCount)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(versionSignificance) ^
      const DeepCollectionEquality().hash(contentCount);

  @JsonKey(ignore: true)
  @override
  _$FileContentDebugCopyWith<_FileContentDebug> get copyWith =>
      __$FileContentDebugCopyWithImpl<_FileContentDebug>(this, _$identity);
}

abstract class _FileContentDebug implements FileContentDebug {
  const factory _FileContentDebug(
      {required DateTime createdAt,
      required VersionSignificance? versionSignificance,
      required int contentCount}) = _$_FileContentDebug;

  @override
  DateTime get createdAt => throw _privateConstructorUsedError;
  @override
  VersionSignificance? get versionSignificance =>
      throw _privateConstructorUsedError;
  @override
  int get contentCount => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FileContentDebugCopyWith<_FileContentDebug> get copyWith =>
      throw _privateConstructorUsedError;
}

CleanupStatsLog _$CleanupStatsLogFromJson(Map<String, dynamic> json) {
  return _CleanupStatsLog.fromJson(json);
}

/// @nodoc
class _$CleanupStatsLogTearOff {
  const _$CleanupStatsLogTearOff();

  _CleanupStatsLog call(
      {required int timeMs,
      required int cleanupCount,
      required List<CleanupStats> cleanupStats}) {
    return _CleanupStatsLog(
      timeMs: timeMs,
      cleanupCount: cleanupCount,
      cleanupStats: cleanupStats,
    );
  }

  CleanupStatsLog fromJson(Map<String, Object> json) {
    return CleanupStatsLog.fromJson(json);
  }
}

/// @nodoc
const $CleanupStatsLog = _$CleanupStatsLogTearOff();

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
abstract class _$CleanupStatsLogCopyWith<$Res>
    implements $CleanupStatsLogCopyWith<$Res> {
  factory _$CleanupStatsLogCopyWith(
          _CleanupStatsLog value, $Res Function(_CleanupStatsLog) then) =
      __$CleanupStatsLogCopyWithImpl<$Res>;
  @override
  $Res call({int timeMs, int cleanupCount, List<CleanupStats> cleanupStats});
}

/// @nodoc
class __$CleanupStatsLogCopyWithImpl<$Res>
    extends _$CleanupStatsLogCopyWithImpl<$Res>
    implements _$CleanupStatsLogCopyWith<$Res> {
  __$CleanupStatsLogCopyWithImpl(
      _CleanupStatsLog _value, $Res Function(_CleanupStatsLog) _then)
      : super(_value, (v) => _then(v as _CleanupStatsLog));

  @override
  _CleanupStatsLog get _value => super._value as _CleanupStatsLog;

  @override
  $Res call({
    Object? timeMs = freezed,
    Object? cleanupCount = freezed,
    Object? cleanupStats = freezed,
  }) {
    return _then(_CleanupStatsLog(
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
@JsonSerializable()
class _$_CleanupStatsLog extends _CleanupStatsLog {
  const _$_CleanupStatsLog(
      {required this.timeMs,
      required this.cleanupCount,
      required this.cleanupStats})
      : super._();

  factory _$_CleanupStatsLog.fromJson(Map<String, dynamic> json) =>
      _$$_CleanupStatsLogFromJson(json);

  @override
  final int timeMs;
  @override
  final int cleanupCount;
  @override
  final List<CleanupStats> cleanupStats;

  @override
  String toString() {
    return 'CleanupStatsLog(timeMs: $timeMs, cleanupCount: $cleanupCount, cleanupStats: $cleanupStats)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CleanupStatsLog &&
            (identical(other.timeMs, timeMs) ||
                const DeepCollectionEquality().equals(other.timeMs, timeMs)) &&
            (identical(other.cleanupCount, cleanupCount) ||
                const DeepCollectionEquality()
                    .equals(other.cleanupCount, cleanupCount)) &&
            (identical(other.cleanupStats, cleanupStats) ||
                const DeepCollectionEquality()
                    .equals(other.cleanupStats, cleanupStats)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(timeMs) ^
      const DeepCollectionEquality().hash(cleanupCount) ^
      const DeepCollectionEquality().hash(cleanupStats);

  @JsonKey(ignore: true)
  @override
  _$CleanupStatsLogCopyWith<_CleanupStatsLog> get copyWith =>
      __$CleanupStatsLogCopyWithImpl<_CleanupStatsLog>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CleanupStatsLogToJson(this);
  }
}

abstract class _CleanupStatsLog extends CleanupStatsLog {
  const factory _CleanupStatsLog(
      {required int timeMs,
      required int cleanupCount,
      required List<CleanupStats> cleanupStats}) = _$_CleanupStatsLog;
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
  _$CleanupStatsLogCopyWith<_CleanupStatsLog> get copyWith =>
      throw _privateConstructorUsedError;
}
