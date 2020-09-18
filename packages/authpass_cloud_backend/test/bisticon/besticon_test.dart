import 'package:authpass_cloud_backend/src/companyimage/besticon.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:test/test.dart';

import 'package:logging/logging.dart';

final _logger = Logger('besticon_test');

void main() {
  PrintAppender.setupLogging();
  test('orf.at', () async {
    final bi = BestIcon();
    final images = await bi.fetchImages(Uri.parse('https://orf.at'));
    _logger.info('got images: $images');
  });
  test('evernote.com', () async {
    final bi = BestIcon();
    final images = await bi.fetchImages(Uri.parse('https://evernote.com'));
    _logger.info('images: \n${images.images.toDebugString()}');
  });
}
