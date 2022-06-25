import 'dart:io';

import 'package:authpass_cloud_backend/src/companyimage/besticon.dart';
import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/dao/tables/website_tables.dart';
import 'package:authpass_cloud_backend/src/service/crypto_service.dart';
import 'package:authpass_cloud_backend/src/util/private_ip.dart';
import 'package:clock/clock.dart';
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

    if (!await _isAllowedUri(uri)) {
      return null;
    }

    // resolve root url.
    uri = uri.resolve('/');

    final image = await db.tables.website.findBestImage(db, uri);
    if (image != null) {
      return image;
    }

    final cachedWebsite = await db.tables.website.findWebsite(db, uri);
    if (cachedWebsite != null) {
      // TODO occasionally refresh the website.
      _logger.finest(
          'Recorded website without image. $uri ${cachedWebsite.errorCode}');
      final cacheAge = clock.now().difference(cachedWebsite.updatedAt);
      if (cacheAge.inDays < 7) {
        return null;
      }
      _logger.fine('cached more than 7 days ago. refreshing.');
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
      if (cachedWebsite == null) {
        await db.tables.website.insertWebsite(
          db,
          WebsiteEntity(
            id: cryptoService.createSecureUuid(),
            url: uri.toString(),
            urlCanonical: uri.toString(),
          ),
          errorCode: errorCode,
        );
      } else {
        await db.tables.website.updateWebsite(
          db,
          websiteId: cachedWebsite.id,
          bestImageId: null,
          errorCode: errorCode,
        );
      }
      return null;
    }
    final images = imagesResult.images;
    images.sort((a, b) => -(a.score().compareTo(b.score())));
    _logger.finer('found images for ${imagesResult.urlCanonical}: \n'
        '${images.toDebugString()}');
    final website = WebsiteEntity(
      id: cachedWebsite?.id ?? cryptoService.createSecureUuid(),
      url: uri.toString(),
      urlCanonical: imagesResult.urlCanonical.toString(),
    );
    if (images.isEmpty) {
      if (cachedWebsite == null) {
        await db.tables.website.insertWebsite(db, website, errorCode: 'empty');
      } else {
        await db.tables.website.updateWebsite(
          db,
          websiteId: cachedWebsite.id,
          bestImageId: null,
          errorCode: 'empty',
        );
      }
      return null;
    }
    if (cachedWebsite == null) {
      await db.tables.website.insertWebsite(db, website);
    }
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

  Future<bool> _isAllowedUri(Uri uri) async {
    if (uri.hasPort) {
      _logger.finest('Uri with non-standard port, ignored. $uri');
      return false;
    }
    if (uri.userInfo.isNotEmpty) {
      _logger.finest('Uri with userInfo. ignored. $uri');
      return false;
    }
    if (['local', 'localhost'].contains(uri.host)) {
      _logger.finest('Localhost ignored. $uri');
      return false;
    }

    try {
      final ips = await InternetAddress.lookup(uri.host)
          .timeout(const Duration(seconds: 10));
      for (final ip in ips) {
        if (ip.isLoopback ||
            ip.isLinkLocal ||
            ip.isMulticast ||
            isPrivateIpV4(ip) ||
            isUniqueLocalIpV6(ip)) {
          _logger.finest('uri resolved to local/private ip $uri ($ip)');
          return false;
        }
      }
      return true;
    } catch (e, stackTrace) {
      _logger.warning('Error during host lookup. $uri', e, stackTrace);
      return false;
    }
  }
}
