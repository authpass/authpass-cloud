import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:dartx/dartx.dart' show IterableDistinctBy;
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart';
import 'package:image/image.dart';
import 'package:logging/logging.dart';

final _logger = Logger('besticon');

class ImageInfo {
  ImageInfo({
    required this.uri,
    required this.fileName,
    required this.mimeType,
    required this.bytes,
    required this.originalByteLength,
    required this.width,
    required this.height,
    required this.brightness,
    required this.imageLinkType,
  });

  /// the original uri from which the image was downloaded.
  final String uri;

  /// the file name of the image. if the image was reencoded this might
  /// be different from [uri].
  final String fileName;
  final String mimeType;
  final Uint8List bytes;

  /// when the image was re encoded, this contains
  /// the size of the original image.
  final int? originalByteLength;
  final int width;
  final int height;
  final double brightness;
  final ImageLinkType imageLinkType;

  double score({int optimalSize = 512, int optimalRatio = 1}) {
    final image = this;
    // const optimalSize = 512;
    // const optimalRatio = 1;
    // right now, this scoring only works for square images ;-)
    assert(optimalRatio == 1);

    final sizeScoreDistance =
        (optimalSize - max(image.width, image.height)).abs();
    final sizeScore = sizeScoreDistance == 0
        ? 1
        : 1 - (max(0.01, sizeScoreDistance) / optimalSize);
    final ratio = image.width > image.height
        ? image.height / image.width
        : image.width / image.height;
    assert(ratio <= 1, 'something went wrong $width vs $height = $ratio');
    assert(ratio > 0);
    final ratioScore = ratio;
    return (sizeScore + ratioScore) / 2;
  }

  @override
  String toString() {
    return 'ImageInfo{uri: $uri, mimeType: $mimeType, size: $width x $height, brightness: $brightness, type: $imageLinkType}';
  }
}

extension IterableImageInfo<T extends Iterable<ImageInfo>> on T {
  String toDebugString() => map((e) => 'score: ${e.score()}: $e').join('\n');
}

class ImageLink {
  ImageLink({required this.type, required this.uri});

  final ImageLinkType type;
  final Uri uri;
}

enum ImageLinkType {
  logo,

  /// favicons mentioned in html code.
  favico,

  /// Guessed from the path.
  favicoGuessed,

  /// logos guessed by looking for named img elements.
  logoGuessed,
}

const _LinkImageTypeName = 'ImageLinkType';

extension ImageLinkTypeExt on ImageLinkType {
  static const _length = _LinkImageTypeName.length;
  static final _mapping = _createMapping();

  static ImageLinkType fromString(String value) =>
      _mapping[value] ?? (() => throw StateError('Invalid type: $value'))();

  static Map<String, ImageLinkType> _createMapping() {
    if (_LinkImageTypeName !=
        ImageLinkType.values.first.toString().split('.').first) {
      throw StateError('Name changed for $_LinkImageTypeName?');
    }
    return Map.fromEntries(
        ImageLinkType.values.map((e) => MapEntry(e.asString(), e)));
  }

  String asString() => toString().substring(_length + 1);
}

class ResponseException implements Exception {
  ResponseException({required this.response});
  final Response response;

  String debugString() {
    return toString() + '\n' + response.body;
  }

  @override
  String toString() {
    return 'Invalid response ${response.statusCode} for '
        '${response.request?.url}';
  }
}

const _CSS_PATHS_LINK = [
  "link[rel='icon']",
  "link[rel='shortcut icon']",
  "link[rel='apple-touch-icon']",
  "link[rel='apple-touch-icon-precomposed']",

  // Capitalized variants, TODO: refactor
  "link[rel='ICON']",
  "link[rel='SHORTCUT ICON']",
  "link[rel='APPLE-TOUCH-ICON']",
  "link[rel='APPLE-TOUCH-ICON-PRECOMPOSED']"
];

const _CSS_PATH_META = [
  "meta[itemprop='image']",
];

const _CSS_LOGO_IMG_PATHS = [
  '.logo img',
  '.site-logo img',
  'img.logo',
  'img#logo',
  '.navbar-brand img',
  '.brand img'
];

const _ICON_PATHS = [
  '/favicon.ico',
  '/apple-touch-icon.png',
  '/apple-touch-icon-precomposed.png'
];

class _CssPathLink {
  _CssPathLink({
    required this.cssPath,
    required this.linkAttribute,
    required this.linkType,
  });
  final String cssPath;
  final String linkAttribute;
  final ImageLinkType linkType;

