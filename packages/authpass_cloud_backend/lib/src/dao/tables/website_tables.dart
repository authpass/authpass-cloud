import 'dart:convert';
import 'dart:typed_data';

import 'package:authpass_cloud_backend/src/companyimage/besticon.dart';
import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:clock/clock.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:postgres_utils/postgres_utils.dart';

part 'website_tables.freezed.dart';

class WebsiteTable extends TableBase with TableConstants {
  WebsiteTable({required this.cryptoService});

  static const _TABLE_WEBSITE = 'website';
  static const _TABLE_WEBSITE_IMAGE = 'website_image';

  static const _COL_URL = 'url';
  static const _COL_FILENAME = 'filename';
  static const _COL_ORIGINAL_BYTE_LENGTH = 'original_byte_length';
  static const _COL_URL_CANONICAL = 'url_canonical';
  static const _COL_BEST_IMAGE = 'best_image_id';
  static const _COL_WEBSITE_ID = 'website_id';
  static const _COL_MIME_TYPE = 'mime_type';
  static const _COL_BYTES = 'bytes';
  static const _COL_WIDTH = 'width';
  static const _COL_HEIGHT = 'height';
  static const _COL_BRIGHTNESS = 'brightness';
  static const _COL_UPDATED_AT = 'updated_at';
  static const _COL_ERROR_CODE = 'error_code';

  /// See [ImageLinkType]
  static const _COL_IMAGE_TYPE = 'image_type';

  @override
  List<String> get tables => [_TABLE_WEBSITE, _TABLE_WEBSITE_IMAGE];

  final CryptoService cryptoService;

  Future<void> createTables(DatabaseTransactionBase conn) async {
    await conn.execute('''
    CREATE TABLE $_TABLE_WEBSITE (
      $specColumnIdPrimaryKey,
      $specColumnCreatedAt,
      $_COL_BEST_IMAGE uuid null,
      $_COL_URL varchar not null unique,
      $_COL_URL_CANONICAL varchar not null
    );
    CREATE TABLE $_TABLE_WEBSITE_IMAGE (
      $specColumnIdPrimaryKey,
      $specColumnCreatedAt,
      $_COL_WEBSITE_ID uuid references $_TABLE_WEBSITE ($columnId) not null,
      $_COL_URL varchar not null,
      $_COL_MIME_TYPE varchar not null,
      $_COL_BYTES bytea not null,
      $_COL_WIDTH int not null,
      $_COL_HEIGHT int not null,
      $_COL_BRIGHTNESS double precision not null,
      $_COL_IMAGE_TYPE varchar not null
    );
    ALTER TABLE $_TABLE_WEBSITE ADD FOREIGN KEY ($_COL_BEST_IMAGE) REFERENCES $_TABLE_WEBSITE_IMAGE ($columnId);
    CREATE INDEX ${_TABLE_WEBSITE}_${_COL_URL_CANONICAL}_idx ON $_TABLE_WEBSITE ($_COL_URL_CANONICAL);
    ''');
  }

  Future<void> migrate7(DatabaseTransaction db) async {
    await db.execute('''
      ALTER TABLE $_TABLE_WEBSITE_IMAGE
        ADD $_COL_ORIGINAL_BYTE_LENGTH INT NULL,
        ADD $_COL_FILENAME VARCHAR NOT NULL DEFAULT '';
      ALTER TABLE $_TABLE_WEBSITE_IMAGE ALTER $_COL_FILENAME DROP DEFAULT;
    ''');
  }

  Future<void> migrate14(DatabaseTransaction db) async {
    await db.execute(
        'ALTER TABLE $_TABLE_WEBSITE ADD $_COL_UPDATED_AT $typeTimestampNotNull DEFAULT NOW();',
        timeoutInSeconds: 120);
    await db.execute(
        'UPDATE $_TABLE_WEBSITE SET $_COL_UPDATED_AT = $columnCreatedAt;',
        timeoutInSeconds: 120);
    await db.execute(
        'ALTER TABLE $_TABLE_WEBSITE ADD $_COL_ERROR_CODE VARCHAR NULL;',
        timeoutInSeconds: 120);
  }

  Future<void> insertWebsite(
    DatabaseTransactionBase db,
    WebsiteEntity entity, {
    String? errorCode,
  }) async {
    await db.executeInsert(_TABLE_WEBSITE, {
      columnId: entity.id,
      _COL_URL: entity.url,
      _COL_URL_CANONICAL: entity.urlCanonical,
      _COL_ERROR_CODE: errorCode,
//      _COL_BEST_IMAGE: bestImageId,
    });
  }

