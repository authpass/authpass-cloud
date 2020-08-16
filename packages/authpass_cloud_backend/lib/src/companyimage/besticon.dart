import 'dart:io';
import 'dart:typed_data';

import 'package:dartx/dartx.dart';
import 'package:http/http.dart';
import 'package:image/image.dart';
import 'package:meta/meta.dart';
import 'package:html/parser.dart' show parse;

import 'package:logging/logging.dart';

final _logger = Logger('besticon');

class ImageInfo {
  ImageInfo({
    @required this.uri,
    @required this.fileName,
    @required this.mimeType,
    @required this.bytes,
    @required this.originalByteLength,
    @required this.width,
    @required this.height,
    @required this.brightness,
    @required this.imageLinkType,
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
  final int originalByteLength;
  final int width;
  final int height;
  final double brightness;
  final ImageLinkType imageLinkType;

  @override
  String toString() {
    return 'ImageInfo{uri: $uri, mimeType: $mimeType, size: $width x $height, brightness: $brightness}';
  }
}

class ImageLink {
  ImageLink({@required this.type, @required this.uri});

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

  static ImageLinkType fromString(String value) => _mapping[value];

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
  ResponseException({@required this.response});
  final Response response;

  String debugString() {
    return toString() + '\n' + response.body;
  }

  @override
  String toString() {
    return 'Invalid response ${response.statusCode} for '
        '${response.request.url}';
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
    @required this.cssPath,
    @required this.linkAttribute,
    @required this.linkType,
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

  final Image image;
  final Decoder decoder;
  final Uint8List encodedBytes;
  final String encodedMimetype;

  /// file extension including `.`, e.g. `.webp`
  final String encodedFileExtension;
}

class BestIcon {
  Client __client;
  Client get _client => __client ??= Client();

  Future<Response> _requestGet(Uri uri, {int count = 0}) async {
    if (count > 10) {
      throw StateError('Too many redirects for $uri, after $count.');
    }
    final req = Request('GET', uri)..followRedirects = false;
    final response = await Response.fromStream(await _client.send(req));
    final location = response.headers[HttpHeaders.locationHeader];
    if (location != null) {
      return await _requestGet(Uri.parse(location), count: count + 1);
    }

    _requireSuccess(response);
    return response;
  }

  /// Decodes the given image. If it is of a format which the
  /// client might not understand, we re-encode it to png.
  DecodedImage _decodeImageAndReEncode(Uint8List bytes) {
    final decoder = findDecoderForData(bytes);
    if (decoder == null) {
      return null;
    }
    if (decoder is IcoDecoder) {
      // extract the largest image and encode it to webp.
      final image = decoder.decodeImageLargest(bytes);
      final pngBytes = PngEncoder().encodeImage(image);
      if (pngBytes == null || pngBytes.isEmpty) {
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
        _requireSuccess(response);
        final contentType = response.headers[HttpHeaders.contentTypeHeader];
        final ct = ContentType.parse(contentType);
        final imageBytes = response.bodyBytes;
        final decoded = _decodeImageAndReEncode(imageBytes);
        if (decoded == null || decoded.image == null) {
          _logger.fine('Unable to decode ${imageBytes.length} bytes for '
              '${imageLink.uri} - ${ct.mimeType}');
          return null;
        }
        final image = decoded.image;
        final fileName = imageLink.uri.pathSegments.last;

        final brightness = _analyseImageBrightnessRatio(image);
        return ImageInfo(
          uri: imageLink.uri.toString(),
          fileName: fileName + (decoded.encodedFileExtension ?? ''),
          mimeType: decoded.encodedMimetype ?? ct.mimeType,
          bytes: decoded.encodedBytes ?? imageBytes,
          originalByteLength:
              decoded.encodedBytes == null ? null : imageBytes.length,
          width: image.width,
          height: image.height,
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
        _logger.severe('Error while fetching image.', e, stackTrace);
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
    final baseUri = response.request.url;
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
            .whereNotNull()
            .distinctBy((e) => e.uri)
            .toList());
  }

  void _requireSuccess(Response response) {
    if (response.statusCode < 200 || response.statusCode > 299) {
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
    final darkPixelCount = histogram.sublist(0, 10).sum();
    return darkPixelCount / count;
  }

  void dispose() {
    __client?.close();
    __client = null;
  }
}

class FetchImageResult {
  FetchImageResult({this.urlCanonical, this.images});
  final Uri urlCanonical;
  final List<ImageInfo> images;
}
