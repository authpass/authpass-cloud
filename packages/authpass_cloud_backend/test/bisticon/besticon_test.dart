import 'package:authpass_cloud_backend/src/companyimage/besticon.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:test/test.dart';

final _logger = Logger('besticon_test');

void main() {
  PrintAppender.setupLogging();
  test('orf.at', () async {
    final bi = BestIcon();
    final images = await bi.fetchImages(Uri.parse('https://orf.at'));
    _logger.info('got images: $images');
    expect(images.images, isNotEmpty);
  });
  test('evernote.com', () async {
    final bi = BestIcon();
    final images = await bi.fetchImages(Uri.parse('https://evernote.com'));
    _logger.info('images: \n${images.images.toDebugString()}');
    expect(images.images, isNotEmpty);
  });
  test('accounts.jetbrains.com', () async {
    final bi = BestIcon();
    final images =
        await bi.fetchImages(Uri.parse('https://account.jetbrains.com'));
    _logger.info('images: \n${images.images.toDebugString()}');
    expect(images.images, isNotEmpty);
  });
}
