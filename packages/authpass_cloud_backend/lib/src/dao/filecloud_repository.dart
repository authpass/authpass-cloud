import 'dart:typed_data';

import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/dao/tables/filecloud_tables.dart';
import 'package:authpass_cloud_backend/src/dao/tables/user_tables.dart';
import 'package:authpass_cloud_backend/src/env/env.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:openapi_base/openapi_base.dart';

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

  Future<FileContent> retrieveFileContent({required String fileToken}) async {
    final fc =
        await db.tables.fileCloud.selectFileContent(db, fileToken: fileToken);
    if (fc == null) {
      throw NotFoundException('Unable to find file with token $fileToken');
    }
    return fc;
  }
}
