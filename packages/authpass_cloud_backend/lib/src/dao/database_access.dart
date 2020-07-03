import 'package:authpass_cloud_backend/src/dao/tables/base_tables.dart';
import 'package:authpass_cloud_backend/src/dao/tables/email_tables.dart';
import 'package:authpass_cloud_backend/src/dao/tables/migration_tables.dart';
import 'package:authpass_cloud_backend/src/dao/tables/user_tables.dart';
import 'package:authpass_cloud_backend/src/env/config.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:postgres/postgres.dart';

final _logger = Logger('database_access');

class DatabaseTransaction {
  DatabaseTransaction(this._conn, this.tables);

  final PostgreSQLExecutionContext _conn;
  final Tables tables;
  static final columnNamePattern = RegExp(r'^[a-z_]+$');

  void _assertColumnNames(Map<String, Object> values) {
    assert((() {
      for (final key in values.keys) {
        if (!columnNamePattern.hasMatch(key)) {
          throw ArgumentError.value(key, 'values', 'Invalid column name.');
        }
      }
      return true;
    })());
  }

  Future<int> executeInsert(String table, Map<String, Object> values) async {
    _assertColumnNames(values);
    final entries = values.entries.toList();
    final columnList = entries.map((e) => e.key).join(',');
    final bindList = entries.map((e) => '@${e.key}').join(',');
    return await execute('INSERT INTO $table ($columnList) VALUES ($bindList)',
        values: values, expectedResultCount: 1);
  }

  Future<int> executeUpdate(
    String table, {
    @required Map<String, Object> set,
    @required Map<String, Object> where,
  }) async {
    assert(set != null);
    assert(where != null);
    _assertColumnNames(set);
    _assertColumnNames(where);
    assert(!where.keys.any((key) => set.containsKey(key)));
    assert(!where.values.contains(null), 'where values must not be null.');
    final setStatement =
        set.entries.map((e) => '${e.key} = @${e.key}').join(',');
    final whereStatement = where.entries.map((e) => '${e.key} = @${e.key}');
    return await execute(
        'UPDATE $table SET $setStatement WHERE $whereStatement',
        values: {
          ...set,
          ...where,
        },
        expectedResultCount: 1);
  }

  bool _assertCorrectValues(Map<String, Object> values) {
    if (values == null) {
      return true;
    }
    for (final entry in values.entries) {
      final value = entry.value;
      if (value is DateTime) {
        if (!value.isUtc) {
          throw ArgumentError.value(
              entry, 'Value for ${entry.key} is a non-UTC DateTime.');
        }
      }
    }
    return true;
  }

  Future<int> execute(
    String fmtString, {
    Map<String, Object> values,
    int timeoutInSeconds,
    int expectedResultCount,
  }) async {
    try {
      assert(_assertCorrectValues(values));
      _logger.finest('Executing query: $fmtString with values: $values');
      final result = await _conn.execute(fmtString,
          substitutionValues: values, timeoutInSeconds: timeoutInSeconds);
      if (expectedResultCount != null && result != expectedResultCount) {
        throw StateError(
            'Expected result: $expectedResultCount but got $result. '
            'for query: $fmtString');
      }
      return result;
    } catch (e, stackTrace) {
      _logger.warning(
          'Error while running statement $fmtString', e, stackTrace);
      rethrow;
    }
  }

  Future<PostgreSQLResult> query(String fmtString,
      {Map<String, Object> values,
      bool allowReuse,
      int timeoutInSeconds}) async {
    assert(_assertCorrectValues(values));
    return _conn.query(fmtString,
        substitutionValues: values,
        allowReuse: allowReuse,
        timeoutInSeconds: timeoutInSeconds);
  }
}

class DatabaseAccess {
  DatabaseAccess({
    @required CryptoService cryptoService,
    @required this.config,
  })  : tables = Tables(cryptoService: cryptoService),
        assert(config != null),
        assert(cryptoService != null);

  final Tables tables;
  final DatabaseConfig config;

  PostgreSQLConnection _conn;

  Future<PostgreSQLConnection> _connection() async {
    if (_conn != null) {
      return _conn;
    }
    final conn = PostgreSQLConnection(
      config.host,
      config.port,
      config.databaseName,
      username: config.username,
      password: config.password,
    );
    await conn.open();
    return _conn = conn;
  }

  @visibleForTesting
  Future<void> forTestCreateDatabase(String name) async {
    await (await _connection()).execute('CREATE DATABASE $name');
  }

  @visibleForTesting
  Future<void> forTestDropDatabase(String databaseName) async {
    await (await _connection()).execute('DROP DATABASE $databaseName');
  }

  Future<void> dispose() async {
    await _conn.close();
    _conn = null;
  }

