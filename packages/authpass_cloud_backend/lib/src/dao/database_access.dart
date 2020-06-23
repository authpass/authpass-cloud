import 'package:authpass_cloud_backend/src/dao/tables/base_tables.dart';
import 'package:authpass_cloud_backend/src/dao/tables/migration_tables.dart';
import 'package:authpass_cloud_backend/src/dao/tables/user_tables.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:postgres/postgres.dart';

final _logger = Logger('database_access');

class DatabaseTransaction {
  DatabaseTransaction(this._conn, this.tables);

  final PostgreSQLExecutionContext _conn;
  final Tables tables;

  Future<int> execute(
    String fmtString, {
    Map<String, Object> values,
    int timeoutInSeconds,
  }) async {
    try {
      return await _conn.execute(fmtString,
          substitutionValues: values, timeoutInSeconds: timeoutInSeconds);
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
    return _conn.query(fmtString,
        substitutionValues: values,
        allowReuse: allowReuse,
        timeoutInSeconds: timeoutInSeconds);
  }
}

class DatabaseConfig {
  DatabaseConfig({
    this.host = 'localhost',
    this.port = 5432,
    this.databaseName = 'authpass',
    this.username = 'authpass',
    this.password = 'blubb',
  });
  final String host;
  final int port;
  final String databaseName;
  final String username;
  final String password;

  DatabaseConfig copyWith({String databaseName}) => DatabaseConfig(
        host: host,
        port: port,
        databaseName: databaseName ?? this.databaseName,
        username: username,
        password: password,
      );
}

class DatabaseAccess {
  DatabaseAccess({
    @required CryptoService cryptoService,
    @required this.config,
  }) : tables = Tables(cryptoService: cryptoService);

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
    await clean();
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
    await run((conn) async {
      final migrations = Migrations.migrations();
      for (final migration in migrations) {
        if (migration.id > lastMigration) {
          _logger.fine('Running migration ${migration.id}');
          await migration.up(conn);
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
      final result = await connection.execute('DROP TABLE IF EXISTS $tables');
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
  }) : user = UserTable(cryptoService: cryptoService);
  final migration = MigrationTable();
  final UserTable user;

  List<TableBase> get allTables => [
        migration,
        user,
      ];
}

class Migrations {
  Migrations({
    @required this.id,
    @required this.up,
  })  : assert(id != null),
        assert(up != null);

  final int id;
  final Future<void> Function(DatabaseTransaction conn) up;

  static List<Migrations> migrations() {
    return [
      Migrations(
          id: 1,
          up: (conn) async {
            await conn.tables.user.createTables(conn);
          }),
    ];
  }
}
