import 'dart:convert';
import 'dart:typed_data';

import 'package:authpass_cloud_backend/src/dao/tables/filecloud_tables.dart';
import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:mockito/mockito.dart';
import 'package:openapi_base/openapi_base.dart';
import 'package:test/test.dart';

import 'endpoint_test.dart';

final _logger = Logger('filecloud_endpoint_test');

void main() {
  PrintAppender.setupLogging();
  _logger.fine('starting tests...');

  const fileName = 'foo.kdbx';
  final content = utf8.encode('test') as Uint8List;
  final content2 = utf8.encode('test2') as Uint8List;
  final content3 = utf8.encode('test3') as Uint8List;

  group('filecloud file test', () {
    endpointTest('fail anonymous', (endpoint) async {
      when(endpoint.request.headerParameter('Authorization')).thenReturn([]);
      final result = endpoint.filecloudFilePost(content, fileName: fileName);
      expect(result, throwsA(isA<UnauthorizedException>()));
    });
    endpointTest('create file', (endpoint) async {
      await EndpointTestUtil.createUserConfirmed(endpoint);
      final result = await endpoint
          .filecloudFilePost(content, fileName: fileName)
          .requireSuccess();
      expect(result.versionToken, isNotEmpty);
      expect(result.fileToken, isNotEmpty);
    });
    endpointTest('update success', (endpoint) async {
      var fakeDate = DateTime(2020);
      final clock = Clock(() => fakeDate);
      await withClock(clock, () async {
        await EndpointTestUtil.createUserConfirmed(endpoint);
        final created = await endpoint
            .filecloudFilePost(content, fileName: fileName)
            .requireSuccess();
        final response = await endpoint
            .filecloudFilePut(content2,
                fileToken: created.fileToken,
                versionToken: created.versionToken)
            .requireSuccess();
        fakeDate = fakeDate.add(const Duration(days: 14));
        final response2 = await endpoint
            .filecloudFilePut(content3,
                fileToken: created.fileToken,
                versionToken: response.versionToken)
            .requireSuccess();
        expect(created.versionToken, isNot(response.versionToken));
        expect(response.versionToken, isNot(response2.versionToken));
        final getResponse = await endpoint
            .filecloudFileRetrievePost(FileId(fileToken: created.fileToken))
            .requireSuccess();
        expect(getResponse, content3);
      });
    });
    endpointTest('update conflict', (endpoint) async {
      await EndpointTestUtil.createUserConfirmed(endpoint);
      final created = await endpoint
          .filecloudFilePost(content, fileName: fileName)
          .requireSuccess();
      try {
        // ignore: unused_local_variable
        final response = await endpoint
            .filecloudFilePut(content,
                fileToken: created.fileToken, versionToken: 'wrong')
            .requireSuccess();
        fail('Did not throw conflict.');
      } catch (e) {
        expect(e, isA<ConflictException>());
      }
    });
    endpointTest('Delete file', (endpoint) async {
      await EndpointTestUtil.createUserConfirmed(endpoint);
      final result = await endpoint
          .filecloudFilePost(content, fileName: fileName)
          .requireSuccess();
      expect(result.versionToken, isNotEmpty);
      expect(result.fileToken, isNotEmpty);

      await endpoint
          .filecloudFileDeletePost(FileId(fileToken: result.fileToken));

      try {
        await endpoint
            .filecloudFileRetrievePost(FileId(fileToken: result.fileToken));
        fail('should throw');
      } catch (e) {
        expect(e, isA<NotFoundException>());
      }

      final list = await endpoint.filecloudFileGet().requireSuccess();
      expect(list.files, isEmpty);

      try {
        await endpoint
            .filecloudFileMetadataPost(FileId(fileToken: result.fileToken));
        fail('should have thrown.');
      } catch (e, stackTrace) {
        _logger.fine('Got exception', e, stackTrace);
        expect(e, isA<NotFoundException>());
      }
    });
    endpointTest('Load file', (endpoint) async {
      await EndpointTestUtil.createUserConfirmed(endpoint);
      final result = await endpoint
          .filecloudFilePost(content, fileName: fileName)
          .requireSuccess();
      expect(result.versionToken, isNotEmpty);
      expect(result.fileToken, isNotEmpty);

      final response = await endpoint
          .filecloudFileRetrievePost(FileId(fileToken: result.fileToken));
      expect(response.headers['etag']?.first, result.versionToken);
    });
    endpointTest('Update lastAccessAt', (endpoint) async {
      DateTime now = DateTime.utc(2020, 1, 1);
      await withClock(Clock(() => now), () async {
        await EndpointTestUtil.createUserConfirmed(endpoint);
        final result = await endpoint
            .filecloudFilePost(content, fileName: fileName)
            .requireSuccess();
        expect(result.versionToken, isNotEmpty);
        expect(result.fileToken, isNotEmpty);

        now = now.add(const Duration(minutes: 5));

        Future<FileContent> _load() async {
          final fc = await endpoint.db.tables.fileCloud
              .selectFileContent(endpoint.db, fileToken: result.fileToken);
          if (fc == null) {
            fail('fc must not be null');
          }
          return fc;
        }

        Future<SystemStatusFileCloud> stats() async {
          return await endpoint.db.tables.fileCloud.countStats(endpoint.db);
        }

        // should still be the old value.
        expect((await _load()).lastAccessAt, DateTime.utc(2020, 1, 1));
        expect((await _load()).lastAccessAt, DateTime.utc(2020, 1, 1));
        expect((await _load()).lastAccessAt, DateTime.utc(2020, 1, 1));
        expect((await stats()).countRecentlyAccessed, 0);
        now = now.add(const Duration(hours: 48));
        expect((await stats()).countRecentlyAccessed, 0);
        expect((await _load()).lastAccessAt, DateTime.utc(2020, 1, 1));
        expect((await _load()).lastAccessAt, now);

        expect((await stats()).countRecentlyAccessed, 1);
        now = now.add(const Duration(days: 2));
        expect((await stats()).countRecentlyAccessed, 0);
        await _load();
        expect((await stats()).countRecentlyAccessed, 1);
        now = now.add(const Duration(days: 2));
        expect((await stats()).countRecentlyAccessed, 0);
      });
    });
    endpointTest('list files', (endpoint) async {
      await EndpointTestUtil.createUserConfirmed(endpoint);
      final result = await endpoint
          .filecloudFilePost(content, fileName: fileName)
          .requireSuccess();
      expect(result.versionToken, isNotEmpty);
      expect(result.fileToken, isNotEmpty);

      final list1 = await endpoint.filecloudFileGet().requireSuccess();
      expect(list1.files, hasLength(1));

      await EndpointTestUtil.createUserConfirmed(endpoint,
          email: 'second@example.com');
      final list2 = await endpoint.filecloudFileGet().requireSuccess();
      expect(list2.files, hasLength(0));

      final result2 = await endpoint
          .filecloudFilePost(content, fileName: fileName)
          .requireSuccess();
      final list3 = await endpoint.filecloudFileGet().requireSuccess();
      expect(list3.files, hasLength(1));
      final f = list3.files.single;
      expect(f.fileToken, result2.fileToken);
      expect(f.versionToken, result2.versionToken);
      expect(f.size, content.length);
    });
  });
  group('file cloud share', () {
    endpointTest('create tokens', (endpoint) async {
      await EndpointTestUtil.createUserConfirmed(endpoint);
      final result = await endpoint
          .filecloudFilePost(content, fileName: fileName)
          .requireSuccess();
      expect(result.versionToken, isNotEmpty);
      expect(result.fileToken, isNotEmpty);

      final tokenResponse = await endpoint
          .filecloudFileTokenCreatePost(FilecloudFileTokenCreatePostSchema(
        fileToken: result.fileToken,
        label: 'foo',
        readOnly: true,
      ));
      final token = tokenResponse.requireSuccess();
      expect(token.fileToken, isNotEmpty);

      final list = await endpoint
          .filecloudFileTokenListPost(FileId(fileToken: result.fileToken))
          .requireSuccess();
      expect(list.tokens, hasLength(1));
      expect(list.tokens.single.fileToken, token.fileToken);

      EndpointTestUtil.clearAuthToken(endpoint);

      final metadata = await endpoint
          .filecloudFileMetadataPost(FileId(fileToken: token.fileToken))
          .requireSuccess();
      expect(metadata.readOnly, true);
    });
  });
  group('attachments', () {
    final attachmentContent = utf8.encode('foo') as Uint8List;
    final attachmentContent2 = utf8.encode('foo') as Uint8List;
    endpointTest('create tokens', (endpoint) async {
      var fakeDate = DateTime.utc(2020);
      final clock = Clock(() => fakeDate);
      await withClock(clock, () async {
        await EndpointTestUtil.createUserConfirmed(endpoint);
        final result = await endpoint
            .filecloudFilePost(content, fileName: fileName)
            .requireSuccess();
        expect(result.versionToken, isNotEmpty);
        expect(result.fileToken, isNotEmpty);

        final a = await endpoint
            .filecloudAttachmentPost(attachmentContent,
                fileName: 'foo.bar', fileToken: result.fileToken)
            .requireSuccess();
        expect(a.attachmentToken, isNotEmpty);
        final a2 = await endpoint
            .filecloudAttachmentPost(attachmentContent2,
                fileName: 'foo.bar', fileToken: result.fileToken)
            .requireSuccess();
        expect(a2.attachmentToken, isNotEmpty);
        expect(a.attachmentToken, isNot(a2.attachmentToken));

        final body = await endpoint
            .filecloudAttachmentRetrievePost(
                AttachmentId(attachmentToken: a.attachmentToken))
            .requireSuccess();
        expect(body, attachmentContent);

        final fileCloud = endpoint.db.tables.fileCloud;
        {
          final stats = await fileCloud.countStats(endpoint.db);
          expect(stats.attachmentCount, 2);
          expect(stats.attachmentLength,
              attachmentContent.length + attachmentContent2.length);
          expect(stats.attachmentUntouchedMonth, 0);
        }

        fakeDate = fakeDate.add(const Duration(days: 120));
        {
          final stats = await fileCloud.countStats(endpoint.db);
          expect(stats.attachmentUntouchedMonth, 2);
        }

        await endpoint
            .filecloudAttachmentTouchPost(AttachmentTouch(
                file: FileId(fileToken: result.fileToken),
                attachmentTokens: [a.attachmentToken]))
            .requireSuccess();
        {
          final stats = await fileCloud.countStats(endpoint.db);
          expect(stats.attachmentUntouchedMonth, 1);
        }
      });
    });
  });
}
