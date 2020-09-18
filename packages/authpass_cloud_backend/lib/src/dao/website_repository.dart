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

  Future<ImageInfo> findBestImage(Uri uri) async {
    if (!uri.hasScheme) {
      uri = uri.replace(scheme: 'https');
    }
    // resolve root url.
    uri = uri.resolve('/');
    final image = await db.tables.website.findBestImage(db, uri);
    if (image != null) {
      return image;
    }
    final bi = BestIcon();
    final images = await bi.fetchImages(uri);
    images.images.sort((a, b) => -(a.score().compareTo(b.score())));
    _logger.finer('found images for ${images.urlCanonical}: \n'
        '${images.images.toDebugString()}');
    final website = WebsiteEntity(
      id: cryptoService.createSecureUuid(),
      url: uri.toString(),
      urlCanonical: images.urlCanonical.toString(),
    );
    await db.tables.website.insertWebsite(db, website);
    String bestImageId;
    for (final image in images.images) {
      final imageId =
          await db.tables.website.insertWebsiteImage(db, website, image);
      bestImageId ??= imageId;
    }
    await db.tables.website
        .updateWebsite(db, websiteId: website.id, bestImageId: bestImageId);
    return images.images.first;
  }
}
