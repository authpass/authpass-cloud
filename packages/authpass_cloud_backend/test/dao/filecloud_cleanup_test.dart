import 'dart:convert';
import 'dart:typed_data';

import 'package:authpass_cloud_backend/src/dao/tables/filecloud_tables_enum.dart';
import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:openapi_base/src/openapi_client_base.dart';
import 'package:test/test.dart';

import '../endpoint/endpoint_test.dart';

final _logger = Logger('filecloud_cleanup_test');

void main() {
  PrintAppender.setupLogging();
  _logger.fine('starting tests...');

  const fileName = 'foo.kdbx';
  final content = utf8.encode('test') as Uint8List;
  var now = DateTime.utc(2020, 1, 1);

  endpointTest('cleanup files', (endpoint) async {
    await withClock(Clock((() => now)), () async {
      await EndpointTestUtil.createUserConfirmed(endpoint);
      final result = await endpoint
          .filecloudFilePost(content, fileName: fileName)
          .requireSuccess();
      expect(result.versionToken, isNotEmpty);
      expect(result.fileToken, isNotEmpty);

      FilecloudFilePutResponseBody200? lastResponse;
      Future<void> putFileVersion() async {
        final v = await endpoint
            .filecloudFilePut(
              content,
              fileToken: result.fileToken,
              versionToken: lastResponse?.versionToken ?? result.versionToken,
            )
            .requireSuccess();
        lastResponse = v;
      }

      final createFileConfig = [
        const MapEntry(10, Duration(days: 7)),
        const MapEntry(5, Duration(days: 1)),
        const MapEntry(5, Duration(hours: 24)),
        const MapEntry(5, Duration(hours: 12)),
        const MapEntry(5, Duration(hours: 1)),
        const MapEntry(5, Duration(minutes: 30)),
        const MapEntry(1, Duration(hours: 11)),
      ];

      for (final e in createFileConfig) {
        for (int i = 0; i < e.key; i++) {
          now = now.add(e.value);
          await putFileVersion();
        }
      }

      final before = await endpoint.db.tables.fileCloud.countStats(endpoint.db);
      expect(before.fileCount, 1);
      expect(before.fileContentCount, 37);

      {
        final cleaned = await endpoint.db.tables.fileCloud.cleanup(endpoint.db);
        _logger.fine('cleaned debug: $cleaned');
        final debug = await endpoint.db.tables.fileCloud
            .listFileContentDebug(endpoint.db);
        for (final v in debug) {
          _logger.fine(
              'VERSION: ${(v.versionSignificance?.name ?? '').padLeft(15)}: ${now.difference(v.createdAt)}');
        }
        final stats =
            await endpoint.db.tables.fileCloud.countStats(endpoint.db);
        expect(stats.fileCount, 1);
        expect(stats.fileContentCount, 22);
      }

      // another 25 hours, and there should be no more first of hour versions.
      now = now.add(const Duration(hours: 25));
      {
        await endpoint.db.tables.fileCloud.cleanup(endpoint.db);
        final stats =
            await endpoint.db.tables.fileCloud.countStats(endpoint.db);
        expect(stats.fileCount, 1);
        expect(stats.fileContentCount, 10);
      }

      // another 5 years later, we should be down to a single version.
      now = now.add(const Duration(days: 5 * 365));
      {
        await endpoint.db.tables.fileCloud.cleanup(endpoint.db);
        final stats =
            await endpoint.db.tables.fileCloud.countStats(endpoint.db);
        expect(stats.fileCount, 1);
        expect(stats.fileContentCount, 1);
      }
    });
  });
}