  @override
  String toString() {
    return '_CssPathLink{cssPath: $cssPath, linkAttribute: $linkAttribute, linkType: $linkType}';
  }
}

Iterable<_CssPathLink> _createCssPathLinks(
  List<String> cssPaths,
  String linkAttribute,
  ImageLinkType type,
) =>
    cssPaths.map((e) => _CssPathLink(
          cssPath: e,
          linkAttribute: linkAttribute,
          linkType: type,
        ));

final _cssPaths =
    _createCssPathLinks(_CSS_PATHS_LINK, 'href', ImageLinkType.favico)
        .followedBy(
            _createCssPathLinks(
                _CSS_LOGO_IMG_PATHS, 'src', ImageLinkType.logoGuessed))
        .followedBy(_createCssPathLinks(
            _CSS_PATH_META, 'content', ImageLinkType.logoGuessed))
        .toList();

class DecodedImage {
  DecodedImage(
    this.image,
    this.decoder, {
    this.encodedBytes,
    this.encodedMimetype,
    this.encodedFileExtension,
  })  : assert((encodedBytes == null &&
                encodedMimetype == null &&
                encodedFileExtension == null) ||
            (encodedBytes != null &&
                encodedMimetype != null &&
                encodedFileExtension != null)),
        assert(encodedFileExtension == null ||
            encodedFileExtension.startsWith('.'));

  final Image? image;
  final Decoder decoder;
  final Uint8List? encodedBytes;
  final String? encodedMimetype;

  /// file extension including `.`, e.g. `.webp`
  final String? encodedFileExtension;
}

extension MyIterableWhereNotNull<E> on Iterable<E?> {
  /// Returns a new lazy [Iterable] with all elements which are not null.
  Iterable<E> myWhereNotNull() => where((element) => element != null).cast<E>();
}

class BestIcon {
  Client? __client;
  Client get _client => __client ??= _createClient();

  Client _createClient() {
    final c = Client();
    if (c is HttpClient) {
      final httpClient = c as HttpClient;
      _logger.finer('Setting http client connection timeout.');
      httpClient.connectionTimeout = const Duration(seconds: 5);
    }
    return c;
  }

  Future<Response> _requestGet(Uri uri, {int count = 0}) async {
    if (count > 10) {
      throw StateError('Too many redirects for $uri, after $count.');
    }
    final req = Request('GET', uri)..followRedirects = false;
    final response = await Response.fromStream(await _client.send(req));
    final location = response.headers[HttpHeaders.locationHeader];
    if (location != null) {
      final locationUri = uri.resolve(location);
      return await _requestGet(locationUri, count: count + 1);
    }

    _requireSuccess(response);
    return response;
  }

  /// Decodes the given image. If it is of a format which the
  /// client might not understand, we re-encode it to png.
  DecodedImage? _decodeImageAndReEncode(Uint8List bytes) {
    final decoder = findDecoderForData(bytes);
    if (decoder == null) {
      return null;
    }
    if (decoder is IcoDecoder) {
      // extract the largest image and encode it to webp.
      final image = decoder.decodeImageLargest(bytes)!;
      final pngBytes = PngEncoder().encodeImage(image);
      if (pngBytes.isEmpty) {
        _logger.severe('Unable to encode image to webp.');
      }

      return DecodedImage(
        image,
        decoder,
        encodedBytes: pngBytes as Uint8List,
        encodedMimetype: 'image/png',
        encodedFileExtension: '.png',
      );
    }
    return DecodedImage(
      decoder.decodeImage(bytes),
      decoder,
    );
  }

