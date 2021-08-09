import 'dart:convert';
import 'dart:typed_data';

import 'package:authpass_cloud_backend/src/dao/tables/user_tables.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:authpass_cloud_backend/src/util/enum_util.dart';
import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:openapi_base/openapi_base.dart';
import 'package:postgres_utils/postgres_utils.dart';

final _logger = Logger('filecloud_tables');

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

final _versionSignificance = EnumUtil(VersionSignificance.values);

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

  String get name => _versionSignificance.enumToString(this);
}

class FileCloudTable extends TableBase with TableConstants {
  FileCloudTable({required this.cryptoService});
  static const TABLE_FILE = 'filecloud_file';
  static const TABLE_FILE_CONTENT = 'filecloud_file_content';
  static const TABLE_FILE_TOKEN = 'filecloud_token';

  /// enum of [VersionSignificance].
  static const typeVersionSignificance = 'version_significance';

  static const columnUserId = UserTable.COLUMN_USER_ID;
  static const _columnName = 'name';
  static const _columnLastContentId = 'last_content_id';
  static const _lastContentIdFkConstraint = '${_columnLastContentId}_fkey';
  static const _columnFileId = 'file_id';
  static const _columnBytes = 'bytes';
  static const _columnLength = 'length';
  static const _columnSignificance = 'version_significance';

  /// the "main" token created for the owner of this file.
  static const _columnOwnerToken = 'owner_token';
  static const _columnOwnerTokenFkConstraint = '${_columnOwnerToken}_fkey';
  // static const
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

    await db.executeInsert(TABLE_FILE, {
      columnId: fileId,
      columnUserId: userEntity.id,
      _columnUpdatedAt: clock.now().toUtc(),
      _columnName: name,
      _columnLastContentId: contentId,
      _columnOwnerToken: fileToken,
    });
    await db.executeInsert(TABLE_FILE_CONTENT, {
      columnId: contentId,
      _columnFileId: fileId,
      columnUserId: userEntity.id,
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

  Future<FileUpdated> updateFileContent(
    DatabaseTransactionBase db, {
    required UserEntity userEntity,
    required String fileToken,
    required String lastVersionToken,
    required Uint8List bytes,
  }) async {
    final details = await db.query('''
    SELECT f.$columnId, f.$_columnLastContentId, f.$_columnUpdatedAt
    FROM $TABLE_FILE_TOKEN ft 
    INNER JOIN $TABLE_FILE f ON ft.$_columnFileId = f.$columnId
    WHERE ft.$_columnToken = @token
    ''', values: {'token': fileToken}).singleOrNull((row) async {
      return _FileDetails(
        fileId: row[0] as String,
        lastVersionToken: row[1] as String,
        lastVersionDate: row[2] as DateTime,
      );
    });
    if (details == null) {
      throw NotFoundException('Unable to find file.');
    }
    if (details.lastVersionToken != lastVersionToken) {
      throw ConflictException('Invalid version token');
    }

    final contentId = cryptoService.createSecureUuid();
    final now = clock.now().toUtc();
    await db.executeInsert(TABLE_FILE_CONTENT, {
      columnId: contentId,
      _columnFileId: details.fileId,
      columnUserId: userEntity.id,
      columnCreatedAt: now,
      _columnSignificance:
          VersionSignificanceExt.forDates(details.lastVersionDate, now)?.name,
      _columnBytes:
          CustomBind("decode(@$_columnBytes, 'base64')", base64.encode(bytes)),
      _columnLength: bytes.length,
    });
    final rows = await db.executeUpdate(TABLE_FILE, set: {
      _columnLastContentId: contentId,
      columnCreatedAt: now,
      _columnUpdatedAt: now,
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
    SELECT f.$columnId, fc.$columnId, fc.$_columnBytes
    FROM $TABLE_FILE_TOKEN ft 
    INNER JOIN $TABLE_FILE f ON ft.$_columnFileId = f.$columnId
    INNER JOIN $TABLE_FILE_CONTENT fc ON fc.$columnId = f.$_columnLastContentId
    WHERE ft.$_columnToken = @token
    ''', values: {'token': fileToken}).singleOrNull((row) async {
      return FileContent(
        versionToken: row[1] as String,
        body: row[2] as Uint8List,
      );
    });
  }

  Future<List<FileInfo>> listAllFiles(
      DatabaseTransactionBase db, UserEntity user) async {
    final rows = await db.query('''
        SELECT 
          f.$_columnOwnerToken, f.$_columnLastContentId,
          f.$_columnName, f.$columnCreatedAt, f.$_columnUpdatedAt, 
          fc.$_columnLength
           
        FROM $TABLE_FILE f
          INNER JOIN $TABLE_FILE_CONTENT fc 
          ON fc.$columnId = f.$_columnLastContentId
        WHERE fc.$columnUserId = @userId
        ORDER BY f.$_columnUpdatedAt DESC
        ''', values: {'userId': user.id});
    return rows
        .map((row) => FileInfo(
              fileToken: row[0] as String,
              versionToken: row[1] as String,
              name: row[2] as String,
              createdAt: row[3] as DateTime,
              updatedAt: row[4] as DateTime,
              size: row[5] as int,
            ))
        .toList();
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
}

class FileContent {
  FileContent({required this.versionToken, required this.body});
  final String versionToken;
  final Uint8List body;
}

class _FileDetails {
  _FileDetails({
    required this.fileId,
    required this.lastVersionToken,
    required this.lastVersionDate,
  });
  final String fileId;
  final String lastVersionToken;
  final DateTime lastVersionDate;
}

class FileUpdated {
  FileUpdated({required this.versionToken, required this.fileToken});

  final String versionToken;
  final String fileToken;
}