  Future<T> run<T>(Future<T> Function(DatabaseTransaction db) block) async =>
      _transaction((conn) async {
        return await block(DatabaseTransaction(conn, tables));
      });

  Future<T> _transaction<T>(
      Future<T> Function(PostgreSQLExecutionContext conn) queryBlock) async {
    final conn = await _connection();
    final dynamic result = await conn.transaction(queryBlock);
    if (result is T) {
      return result;
    }
    throw Exception(
        'Error running in transaction, $result (${result.runtimeType})'
        ' is not ${T.runtimeType}');
  }

  Future<void> prepareDatabase() async {
    _logger.finest('Initializing database.');
//    await clean();
    final lastMigration = await run((connection) async {
      try {
        await tables.migration.createTable(connection);
        return await tables.migration.queryLastVersion(connection);
      } catch (e, stackTrace) {
        _logger.severe('Error during migration', e, stackTrace);
        rethrow;
      }
    });
    _logger.fine('Last migration: $lastMigration');
    if (lastMigration > 0 && lastMigration < 3) {
      _logger.warning('Recreating database.');
      await clean();
      await run((conn) async {
        await tables.migration.createTable(conn);
      });
    }

    final migrationRun = clock.now().toUtc();
    await run((conn) async {
      final migrations = Migrations.migrations();
      for (final migration in migrations) {
        if (migration.id > lastMigration) {
          _logger.fine('Running migration ${migration.id} '
              '(${migration.versionCode})');
          await migration.up(conn);
          await tables.migration.insertMigrationRun(
              conn, migrationRun, migration.id, migration.versionCode);
        }
      }
    });

//    _database = config.database();
//    final client = _database.sqlClient;
//    _logger.finest('Running migration.');
//    await client.runInTransaction((t) async {
//      final result = await client.run(
//        SqlSourceBuilder()
//          ..write('CREATE TABLE IF NOT EXISTS ')
//          ..identifier(_TABLE_MIGRATE)
//          ..write(' (')
//          ..identifier(_COLUMN_ID)
//          ..write(' id PRIMARY KEY SERIAL, ')
//          ..identifier(_TABLE_MIGRATE_APPLIED_AT)
//          ..write(' timestamp without time zone')
//          ..identifier(_TABLE_MIGRATE_VERSION)
//          ..write('INT NOT NULL)'),
//      );
//    });
//    final table = _database.sqlClient.table('authpass_migration');
//    _database.collection(_TABLE_MIGRATE).document('1');
  }

  Future<void> clean() async {
    _logger.warning('Clearing database.');
    final tableNames = tables.allTables.expand((e) => e.tables);
    final typeNames = tables.allTables.expand((e) => e.types);
    await run((connection) async {
      final tables = tableNames.join(', ');
      final result =
          await connection.execute('DROP TABLE IF EXISTS $tables CASCADE');
      _logger.fine('Dropped $tables ($result)');
      if (typeNames.isNotEmpty) {
        await connection.execute('DROP TYPE IF EXISTS ${typeNames.join(', ')}');
      }

//      for (final tableName in tableNames) {
//        final result =
//            await connection.execute('DROP TABLE IF EXISTS $tableName');
//        _logger.fine('Dropped $tableName ($result)');
//      }
    });
  }
}

//extension on SqlClientBase {
//  Future<SqlStatementResult> run(SqlSourceBuilder builder) async {
//    final stmt = builder.build();
//    _logger.finest('Running SQL ${stmt.value}');
//    return execute(stmt.value, stmt.arguments);
//  }
//}

class Tables {
  Tables({
    @required CryptoService cryptoService,
  })  : user = UserTable(cryptoService: cryptoService),
        email = EmailTable(cryptoService: cryptoService);
  final migration = MigrationTable();
  final UserTable user;
  final EmailTable email;

  List<TableBase> get allTables => [
        migration,
        user,
      ];
}

class Migrations {
  Migrations({
    @required this.id,
    this.versionCode = 'a',
    @required this.up,
  })  : assert(id != null),
        assert(up != null);

  final int id;
  final String versionCode;
  final Future<void> Function(DatabaseTransaction conn) up;

  static List<Migrations> migrations() {
    return [
      Migrations(
          id: 1,
          up: (conn) async {
            await conn.tables.user.createTables(conn);
          }),
      Migrations(
          id: 2,
          up: (db) async {
            await db.tables.email.createTables(db);
          }),
      // dummy migration to indicate a required clean database ;)
      Migrations(id: 3, up: (db) async {}),
      Migrations(
          id: 4,
          up: (db) async {
            await db.tables.email.migrate4(db);
          })
    ];
  }
}
