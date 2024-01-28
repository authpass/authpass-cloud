// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filecloud_tables.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CleanupStatsImpl _$$CleanupStatsImplFromJson(Map<String, dynamic> json) =>
    _$CleanupStatsImpl(
      timeMs: json['timeMs'] as int,
      count: json['count'] as int,
      versionSignificance: $enumDecode(
          _$VersionSignificanceEnumMap, json['versionSignificance']),
    );

Map<String, dynamic> _$$CleanupStatsImplToJson(_$CleanupStatsImpl instance) =>
    <String, dynamic>{
      'timeMs': instance.timeMs,
      'count': instance.count,
      'versionSignificance':
          _$VersionSignificanceEnumMap[instance.versionSignificance]!,
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

_$CleanupStatsLogImpl _$$CleanupStatsLogImplFromJson(
        Map<String, dynamic> json) =>
    _$CleanupStatsLogImpl(
      timeMs: json['timeMs'] as int,
      cleanupCount: json['cleanupCount'] as int,
      cleanupStats: (json['cleanupStats'] as List<dynamic>)
          .map((e) => CleanupStats.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CleanupStatsLogImplToJson(
        _$CleanupStatsLogImpl instance) =>
    <String, dynamic>{
      'timeMs': instance.timeMs,
      'cleanupCount': instance.cleanupCount,
      'cleanupStats': instance.cleanupStats,
    };
