class EnumUtil<T> {
  EnumUtil(List<T> enumValues)
      : _toStringMapping = {
          for (var v in enumValues) v: v.toString().split('.').last // NON-NLS
        },
        _toEnumMapping = {
          for (var v in enumValues) v.toString().split('.').last: v // NON-NLS
        };

  final Map<T, String> _toStringMapping;
  final Map<String, T> _toEnumMapping;

  String enumToString(T enumValue) =>
      _toStringMapping[enumValue] ??
      (() => throw StateError('Invalid enum value $enumValue'))();

  T stringToEnum(String stringValue) =>
      _toEnumMapping[stringValue] ??
      (() => throw StateError('Invalid string value $stringValue for $this'))();
}
