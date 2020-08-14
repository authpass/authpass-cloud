import 'dart:convert';
import 'dart:typed_data';

import 'package:authpass_cloud_backend/src/companyimage/besticon.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:postgres_utils/postgres_utils.dart';

part 'website_tables.freezed.dart';

class WebsiteTable extends TableBase with TableConstants {
  WebsiteTable({@required this.cryptoService}) : assert(cryptoService != null);

  static const _TABLE_WEBSITE = 'website';
  static const _TABLE_WEBSITE_IMAGE = 'website_image';

  static const _COL_URL = 'url';
  static const _COL_URL_CANONICAL = 'url_canonical';
  static const _COL_BEST_IMAGE = 'best_image_id';
  static const _COL_WEBSITE_ID = 'website_id';
  static const _COL_MIME_TYPE = 'mime_type';
  static const _COL_BYTES = 'bytes';
  static const _COL_WIDTH = 'width';
  static const _COL_HEIGHT = 'height';
  static const _COL_BRIGHTNESS = 'brightness';

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

  Future<void> insertWebsite(
      DatabaseTransactionBase db, WebsiteEntity entity) async {
    await db.executeInsert(_TABLE_WEBSITE, {
      columnId: entity.id,
      _COL_URL: entity.url,
      _COL_URL_CANONICAL: entity.urlCanonical,
//      _COL_BEST_IMAGE: bestImageId,
    });
  }

  Future<void> updateWebsite(DatabaseTransactionBase db,
      {@required String websiteId, @required String bestImageId}) async {
    await db.executeUpdate(_TABLE_WEBSITE,
        set: {_COL_BEST_IMAGE: bestImageId}, where: {columnId: websiteId});
  }

  Future<String> insertWebsiteImage(DatabaseTransactionBase db,
      WebsiteEntity website, ImageInfo image) async {
    final uuid = cryptoService.createSecureUuid();
    await db.executeInsert(_TABLE_WEBSITE_IMAGE, {
      columnId: uuid,
      _COL_WEBSITE_ID: website.id,
      _COL_URL: image.uri,
      _COL_MIME_TYPE: image.mimeType,
      _COL_BYTES: CustomBind(
          "decode(@$_COL_BYTES, 'base64')", base64.encode(image.bytes)),
      _COL_WIDTH: image.width,
      _COL_HEIGHT: image.height,
      _COL_BRIGHTNESS: image.brightness,
      _COL_IMAGE_TYPE: image.imageLinkType.asString(),
    });
    return uuid;
  }

  Future<ImageInfo> findBestImage(DatabaseTransactionBase db, Uri uri) async {
    final result = await db.query('''
    SELECT i.$_COL_BYTES, i.$_COL_WIDTH, i.$_COL_HEIGHT, i.$_COL_URL, i.$_COL_MIME_TYPE, i.$_COL_BRIGHTNESS, i.$_COL_IMAGE_TYPE
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
    );
  }
}

@freezed
abstract class WebsiteEntity with _$WebsiteEntity {
  const factory WebsiteEntity({
    @required String id,
    @required String url,
    @required String urlCanonical,
  }) = _WebsiteEntity;
}