  // Future<void> updateWebsite(
  //     DatabaseTransaction db, WebsiteEntity entity, {String? errorCode}
  //     ) async {
  //   await db.executeUpdate(_TABLE_WEBSITE, set: {
  //
  //   }, where: {});
  // }

  Future<WebsiteInfoDto?> findWebsite(
      DatabaseTransactionBase db, Uri uri) async {
    return await db.query('''
    SELECT $columnId, $_COL_URL, $_COL_URL_CANONICAL, $columnCreatedAt, $_COL_UPDATED_AT, $_COL_ERROR_CODE
    FROM $_TABLE_WEBSITE
    WHERE $_COL_URL = @url
    ''', values: {'url': uri.toString()}).singleOrNull((row) {
      return WebsiteInfoDto(
        id: row[0] as String,
        url: row[1] as String,
        createdAt: row[3] as DateTime,
        updatedAt: row[4] as DateTime,
        errorCode: row[5] as String?,
      );
    });
  }

  Future<void> updateWebsite(
    DatabaseTransactionBase db, {
    required String websiteId,
    required String? bestImageId,
    required String? errorCode,
  }) async {
    await db.executeUpdate(
      _TABLE_WEBSITE,
      set: {
        _COL_BEST_IMAGE: bestImageId,
        _COL_ERROR_CODE: errorCode,
        _COL_UPDATED_AT: clock.now().toUtc(),
      },
      where: {columnId: websiteId},
    );
  }

  Future<String> insertWebsiteImage(DatabaseTransactionBase db,
      WebsiteEntity website, ImageInfo image) async {
    final uuid = cryptoService.createSecureUuid();
    await db.executeInsert(_TABLE_WEBSITE_IMAGE, {
      columnId: uuid,
      _COL_WEBSITE_ID: website.id,
      _COL_URL: image.uri,
      _COL_FILENAME: image.fileName,
      _COL_MIME_TYPE: image.mimeType,
      _COL_BYTES: CustomBind(
          "decode(@$_COL_BYTES, 'base64')", base64.encode(image.bytes)),
      _COL_ORIGINAL_BYTE_LENGTH: image.originalByteLength,
      _COL_WIDTH: image.width,
      _COL_HEIGHT: image.height,
      _COL_BRIGHTNESS: image.brightness,
      _COL_IMAGE_TYPE: image.imageLinkType.asString(),
    });
    return uuid;
  }

  Future<ImageInfo?> findBestImage(DatabaseTransactionBase db, Uri uri) async {
    final result = await db.query('''
    SELECT i.$_COL_BYTES, i.$_COL_WIDTH, i.$_COL_HEIGHT, i.$_COL_URL, i.$_COL_MIME_TYPE, i.$_COL_BRIGHTNESS, i.$_COL_IMAGE_TYPE,
      i.$_COL_ORIGINAL_BYTE_LENGTH, i.$_COL_FILENAME
    FROM $_TABLE_WEBSITE_IMAGE i
      INNER JOIN $_TABLE_WEBSITE w ON i.$columnId = $_COL_BEST_IMAGE
    WHERE w.$_COL_URL = @url LIMIT 1
    ''', values: {'url': uri.toString()});
    if (result.isEmpty) {
      return null;
    }
    final row = result.single;
    return ImageInfo(
      bytes: row[0] as Uint8List,
      width: row[1] as int,
      height: row[2] as int,
      uri: row[3] as String,
      mimeType: row[4] as String,
      brightness: row[5] as double,
      imageLinkType: ImageLinkTypeExt.fromString(row[6] as String),
      originalByteLength: row[7] as int?,
      fileName: row[8] as String,
    );
  }

  Future<SystemStatusWebsite> countStats(DatabaseTransactionBase db) async {
    final c = await db
        .query('SELECT count(id), count(distinct $_COL_URL_CANONICAL) from '
            '$_TABLE_WEBSITE')
        .single;
    return SystemStatusWebsite(
      websiteCount: c[0] as int,
      urlCanonicalCount: c[1] as int,
    );
  }
}

@freezed
class WebsiteEntity with _$WebsiteEntity {
  const factory WebsiteEntity({
    required String id,
    required String url,
    required String urlCanonical,
  }) = _WebsiteEntity;
}

class WebsiteInfoDto {
  WebsiteInfoDto({
    required this.id,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
    required this.errorCode,
  });

  final String id;
  final String url;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? errorCode;
}
