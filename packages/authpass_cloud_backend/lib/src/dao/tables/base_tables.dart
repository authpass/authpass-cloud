abstract class TableBase {
  List<String> get tables;
}

abstract class TableConstants {
  final columnId = 'id';

  final typeTimestamp = 'TIMESTAMP WITHOUT TIME ZONE';

  final columnCreatedAt = 'created_at';

  String get specColumnCreatedAt => '$columnCreatedAt $typeTimestamp NOT NULL '
      'DEFAULT CURRENT_TIMESTAMP';
}
