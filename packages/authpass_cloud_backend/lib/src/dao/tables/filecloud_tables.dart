import 'dart:convert';
import 'dart:typed_data';

import 'package:authpass_cloud_backend/src/dao/tables/filecloud_tables_enum.dart';
import 'package:authpass_cloud_backend/src/dao/tables/user_tables.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:authpass_cloud_backend/src/util/extension_methods.dart';
import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:openapi_base/openapi_base.dart';
import 'package:postgres/postgres.dart';
import 'package:postgres_utils/postgres_utils.dart';

part 'filecloud_tables.freezed.dart';
part 'filecloud_tables.g.dart';

final _logger = Logger('filecloud_tables');

class FileCloudTable extends TableBase with TableConstants {
  FileCloudTable({required this.cryptoService});
  static const TABLE_FILE = 'filecloud_file';
  static const TABLE_FILE_CONTENT = 'filecloud_file_content';
  static const TABLE_FILE_TOKEN = 'filecloud_token';
  static const TABLE_LOG = 'filecloud_log';

  /// enum of [VersionSignificance].
  static const typeVersionSignificance = 'version_significance';

  static const columnUserId = UserTable.COLUMN_USER_ID;
  static const _columnName = 'name';
  static const _columnLastContentId = 'last_content_id';

  /// a running counter how many content updates have been performed.
  static const _columnLastContentCount = 'last_content_count';
  static const _lastContentIdFkConstraint = '${_columnLastContentId}_fkey';
  static const _columnFileId = 'file_id';
  static const _columnBytes = 'bytes';
  static const _columnLength = 'length';
  static const _columnSignificance = 'version_significance';

  /// the revision number of this content. see also [_columnLastContentCount]
  static const _columnContentCount = 'content_count';
  static const _columnDeletedAt = 'deleted_at';
  static const _columnTokenType = 'token_type';
  static const _columnLabel = 'label';

  /// the "main" token created for the owner of this file.
  static const _columnOwnerToken = 'owner_token';
  static const _columnOwnerTokenFkConstraint = '${_columnOwnerToken}_fkey';
  static const _columnLogBody = 'log_body';
  static const _columnUpdatedAt = 'updated_at';
  String get specColumnUpdatedAtAt =>
      '$_columnUpdatedAt $typeTimestampNotNull ';
  static const _columnToken = 'token';

  final CryptoService cryptoService;

  @override
  List<String> get tables => [
        TABLE_FILE,
        TABLE_FILE_CONTENT,
        TABLE_FILE_TOKEN,
      ];

  Future<void> createTables(DatabaseTransactionBase conn) async {
    await conn.execute('''
    CREATE TABLE $TABLE_FILE (
      $specColumnIdPrimaryKey,
      $specColumnCreatedAt,
      $specColumnUpdatedAtAt,
      $columnUserId uuid not null 
        REFERENCES ${UserTable.TABLE_USER} ($columnId),
      $_columnName VARCHAR not null,
      $_columnLastContentId uuid not null
    );
    
    CREATE TABLE $TABLE_FILE_CONTENT (
      $specColumnIdPrimaryKey,
      $specColumnCreatedAt,
      $_columnFileId uuid not null
        REFERENCES $TABLE_FILE ($columnId),
      $columnUserId uuid not null 
        REFERENCES ${UserTable.TABLE_USER} ($columnId),
      $_columnBytes bytea not null,
      $_columnLength int not null
    );
    
    ALTER TABLE $TABLE_FILE ADD CONSTRAINT $_lastContentIdFkConstraint
      FOREIGN KEY ($_columnLastContentId) 
      REFERENCES $TABLE_FILE_CONTENT ($columnId)
      DEFERRABLE INITIALLY DEFERRED;
    
    CREATE TABLE $TABLE_FILE_TOKEN (
      $_columnToken varchar not null primary key,
      $specColumnCreatedAt,
      $_columnFileId uuid not null
        REFERENCES $TABLE_FILE ($columnId)
    );
''');
  }

  Future<void> migrate10(DatabaseTransactionBase db) async {
    await db.execute('''
    ALTER TABLE $TABLE_FILE ADD $_columnOwnerToken VARCHAR;
    UPDATE $TABLE_FILE f SET $_columnOwnerToken = (SELECT ft.$_columnToken FROM $TABLE_FILE_TOKEN ft WHERE ft.$_columnFileId = f.$columnId);
    ALTER TABLE $TABLE_FILE ALTER $_columnOwnerToken SET NOT NULL;
    ALTER TABLE $TABLE_FILE ADD CONSTRAINT $_columnOwnerTokenFkConstraint
      FOREIGN KEY ($_columnOwnerToken) 
      REFERENCES $TABLE_FILE_TOKEN ($_columnToken)
      DEFERRABLE INITIALLY DEFERRED;
    ''');
  }

