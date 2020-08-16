import 'dart:math';
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
    images.images.sort((a, b) => -(_score(a).compareTo(_score(b))));
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

  double _score(ImageInfo image) {
    const optimalSize = 512;
    const optimalRatio = 1;
    // right now, this scoring only works for square images ;-)
    assert(optimalRatio == 1);

    final sizeScoreDistance =
        (optimalSize - max(image.width, image.height)).abs();
    final sizeScore = sizeScoreDistance == 0
        ? 1
        : 1 - (max(0.01, sizeScoreDistance) / optimalSize);
    final ratio = image.width > image.height
        ? image.width / image.height
        : image.height / image.width;
    assert(ratio <= 1);
    assert(ratio > 0);
    final ratioScore = ratio;
    final score = (sizeScore + ratioScore) / 2;
    _logger.finest('Score for (${image.width}x${image.height})'
        '=($sizeScore+$ratioScore)=$score');
    return score;
  }
}
