import 'package:authpass_cloud_backend/src/companyimage/besticon.dart';
import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/dao/tables/website_tables.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:logging/logging.dart';

final _logger = Logger('website_repository');

class WebsiteRepository {
  WebsiteRepository(this.db, this.cryptoService);
  final DatabaseTransaction db;
  final CryptoService cryptoService;

  Future<ImageInfo?> findBestImage(Uri uri) async {
    if (!uri.hasScheme) {
      uri = uri.replace(scheme: 'https');
    }
    // resolve root url.
    uri = uri.resolve('/');
    final image = await db.tables.website.findBestImage(db, uri);
    if (image != null) {
      return image;
    }

    {
      final cachedWebsite = await db.tables.website.findWebsite(db, uri);
      if (cachedWebsite != null) {
        // TODO occasionally refresh the website.
        _logger.finest(
            'Recorded website without image. $uri ${cachedWebsite.errorCode}');
        return null;
      }
    }

    final bi = BestIcon();
    final FetchImageResult imagesResult;
    try {
      imagesResult = await bi.fetchImages(uri);
    } catch (e, stackTrace) {
      _logger.finer('Error fetching images from $uri.', e, stackTrace);
      final String errorCode;
      if (e is ResponseException) {
        errorCode = e.response.statusCode.toString();
      } else {
        errorCode = 'e: ${e.toString()}';
      }
      await db.tables.website.insertWebsite(
        db,
        WebsiteEntity(
          id: cryptoService.createSecureUuid(),
          url: uri.toString(),
          urlCanonical: uri.toString(),
        ),
        errorCode: errorCode,
      );
      return null;
    }
    final images = imagesResult.images;
    images.sort((a, b) => -(a.score().compareTo(b.score())));
    _logger.finer('found images for ${imagesResult.urlCanonical}: \n'
        '${images.toDebugString()}');
    final website = WebsiteEntity(
      id: cryptoService.createSecureUuid(),
      url: uri.toString(),
      urlCanonical: imagesResult.urlCanonical.toString(),
    );
    if (images.isEmpty) {
      await db.tables.website.insertWebsite(db, website, errorCode: 'empty');
      return null;
    }
    await db.tables.website.insertWebsite(db, website);
    String? bestImageId;
    for (final image in images) {
      final imageId =
          await db.tables.website.insertWebsiteImage(db, website, image);
      bestImageId ??= imageId;
    }
    if (bestImageId != null) {
      await db.tables.website.updateWebsite(
        db,
        websiteId: website.id,
        bestImageId: bestImageId,
        errorCode: null,
      );
    } else {
      _logger.warning('Unable to find bestImage for ${website.id} $uri');
    }
    return images.first;
  }
}
