import 'dart:typed_data';

import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/dao/tables/filecloud_tables.dart';
import 'package:authpass_cloud_backend/src/dao/tables/filecloud_tables_enum.dart';
import 'package:authpass_cloud_backend/src/dao/tables/user_tables.dart';
import 'package:authpass_cloud_backend/src/env/env.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:logging/logging.dart';
import 'package:openapi_base/openapi_base.dart';

final _logger = Logger('filecloud_repository');

class FileCloudRepository {
  FileCloudRepository({
    required this.db,
    required this.cryptoService,
    required this.env,
  });
  final DatabaseTransaction db;
  final CryptoService cryptoService;
  final Env env;

  Future<FileUpdated> createFile(
      UserEntity user, String fileName, Uint8List bytes) async {
    return db.tables.fileCloud
        .insertFile(db, userEntity: user, name: fileName, bytes: bytes);
  }

  Future<FileUpdated> updateFile(
    UserEntity user, {
    required String fileToken,
    required String versionToken,
    required Uint8List bytes,
  }) async {
    return db.tables.fileCloud.updateFileContent(
      db,
      userEntity: user,
      fileToken: fileToken,
      lastVersionToken: versionToken,
      bytes: bytes,
    );
  }

  /// returns false if file was not found.
  Future<bool> deleteFile(
    UserEntity user, {
    required String fileToken,
  }) async {
    final file = await db.tables.fileCloud.getFile(
      db,
      user,
      fileToken: fileToken,
    );
    if (file == null) {
      return false;
    }
    if (file.owner != user) {
      _logger.warning(
          'Somebody other than the owner wanted to delete a file. $fileToken');
      return false;
    }
    return await db.tables.fileCloud.deleteFile(db, fileId: file.fileId);
  }

  Future<FileContent> retrieveFileContent({
    required UserEntity? user,
    required String fileToken,
  }) async {
    final fc =
        await db.tables.fileCloud.selectFileContent(db, fileToken: fileToken);
    if (fc == null ||
        (fc.tokenType == FileTokenType.creator && fc.owner != user)) {
      throw NotFoundException('Unable to find file with token $fileToken');
    }
    return fc;
  }

  Future<FileInfo> getFileDetails(UserEntity? user,
      {required String fileToken}) async {
    final file =
        await db.tables.fileCloud.getFile(db, user, fileToken: fileToken);
    if (file == null) {
      throw NotFoundException('Unable to find file with token $fileToken');
    }
    return file.fileInfo;
  }

  Future<List<FileInfo>> listAllFiles(UserEntity user) async {
    return db.tables.fileCloud.listAllFiles(db, user);
  }

  Future<String> createToken(
    UserEntity user, {
    required String label,
    required String fileToken,
    required bool readOnly,
  }) async {
    final type = readOnly ? FileTokenType.shareReadonly : FileTokenType.share;
    final f = await db.tables.fileCloud.getFile(db, user, fileToken: fileToken);
    if (f == null) {
      throw NotFoundException('Unable to find file with token $fileToken');
    }
    if (f.owner.id != user.id) {
      throw ArgumentError('Only the owner can share a file right now.');
    }
    return await db.tables.fileCloud.createFileToken(
      db,
      fileId: f.fileId,
      label: label,
      fileTokenType: type,
    );
  }

  Future<List<FileTokenInfo>> listFileTokens(UserEntity user,
      {required String fileToken}) async {
    final file =
        await db.tables.fileCloud.getFile(db, user, fileToken: fileToken);
    if (file == null || file.owner != user) {
      throw NotFoundException('Unable to find file with token $fileToken');
    }
    return (await db.tables.fileCloud.listFileTokens(db, fileId: file.fileId))
        .where((e) => e.fileTokenType != FileTokenType.creator)
        .map((e) => e.fileTokenInfo)
        .toList();
  }
}
