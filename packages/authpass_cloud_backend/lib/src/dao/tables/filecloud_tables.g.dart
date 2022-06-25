// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filecloud_tables.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CleanupStats _$$_CleanupStatsFromJson(Map<String, dynamic> json) =>
    _$_CleanupStats(
      timeMs: json['timeMs'] as int,
      count: json['count'] as int,
      versionSignificance: $enumDecode(
          _$VersionSignificanceEnumMap, json['versionSignificance']),
    );

Map<String, dynamic> _$$_CleanupStatsToJson(_$_CleanupStats instance) =>
    <String, dynamic>{
      'timeMs': instance.timeMs,
      'count': instance.count,
      'versionSignificance':
          _$VersionSignificanceEnumMap[instance.versionSignificance],
    };

const _$VersionSignificanceEnumMap = {
  VersionSignificance.firstOfHour: 'firstOfHour',
  VersionSignificance.firstOfDay: 'firstOfDay',
  VersionSignificance.firstOfWeek: 'firstOfWeek',
  VersionSignificance.firstOfMonth: 'firstOfMonth',
  VersionSignificance.firstOfQuarter: 'firstOfQuarter',
  VersionSignificance.firstOfYear: 'firstOfYear',
  VersionSignificance.firstVersion: 'firstVersion',
};

_$_CleanupStatsLog _$$_CleanupStatsLogFromJson(Map<String, dynamic> json) =>
    _$_CleanupStatsLog(
      timeMs: json['timeMs'] as int,
      cleanupCount: json['cleanupCount'] as int,
      cleanupStats: (json['cleanupStats'] as List<dynamic>)
          .map((e) => CleanupStats.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_CleanupStatsLogToJson(_$_CleanupStatsLog instance) =>
    <String, dynamic>{
      'timeMs': instance.timeMs,
      'cleanupCount': instance.cleanupCount,
      'cleanupStats': instance.cleanupStats,
    };
