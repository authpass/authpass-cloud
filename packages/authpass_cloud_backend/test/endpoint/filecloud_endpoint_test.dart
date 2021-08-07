import 'dart:convert';
import 'dart:typed_data';

import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:mockito/mockito.dart';
import 'package:openapi_base/openapi_base.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'endpoint_test.dart';

final _logger = Logger('filecloud_endpoint_test');

void main() {
  PrintAppender.setupLogging();
  _logger.fine('starting tests...');

  const _fileName = 'foo.kdbx';
  final _content = utf8.encode('test') as Uint8List;
  final _content2 = utf8.encode('test2') as Uint8List;
  final _content3 = utf8.encode('test3') as Uint8List;

  group('filecloud test', () {
    endpointTest('fail anonymous', (endpoint) async {
      when(endpoint.request.headerParameter('Authorization')).thenReturn([]);
      final result = endpoint.filecloudFilePost(_content, fileName: _fileName);
      expect(result, throwsA(isA<UnauthorizedException>()));
    });
    endpointTest('create file', (endpoint) async {
      await EndpointTestUtil.createUserConfirmed(endpoint);
      final result = await endpoint
          .filecloudFilePost(_content, fileName: _fileName)
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
            .filecloudFilePost(_content, fileName: _fileName)
            .requireSuccess();
        final response = await endpoint
            .filecloudFilePut(_content2,
                fileToken: created.fileToken,
                versionToken: created.versionToken)
            .requireSuccess();
        fakeDate = fakeDate.add(const Duration(days: 14));
        final response2 = await endpoint
            .filecloudFilePut(_content3,
                fileToken: created.fileToken,
                versionToken: response.versionToken)
            .requireSuccess();
        expect(created.versionToken, isNot(response.versionToken));
        expect(response.versionToken, isNot(response2.versionToken));
        final getResponse = await endpoint
            .filecloudFileRetrievePost(
                FilecloudFileRetrievePostSchema(fileToken: created.fileToken))
            .requireSuccess();
        expect(getResponse, _content3);
      });
    });
    endpointTest('update conflict', (endpoint) async {
      await EndpointTestUtil.createUserConfirmed(endpoint);
      final created = await endpoint
          .filecloudFilePost(_content, fileName: _fileName)
          .requireSuccess();
      try {
        // ignore: unused_local_variable
        final response = await endpoint
            .filecloudFilePut(_content,
                fileToken: created.fileToken, versionToken: 'wrong')
            .requireSuccess();
        fail('Did not throw conflict.');
      } catch (e) {
        expect(e, isA<ConflictException>());
      }
    });
    endpointTest('Load file', (endpoint) async {
      await EndpointTestUtil.createUserConfirmed(endpoint);
      final result = await endpoint
          .filecloudFilePost(_content, fileName: _fileName)
          .requireSuccess();
      expect(result.versionToken, isNotEmpty);
      expect(result.fileToken, isNotEmpty);

      final response = await endpoint.filecloudFileRetrievePost(
          FilecloudFileRetrievePostSchema(fileToken: result.fileToken));
      expect(response.headers['etag']?.first, result.versionToken);
    });
    endpointTest('list files', (endpoint) async {
      await EndpointTestUtil.createUserConfirmed(endpoint);
      final result = await endpoint
          .filecloudFilePost(_content, fileName: _fileName)
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
          .filecloudFilePost(_content, fileName: _fileName)
          .requireSuccess();
      final list3 = await endpoint.filecloudFileGet().requireSuccess();
      expect(list3.files, hasLength(1));
      final f = list3.files.single;
      expect(f.fileToken, result2.fileToken);
      expect(f.versionToken, result2.versionToken);
      expect(f.size, _content.length);
    });
  });
}