  Future<FetchImageResult> fetchImages(Uri uri) async {
    final imageLinkResult = await _findImageLinks(uri);
    final imageLinks = imageLinkResult.value;
    final images = (await Future.wait(imageLinks.map((imageLink) async {
      try {
        final response = await _client.get(imageLink.uri);
        _requireSuccess(response, acceptOnly: HttpStatus.ok);
        final contentType = ArgumentError.checkNotNull(
            response.headers[HttpHeaders.contentTypeHeader],
            HttpHeaders.contentTypeHeader);
        final ct = ContentType.parse(contentType);
        final imageBytes = response.bodyBytes;
        final decoded = _decodeImageAndReEncode(imageBytes);
        final decodedImage = decoded?.image;
        if (decoded == null || decodedImage == null) {
          _logger.fine('Unable to decode ${imageBytes.length} bytes for '
              '${imageLink.uri} - ${ct.mimeType}');
          return null;
        }
        final fileName = imageLink.uri.pathSegments.last;

        final brightness = _analyseImageBrightnessRatio(decodedImage);
        return ImageInfo(
          uri: imageLink.uri.toString(),
          fileName: fileName + (decoded.encodedFileExtension ?? ''),
          mimeType: decoded.encodedMimetype ?? ct.mimeType,
          bytes: decoded.encodedBytes ?? imageBytes,
          originalByteLength:
              decoded.encodedBytes == null ? null : imageBytes.length,
          width: decodedImage.width,
          height: decodedImage.height,
          brightness: brightness,
          imageLinkType: imageLink.type,
        );
      } on ResponseException catch (e) {
        if (e.response.statusCode == 404 &&
            imageLink.type == ImageLinkType.favicoGuessed) {
          // completely ignore guessed paths.
        } else {
          _logger.fine('Unable to fetch: $e');
        }
        return null;
      } catch (e, stackTrace) {
        _logger.severe(
            'Error while fetching image. ${imageLink.uri}', e, stackTrace);
        return null;
      }
    })))
        .whereNotNull()
        .toList();
    return FetchImageResult(
      urlCanonical: imageLinkResult.key,
      images: images,
    );
  }

  Future<MapEntry<Uri, List<ImageLink>>> _findImageLinks(Uri uri) async {
    final response = await _requestGet(uri);
    final baseUri = response.request?.url ?? uri;
    _requireSuccess(response);
    final dom = parse(response.body, sourceUrl: baseUri.toString());

    return MapEntry(
        baseUri,
        _cssPaths
            .expand((cssPath) {
              _logger.finer('looking for $cssPath');
              return dom.querySelectorAll(cssPath.cssPath).map((el) {
                final link = el.attributes[cssPath.linkAttribute];
                if (link == null) {
                  _logger.warning(
                      'Found element for ${cssPath.linkAttribute} but no '
                      '${cssPath.linkAttribute}: $el');
                  return null;
                }
                _logger.fine('Found $cssPath');
                return ImageLink(
                    type: cssPath.linkType, uri: baseUri.resolve(link));
              });
            })
            .followedBy(_ICON_PATHS.map((e) => ImageLink(
                type: ImageLinkType.favicoGuessed, uri: baseUri.resolve(e))))
            .followedBy(dom
                .querySelectorAll('script[type="application/ld+json"]')
                .map((e) {
              final jsonText = e.text;
              try {
                final ldJson = json.decode(jsonText) as Map<String, dynamic>;
                final dynamic logo = ldJson['logo'];
                if (logo is String) {
                  return ImageLink(
                      type: ImageLinkType.logo, uri: Uri.parse(logo));
                }
              } catch (e, stackTrace) {
                _logger.severe(
                    'Error while parsing linked data.', e, stackTrace);
              }
              return null;
            }))
            .whereNotNull()
            .distinctBy((e) => e.uri)
            .toList());
  }

  void _requireSuccess(Response response, {int? acceptOnly}) {
    if (response.statusCode < 200 || response.statusCode > 299) {
      throw ResponseException(response: response);
    }
    if (acceptOnly != null && response.statusCode != acceptOnly) {
      throw ResponseException(response: response);
    }
  }

  /// returns the ratio of dark pixel to bright pixels.
  /// https://stackoverflow.com/a/35914745/109219
  double _analyseImageBrightnessRatio(Image image) {
    final histogram = List.generate(256, (index) => 0, growable: false);
    var count = 0;
    for (final pixel in image.data) {
      final alpha = getAlpha(pixel);
      if (alpha > 200) {
        continue;
      }
      final r = getRed(pixel);
      final g = getGreen(pixel);
      final b = getBlue(pixel);
      count++;
      final brightness = (0.2126 * r + 0.7152 * g + 0.0722 * b).toInt();
      histogram[brightness]++;
    }
    if (count == 0) {
      _logger.warning('No non-transparent pixels founds.');
      return 1;
    }

    // Count pixels with brightness less then 10
    final darkPixelCount = histogram.sublist(0, 10).sum;
    return darkPixelCount / count;
  }

  void dispose() {
    __client?.close();
    __client = null;
  }
}

class FetchImageResult {
  FetchImageResult({required this.urlCanonical, required this.images});
  final Uri? urlCanonical;
  final List<ImageInfo> images;

  @override
  String toString() {
    return 'FetchImageResult{urlCanonical: $urlCanonical, images: $images}';
  }
}
