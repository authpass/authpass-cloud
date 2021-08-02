import 'dart:convert';
import 'dart:typed_data';

import 'package:authpass_cloud_backend/src/dao/tables/user_tables.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:openapi_base/openapi_base.dart';
import 'package:postgres_utils/postgres_utils.dart';

final _logger = Logger('filecloud_tables');

class FileCloudTable extends TableBase with TableConstants {
  FileCloudTable({required this.cryptoService});
  static const TABLE_FILE = 'filecloud_file';
  static const TABLE_FILE_CONTENT = 'filecloud_file_content';
  static const TABLE_FILE_TOKEN = 'filecloud_token';

  static const columnUserId = UserTable.COLUMN_USER_ID;
  static const _columnName = 'name';
  static const _columnLastContentId = 'last_content_id';
  static const _lastContentIdFkConstraint = '${_columnLastContentId}_fkey';
  static const _columnFileId = 'file_id';
  static const _columnBytes = 'bytes';
  static const _columnLength = 'length';
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
      REFERENCES $TABLE_FILE_CONTENT ($columnId);
    
    CREATE TABLE $TABLE_FILE_TOKEN (
      $_columnToken varchar not null primary key,
      $specColumnCreatedAt,
      $_columnFileId uuid not null
        REFERENCES $TABLE_FILE ($columnId)
    );
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

    await db.executeInsert(TABLE_FILE, {
      columnId: fileId,
      columnUserId: userEntity.id,
      _columnUpdatedAt: clock.now().toUtc(),
      _columnName: name,
      _columnLastContentId: contentId,
    });
    await db.executeInsert(TABLE_FILE_CONTENT, {
      columnId: contentId,
      _columnFileId: fileId,
      columnUserId: userEntity.id,
      _columnBytes:
          CustomBind("decode(@$_columnBytes, 'base64')", base64.encode(bytes)),
      _columnLength: bytes.length,
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
    SELECT f.$columnId, f.$_columnLastContentId 
    FROM $TABLE_FILE_TOKEN ft 
    INNER JOIN $TABLE_FILE f ON ft.$_columnFileId = f.$columnId
    WHERE ft.$_columnToken = @token
    ''', values: {'token': fileToken}).singleOrNull((row) async {
      return _FileDetails(
          fileId: row[0] as String, lastVersionToken: row[1] as String);
    });
    if (details == null) {
      throw NotFoundException('Unable to find file.');
    }
    if (details.lastVersionToken != lastVersionToken) {
      throw ConflictException('Invalid content id');
    }

    final contentId = cryptoService.createSecureUuid();
    await db.executeInsert(TABLE_FILE_CONTENT, {
      columnId: contentId,
      _columnFileId: details.fileId,
      columnUserId: userEntity.id,
      _columnBytes:
          CustomBind("decode(@$_columnBytes, 'base64')", base64.encode(bytes)),
      _columnLength: bytes.length,
    });
    final rows = await db.executeUpdate(TABLE_FILE, set: {
      _columnLastContentId: contentId
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
}

class FileContent {
  FileContent({required this.versionToken, required this.body});
  final String versionToken;
  final Uint8List body;
}

class _FileDetails {
  _FileDetails({required this.fileId, required this.lastVersionToken});
  final String fileId;
  final String lastVersionToken;
}

class FileUpdated {
  FileUpdated({required this.versionToken, required this.fileToken});

  final String versionToken;
  final String fileToken;
}