  Future<void> migrate11(DatabaseTransactionBase db) async {
    await db.execute('''
    CREATE TYPE $typeVersionSignificance AS ENUM (${v11Values.map((e) => "'${e.name}'").join(',')});
    ALTER TABLE $TABLE_FILE_CONTENT ADD COLUMN $_columnSignificance $typeVersionSignificance NULL;
    ''');
  }

  Future<void> migrate12(DatabaseTransactionBase db) async {
    await db.execute('''
    ALTER TYPE $typeVersionSignificance ADD VALUE '${VersionSignificance.firstVersion.name}';
    ''');
  }

  Future<void> migrate13(DatabaseTransactionBase db) async {
    await db.execute('''
    ALTER TABLE $TABLE_FILE ADD COLUMN $_columnDeletedAt $typeTimestamp NULL;
    ALTER TABLE $TABLE_FILE_TOKEN ADD COLUMN $_columnTokenType VARCHAR NOT NULL default '${FileTokenType.creator.name}';
    ALTER TABLE $TABLE_FILE_TOKEN ADD COLUMN $_columnLabel VARCHAR NOT NULL default '';
    ''');
  }

  Future<void> migrate15(DatabaseTransactionBase db) async {
    await db.execute('''
    ALTER TABLE $TABLE_FILE ADD COLUMN $_columnLastContentCount INT NULL;
    UPDATE $TABLE_FILE f SET $_columnLastContentCount = (
      SELECT COUNT(fc.$columnId) FROM $TABLE_FILE_CONTENT fc WHERE fc.$_columnFileId = f.$columnId 
    );
    ALTER TABLE $TABLE_FILE ALTER COLUMN $_columnLastContentCount SET NOT NULL;
    ALTER TABLE $TABLE_FILE_CONTENT ADD COLUMN $_columnContentCount INT NULL;
    UPDATE $TABLE_FILE_CONTENT fc SET $_columnContentCount = (
      SELECT COUNT(fc2.$columnId) FROM $TABLE_FILE_CONTENT fc2
      WHERE fc2.$_columnFileId = fc.$_columnFileId
        AND fc2.$columnCreatedAt <= fc.$columnCreatedAt
    );
    ALTER TABLE $TABLE_FILE_CONTENT ALTER COLUMN $_columnContentCount SET NOT NULL;
    
    CREATE TABLE $TABLE_LOG (
      $specColumnIdPrimaryKey,
      $specColumnCreatedAt,
      $_columnLogBody JSONB NOT NULL
    );
    CREATE INDEX ON $TABLE_LOG ($columnCreatedAt);
    ''');
  }

  Future<FileUpdated> insertFile(
    DatabaseTransactionBase db, {
    required UserEntity userEntity,
    required String name,
    required Uint8List bytes,
  }) async {
    final fileId = cryptoService.createSecureUuid();
    final contentId = cryptoService.createSecureUuid();
    final fileToken =
        cryptoService.createSecureToken(type: TokenType.fileToken);

    await db.execute('SET CONSTRAINTS $_lastContentIdFkConstraint DEFERRED');
    await db.execute('SET CONSTRAINTS $_columnOwnerTokenFkConstraint DEFERRED');

    final now = clock.now().toUtc();

    await db.executeInsert(TABLE_FILE, {
      columnId: fileId,
      columnUserId: userEntity.id,
      columnCreatedAt: now,
      _columnUpdatedAt: now,
      _columnName: name,
      _columnLastContentId: contentId,
      _columnOwnerToken: fileToken,
      _columnLastContentCount: 1,
    });
    await db.executeInsert(TABLE_FILE_CONTENT, {
      columnId: contentId,
      _columnFileId: fileId,
      columnCreatedAt: now,
      columnUserId: userEntity.id,
      _columnContentCount: 1,
      _columnBytes:
          CustomBind("decode(@$_columnBytes, 'base64')", base64.encode(bytes)),
      _columnLength: bytes.length,
      _columnSignificance: VersionSignificance.firstVersion.name,
    });
    await db.executeInsert(TABLE_FILE_TOKEN, {
      _columnToken: fileToken,
      _columnFileId: fileId,
    });
    return FileUpdated(versionToken: contentId, fileToken: fileToken);
  }

