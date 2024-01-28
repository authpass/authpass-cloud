// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
      _$CleanupStatsCopyWithImpl<$Res, CleanupStats>;
  @useResult
  $Res call({int timeMs, int count, VersionSignificance versionSignificance});
}

/// @nodoc
class _$CleanupStatsCopyWithImpl<$Res, $Val extends CleanupStats>
    implements $CleanupStatsCopyWith<$Res> {
  _$CleanupStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeMs = null,
    Object? count = null,
    Object? versionSignificance = null,
  }) {
    return _then(_value.copyWith(
      timeMs: null == timeMs
          ? _value.timeMs
          : timeMs // ignore: cast_nullable_to_non_nullable
              as int,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      versionSignificance: null == versionSignificance
          ? _value.versionSignificance
          : versionSignificance // ignore: cast_nullable_to_non_nullable
              as VersionSignificance,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CleanupStatsImplCopyWith<$Res>
    implements $CleanupStatsCopyWith<$Res> {
  factory _$$CleanupStatsImplCopyWith(
          _$CleanupStatsImpl value, $Res Function(_$CleanupStatsImpl) then) =
      __$$CleanupStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int timeMs, int count, VersionSignificance versionSignificance});
}

/// @nodoc
class __$$CleanupStatsImplCopyWithImpl<$Res>
    extends _$CleanupStatsCopyWithImpl<$Res, _$CleanupStatsImpl>
    implements _$$CleanupStatsImplCopyWith<$Res> {
  __$$CleanupStatsImplCopyWithImpl(
      _$CleanupStatsImpl _value, $Res Function(_$CleanupStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeMs = null,
    Object? count = null,
    Object? versionSignificance = null,
  }) {
    return _then(_$CleanupStatsImpl(
      timeMs: null == timeMs
          ? _value.timeMs
          : timeMs // ignore: cast_nullable_to_non_nullable
              as int,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      versionSignificance: null == versionSignificance
          ? _value.versionSignificance
          : versionSignificance // ignore: cast_nullable_to_non_nullable
              as VersionSignificance,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CleanupStatsImpl implements _CleanupStats {
  const _$CleanupStatsImpl(
      {required this.timeMs,
      required this.count,
      required this.versionSignificance});

  factory _$CleanupStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CleanupStatsImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CleanupStatsImpl &&
            (identical(other.timeMs, timeMs) || other.timeMs == timeMs) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.versionSignificance, versionSignificance) ||
                other.versionSignificance == versionSignificance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, timeMs, count, versionSignificance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CleanupStatsImplCopyWith<_$CleanupStatsImpl> get copyWith =>
      __$$CleanupStatsImplCopyWithImpl<_$CleanupStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CleanupStatsImplToJson(
      this,
    );
  }
}

abstract class _CleanupStats implements CleanupStats {
  const factory _CleanupStats(
          {required final int timeMs,
          required final int count,
          required final VersionSignificance versionSignificance}) =
      _$CleanupStatsImpl;

  factory _CleanupStats.fromJson(Map<String, dynamic> json) =
      _$CleanupStatsImpl.fromJson;

  @override
  int get timeMs;
  @override
  int get count;
  @override
  VersionSignificance get versionSignificance;
  @override
  @JsonKey(ignore: true)
  _$$CleanupStatsImplCopyWith<_$CleanupStatsImpl> get copyWith =>
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
      _$FileContentDebugCopyWithImpl<$Res, FileContentDebug>;
  @useResult
  $Res call(
      {DateTime createdAt,
      VersionSignificance? versionSignificance,
      int contentCount});
}

/// @nodoc
class _$FileContentDebugCopyWithImpl<$Res, $Val extends FileContentDebug>
    implements $FileContentDebugCopyWith<$Res> {
  _$FileContentDebugCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? versionSignificance = freezed,
    Object? contentCount = null,
  }) {
    return _then(_value.copyWith(
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      versionSignificance: freezed == versionSignificance
          ? _value.versionSignificance
          : versionSignificance // ignore: cast_nullable_to_non_nullable
              as VersionSignificance?,
      contentCount: null == contentCount
          ? _value.contentCount
          : contentCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FileContentDebugImplCopyWith<$Res>
    implements $FileContentDebugCopyWith<$Res> {
  factory _$$FileContentDebugImplCopyWith(_$FileContentDebugImpl value,
          $Res Function(_$FileContentDebugImpl) then) =
      __$$FileContentDebugImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime createdAt,
      VersionSignificance? versionSignificance,
      int contentCount});
}

/// @nodoc
class __$$FileContentDebugImplCopyWithImpl<$Res>
    extends _$FileContentDebugCopyWithImpl<$Res, _$FileContentDebugImpl>
    implements _$$FileContentDebugImplCopyWith<$Res> {
  __$$FileContentDebugImplCopyWithImpl(_$FileContentDebugImpl _value,
      $Res Function(_$FileContentDebugImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? versionSignificance = freezed,
    Object? contentCount = null,
  }) {
    return _then(_$FileContentDebugImpl(
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      versionSignificance: freezed == versionSignificance
          ? _value.versionSignificance
          : versionSignificance // ignore: cast_nullable_to_non_nullable
              as VersionSignificance?,
      contentCount: null == contentCount
          ? _value.contentCount
          : contentCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$FileContentDebugImpl implements _FileContentDebug {
  const _$FileContentDebugImpl(
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FileContentDebugImpl &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.versionSignificance, versionSignificance) ||
                other.versionSignificance == versionSignificance) &&
            (identical(other.contentCount, contentCount) ||
                other.contentCount == contentCount));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, createdAt, versionSignificance, contentCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FileContentDebugImplCopyWith<_$FileContentDebugImpl> get copyWith =>
      __$$FileContentDebugImplCopyWithImpl<_$FileContentDebugImpl>(
          this, _$identity);
}

abstract class _FileContentDebug implements FileContentDebug {
  const factory _FileContentDebug(
      {required final DateTime createdAt,
      required final VersionSignificance? versionSignificance,
      required final int contentCount}) = _$FileContentDebugImpl;

  @override
  DateTime get createdAt;
  @override
  VersionSignificance? get versionSignificance;
  @override
  int get contentCount;
  @override
  @JsonKey(ignore: true)
  _$$FileContentDebugImplCopyWith<_$FileContentDebugImpl> get copyWith =>
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
      _$CleanupStatsLogCopyWithImpl<$Res, CleanupStatsLog>;
  @useResult
  $Res call({int timeMs, int cleanupCount, List<CleanupStats> cleanupStats});
}

/// @nodoc
class _$CleanupStatsLogCopyWithImpl<$Res, $Val extends CleanupStatsLog>
    implements $CleanupStatsLogCopyWith<$Res> {
  _$CleanupStatsLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeMs = null,
    Object? cleanupCount = null,
    Object? cleanupStats = null,
  }) {
    return _then(_value.copyWith(
      timeMs: null == timeMs
          ? _value.timeMs
          : timeMs // ignore: cast_nullable_to_non_nullable
              as int,
      cleanupCount: null == cleanupCount
          ? _value.cleanupCount
          : cleanupCount // ignore: cast_nullable_to_non_nullable
              as int,
      cleanupStats: null == cleanupStats
          ? _value.cleanupStats
          : cleanupStats // ignore: cast_nullable_to_non_nullable
              as List<CleanupStats>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CleanupStatsLogImplCopyWith<$Res>
    implements $CleanupStatsLogCopyWith<$Res> {
  factory _$$CleanupStatsLogImplCopyWith(_$CleanupStatsLogImpl value,
          $Res Function(_$CleanupStatsLogImpl) then) =
      __$$CleanupStatsLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int timeMs, int cleanupCount, List<CleanupStats> cleanupStats});
}

/// @nodoc
class __$$CleanupStatsLogImplCopyWithImpl<$Res>
    extends _$CleanupStatsLogCopyWithImpl<$Res, _$CleanupStatsLogImpl>
    implements _$$CleanupStatsLogImplCopyWith<$Res> {
  __$$CleanupStatsLogImplCopyWithImpl(
      _$CleanupStatsLogImpl _value, $Res Function(_$CleanupStatsLogImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeMs = null,
    Object? cleanupCount = null,
    Object? cleanupStats = null,
  }) {
    return _then(_$CleanupStatsLogImpl(
      timeMs: null == timeMs
          ? _value.timeMs
          : timeMs // ignore: cast_nullable_to_non_nullable
              as int,
      cleanupCount: null == cleanupCount
          ? _value.cleanupCount
          : cleanupCount // ignore: cast_nullable_to_non_nullable
              as int,
      cleanupStats: null == cleanupStats
          ? _value._cleanupStats
          : cleanupStats // ignore: cast_nullable_to_non_nullable
              as List<CleanupStats>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CleanupStatsLogImpl extends _CleanupStatsLog {
  const _$CleanupStatsLogImpl(
      {required this.timeMs,
      required this.cleanupCount,
      required final List<CleanupStats> cleanupStats})
      : _cleanupStats = cleanupStats,
        super._();

  factory _$CleanupStatsLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$CleanupStatsLogImplFromJson(json);

  @override
  final int timeMs;
  @override
  final int cleanupCount;
  final List<CleanupStats> _cleanupStats;
  @override
  List<CleanupStats> get cleanupStats {
    if (_cleanupStats is EqualUnmodifiableListView) return _cleanupStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cleanupStats);
  }

  @override
  String toString() {
    return 'CleanupStatsLog(timeMs: $timeMs, cleanupCount: $cleanupCount, cleanupStats: $cleanupStats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CleanupStatsLogImpl &&
            (identical(other.timeMs, timeMs) || other.timeMs == timeMs) &&
            (identical(other.cleanupCount, cleanupCount) ||
                other.cleanupCount == cleanupCount) &&
            const DeepCollectionEquality()
                .equals(other._cleanupStats, _cleanupStats));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, timeMs, cleanupCount,
      const DeepCollectionEquality().hash(_cleanupStats));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CleanupStatsLogImplCopyWith<_$CleanupStatsLogImpl> get copyWith =>
      __$$CleanupStatsLogImplCopyWithImpl<_$CleanupStatsLogImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CleanupStatsLogImplToJson(
      this,
    );
  }
}

abstract class _CleanupStatsLog extends CleanupStatsLog {
  const factory _CleanupStatsLog(
      {required final int timeMs,
      required final int cleanupCount,
      required final List<CleanupStats> cleanupStats}) = _$CleanupStatsLogImpl;
  const _CleanupStatsLog._() : super._();

  factory _CleanupStatsLog.fromJson(Map<String, dynamic> json) =
      _$CleanupStatsLogImpl.fromJson;

  @override
  int get timeMs;
  @override
  int get cleanupCount;
  @override
  List<CleanupStats> get cleanupStats;
  @override
  @JsonKey(ignore: true)
  _$$CleanupStatsLogImplCopyWith<_$CleanupStatsLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
