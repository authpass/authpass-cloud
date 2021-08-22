import 'package:authpass_cloud_backend/src/util/enum_util.dart';

enum VersionSignificance {
  firstOfHour,
  firstOfDay,
  firstOfWeek,
  firstOfMonth,
  firstOfQuarter,
  firstOfYear,
  firstVersion,
}

final v11Values = <VersionSignificance>[
  VersionSignificance.firstOfHour,
  VersionSignificance.firstOfDay,
  VersionSignificance.firstOfWeek,
  VersionSignificance.firstOfMonth,
  VersionSignificance.firstOfQuarter,
  VersionSignificance.firstOfYear,
];

final versionSignificance = EnumUtil(VersionSignificance.values);

extension VersionSignificanceExt on VersionSignificance {
  static VersionSignificance? forDates(DateTime before, DateTime after) {
    assert(before == after || before.isBefore(after), '$before vs $after');
    if (after.year != before.year) {
      return VersionSignificance.firstOfYear;
    }
    if (after.month != before.month) {
      if (after.month % 4 == 1) {
        return VersionSignificance.firstOfQuarter;
      }
      return VersionSignificance.firstOfMonth;
    }
    if (after.day != before.day) {
      if (after.weekday == DateTime.monday) {
        return VersionSignificance.firstOfWeek;
      }
      return VersionSignificance.firstOfDay;
    }
    if (after.hour != before.hour) {
      return VersionSignificance.firstOfHour;
    }
    return null;
  }

  String get name => versionSignificance.enumToString(this);
}

enum FileTokenType {
  /// Token used by the original creator.
  creator,

  /// Shared to a specific user.
  user,

  /// Shared to a specific user, readonly.
  userReadonly,

  /// General shared, even for anonymous users.
  share,

  /// General shared, even for anonymous user, without write permission.
  shareReadonly,
}

final _fileTokenTypeReadWrite = [
  FileTokenType.creator,
  FileTokenType.user,
  FileTokenType.share
];

final fileTokenTypeUtil = EnumUtil(FileTokenType.values);

extension FileTokenTypeExt on FileTokenType {
  String get name => fileTokenTypeUtil.enumToString(this);

  bool get isReadOnly => !_fileTokenTypeReadWrite.contains(this);
}