  Future<bool> deleteFile(
    DatabaseTransactionBase db, {
    required String fileId,
  }) async {
    final now = clock.now().toUtc();
    final count = await db.executeUpdate(TABLE_FILE, set: {
      _columnDeletedAt: now
    }, where: {
      columnId: fileId,
      _columnDeletedAt: whereIsNotNull,
    });
    return count == 1;
  }

  Future<String> createFileToken(
    DatabaseTransactionBase db, {
    required String fileId,
    required String label,
    required FileTokenType fileTokenType,
  }) async {
    final newFileToken =
        cryptoService.createSecureToken(type: TokenType.fileToken);

    await db.executeInsert(TABLE_FILE_TOKEN, {
      _columnToken: newFileToken,
      _columnFileId: fileId,
      _columnLabel: label,
      _columnTokenType: fileTokenType.name,
    });

    return newFileToken;
  }

  Future<FileUpdated> updateFileContent(
    DatabaseTransactionBase db, {
    required UserEntity userEntity,
    required String fileToken,
    required String lastVersionToken,
    required Uint8List bytes,
  }) async {
    final details = await db.query('''
    SELECT f.$columnId, f.$_columnLastContentId, f.$_columnUpdatedAt, 
    f.$_columnLastContentCount
    FROM $TABLE_FILE_TOKEN ft 
    INNER JOIN $TABLE_FILE f ON ft.$_columnFileId = f.$columnId
    WHERE ft.$_columnToken = @token
    ''', values: {'token': fileToken}).singleOrNull((row) async {
      return _FileDetails(
        fileId: row[0] as String,
        lastVersionToken: row[1] as String,
        lastVersionDate: row[2] as DateTime,
        lastVersionCount: row[3] as int,
      );
    });
    if (details == null) {
      throw NotFoundException('Unable to find file.');
    }
    if (details.lastVersionToken != lastVersionToken) {
      throw ConflictException('Invalid version token');
    }

    final contentId = cryptoService.createSecureUuid();
    final contentCount = details.lastVersionCount + 1;
    final now = clock.now().toUtc();
    await db.executeInsert(TABLE_FILE_CONTENT, {
      columnId: contentId,
      _columnFileId: details.fileId,
      columnUserId: userEntity.id,
      columnCreatedAt: now,
      _columnContentCount: contentCount,
      _columnSignificance:
          VersionSignificanceExt.forDates(details.lastVersionDate, now)?.name,
      _columnBytes:
          CustomBind("decode(@$_columnBytes, 'base64')", base64.encode(bytes)),
      _columnLength: bytes.length,
    });
    final rows = await db.executeUpdate(TABLE_FILE, set: {
      _columnLastContentId: contentId,
      // columnCreatedAt: now,
      _columnUpdatedAt: now,
      _columnLastContentCount: contentCount,
    }, where: {
      columnId: details.fileId,
      _columnLastContentId: details.lastVersionToken,
    });
    if (rows != 1) {
      _logger.warning('Race condition for file ${details.fileId} - '
          'could not update ${details.lastVersionToken}');
      throw ConflictException('Invalid content id. detected conflict.');
    }
    return FileUpdated(
      versionToken: contentId,
      fileToken: fileToken,
    );
  }

  Future<FileContent?> selectFileContent(DatabaseTransactionBase db,
      {required String fileToken}) async {
    return await db.query('''
    SELECT f.$columnId, fc.$columnId, fc.$_columnBytes, ft.$_columnTokenType,
      f.$columnUserId
    FROM $TABLE_FILE_TOKEN ft 
    INNER JOIN $TABLE_FILE f ON ft.$_columnFileId = f.$columnId
    INNER JOIN $TABLE_FILE_CONTENT fc ON fc.$columnId = f.$_columnLastContentId
    WHERE ft.$_columnToken = @token AND f.$_columnDeletedAt IS NULL
    ''', values: {'token': fileToken}).singleOrNull((row) async {
      final tokenType = fileTokenTypeUtil.stringToEnum(row[3] as String);
      return FileContent(
        versionToken: row[1] as String,
        body: row[2] as Uint8List,
        tokenType: tokenType,
        owner: UserEntity(id: row[4] as String),
      );
    });
  }

  Future<FileInfoDto?> getFile(
    DatabaseTransactionBase db,
    UserEntity? user, {
    required String fileToken,
  }) async {
    return (await _listFiles(db, user, fileToken: fileToken)).firstOrNull;
  }

  Future<List<FileInfo>> listAllFiles(
    DatabaseTransactionBase db,
    UserEntity user,
  ) async =>
      (await _listFiles(db, user)).map((e) => e.fileInfo).toList();

