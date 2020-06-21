abstract class TableBase {
  List<String> get tables;
}

abstract class TableConstants {
  final columnId = 'id';

  final typeTimestamp = 'TIMESTAMP WITHOUT TIME ZONE';

  final columnCreatedAt = 'created_at';

  String get typeTimestampNotNull => '$typeTimestamp NOT NULL';

  String get specColumnCreatedAt => '$columnCreatedAt $typeTimestampNotNull '
      'DEFAULT CURRENT_TIMESTAMP';
}