  Future<List<FileInfoDto>> _listFiles(
    DatabaseTransactionBase db,
    UserEntity? user, {
    String? fileToken,
  }) async {
    if (user == null && fileToken == null) {
      throw ArgumentError('Either user or fileToken must not be null.');
    }
    final values = <String, Object?>{};
    final String fileTokenWhere;
    if (fileToken != null) {
      fileTokenWhere = 'ft.$_columnToken = @fileToken';
      values['fileToken'] = fileToken;
    } else {
      fileTokenWhere = 'ft.$_columnToken = f.$_columnOwnerToken';
    }
    final String whereUser;
    if (user != null) {
      values['userId'] = user.id;
      whereUser = 'fc.$columnUserId = @userId';
    } else {
      whereUser = '1=1';
    }
    final rows = await db.query('''
        SELECT 
          $_fileInfoSelect
           
        FROM $TABLE_FILE f
          INNER JOIN $TABLE_FILE_CONTENT fc 
            ON fc.$columnId = f.$_columnLastContentId
          INNER JOIN $TABLE_FILE_TOKEN ft ON ft.$_columnFileId = f.$columnId 
          
        WHERE $whereUser AND f.$_columnDeletedAt IS NULL AND $fileTokenWhere
        ORDER BY f.$_columnUpdatedAt DESC
        ''', values: values);
    return rows.map(_fileInfoParse).toList();
  }

  late final _fileInfoSelect = '''
            ft.$_columnToken, f.$_columnLastContentId,
          f.$_columnName, f.$columnCreatedAt, f.$_columnUpdatedAt, 
          fc.$_columnLength,
          f.$columnUserId, f.$columnId, ft.$_columnTokenType
  ''';

  FileInfoDto _fileInfoParse(PostgreSQLResultRow row) {
    return FileInfoDto(
      fileId: row[7] as String,
      owner: UserEntity(id: row[6] as String),
      fileInfo: FileInfo(
        fileToken: row[0] as String,
        versionToken: row[1] as String,
        name: row[2] as String,
        createdAt: row[3] as DateTime,
        updatedAt: row[4] as DateTime,
        size: row[5] as int,
        readOnly: fileTokenTypeUtil.stringToEnum(row[8] as String).isReadOnly,
      ),
    );
  }

  Future<List<FileTokenDto>> listFileTokens(
    DatabaseTransactionBase db, {
    required String fileId,
  }) async {
    final rows = await db.query('''
    SELECT 
      ft.$_columnToken,
      ft.$_columnTokenType,
      ft.$columnCreatedAt,
      ft.$_columnLabel
    FROM $TABLE_FILE_TOKEN ft 
      INNER JOIN $TABLE_FILE f ON f.$columnId = ft.$_columnFileId
    WHERE
      f.$_columnDeletedAt IS NULL AND f.$columnId = @fileId
    ''', values: {'fileId': fileId});
    return rows.map((row) {
      final fileTokenType = fileTokenTypeUtil.stringToEnum(row[1] as String);
      return FileTokenDto(
        fileTokenType: fileTokenType,
        fileTokenInfo: FileTokenInfo(
          fileToken: row[0] as String,
          createdAt: row[2] as DateTime,
          label: row[3] as String,
          readOnly: fileTokenType.isReadOnly,
        ),
      );
    }).toList();
  }

  Future<SystemStatusFileCloud> countStats(DatabaseTransactionBase db) async {
    final f = await db.query('SELECT COUNT(*) FROM $TABLE_FILE').single;
    final fc =
        await (db.query('SELECT COUNT(*) FROM $TABLE_FILE_CONTENT')).single;
    return SystemStatusFileCloud(
      fileCount: f[0] as int,
      fileContentCount: fc[0] as int,
    );
  }

  @visibleForTesting
  Future<List<FileContentDebug>> listFileContentDebug(
      DatabaseTransactionBase db) async {
    final query = await db.query('''
        SELECT fc.$columnCreatedAt, fc.$_columnSignificance,
          fc.$_columnContentCount
        FROM $TABLE_FILE_CONTENT fc
        ''');
    return query
        .map((e) => FileContentDebug(
              createdAt: e[0] as DateTime,
              versionSignificance:
                  (e[1] as String?)?.let(versionSignificance.stringToEnum),
              contentCount: e[2] as int,
            ))
        .toList(growable: false);
  }

  Future<List<CleanupStats>> cleanup(DatabaseTransactionBase db) async {
    final cleanups = {
      // cleanup firstOfHour when older than 24 hours
      VersionSignificance.firstOfHour: const Duration(hours: 24),
      VersionSignificance.firstOfDay: const Duration(days: 7),
      VersionSignificance.firstOfWeek: const Duration(days: 21),
      VersionSignificance.firstOfMonth: const Duration(days: 120),
      VersionSignificance.firstOfYear: const Duration(days: 900),
      VersionSignificance.firstVersion: const Duration(days: 1800),
    };
    final totalTime = Stopwatch()..start();
    final singleStopwatch = Stopwatch()..start();
    final ret = await (() async* {
      for (final cleanup in cleanups.entries) {
        singleStopwatch.reset();
        final count = await _cleanup(db, cleanup.key, cleanup.value);
        yield CleanupStats(
          timeMs: singleStopwatch.elapsedMilliseconds,
          count: count,
          versionSignificance: cleanup.key,
        );
      }
    })()
        .toList();
    final cleanupCount = ret.fold<int>(
        0, (previousValue, element) => previousValue + element.count);
    await _insertLogDebug(
      db,
      CleanupStatsLog(
        timeMs: totalTime.elapsedMilliseconds,
        cleanupCount: cleanupCount,
        cleanupStats: ret,
      ),
    );
    return ret;
  }

  Future<void> _insertLogDebug(
      DatabaseTransactionBase db, DebugLogBody logBody) async {
    await db.executeInsert(TABLE_LOG, {
      columnId: cryptoService.createSecureUuid(),
      columnCreatedAt: clock.now().toUtc(),
      _columnLogBody:
          CustomTypeBind(PostgreSQLDataType.jsonb, logBody.toJson()),
    });
  }

  Future<int> _cleanup(DatabaseTransactionBase db,
      VersionSignificance significance, Duration duration) async {
    return await db.execute('''
    DELETE FROM $TABLE_FILE_CONTENT  fc
    WHERE ( 
      fc.$_columnSignificance IS NULL 
      OR fc.$_columnSignificance <= @significance
    ) AND fc.$columnCreatedAt < @until
    AND NOT EXISTS (SELECT FROM $TABLE_FILE f WHERE f.$_columnLastContentId = fc.$columnId)
    ''', values: {
      'significance': significance.name,
      'until': clock.now().toUtc().subtract(duration),
    });
  }
}

@freezed
class CleanupStats with _$CleanupStats {
  const factory CleanupStats({
    required int timeMs,
    required int count,
    required VersionSignificance versionSignificance,
  }) = _CleanupStats;

  factory CleanupStats.fromJson(Map<String, dynamic> json) =>
      _$CleanupStatsFromJson(json);
}

class FileInfoDto {
  FileInfoDto({
    required this.fileId,
    required this.owner,
    required this.fileInfo,
  });

  final String fileId;
  final UserEntity owner;
  final FileInfo fileInfo;
}

class FileTokenDto {
  FileTokenDto({
    required this.fileTokenType,
    required this.fileTokenInfo,
  });
  final FileTokenType fileTokenType;
  final FileTokenInfo fileTokenInfo;
}

class FileContent {
  FileContent({
    required this.versionToken,
    required this.body,
    required this.tokenType,
    required this.owner,
  });

  final String versionToken;
  final Uint8List body;
  final FileTokenType tokenType;
  final UserEntity owner;
}

class _FileDetails {
  _FileDetails({
    required this.fileId,
    required this.lastVersionToken,
    required this.lastVersionDate,
    required this.lastVersionCount,
  });
  final String fileId;
  final String lastVersionToken;
  final DateTime lastVersionDate;
  final int lastVersionCount;
}

class FileUpdated {
  FileUpdated({required this.versionToken, required this.fileToken});

  final String versionToken;
  final String fileToken;
}

@visibleForTesting
@freezed
class FileContentDebug with _$FileContentDebug {
  const factory FileContentDebug({
    required DateTime createdAt,
    required VersionSignificance? versionSignificance,
    required int contentCount,
  }) = _FileContentDebug;
}

abstract class DebugLogBody {
  String get type;
  Map<String, dynamic> toJson();
}

@freezed
class CleanupStatsLog with _$CleanupStatsLog implements DebugLogBody {
  const factory CleanupStatsLog({
    required int timeMs,
    required int cleanupCount,
    required List<CleanupStats> cleanupStats,
  }) = _CleanupStatsLog;
  const CleanupStatsLog._();

  factory CleanupStatsLog.fromJson(Map<String, dynamic> json) =>
      _$CleanupStatsLogFromJson(json);

  @JsonKey()
  @override
  String get type => 'cleanupStats';
}
