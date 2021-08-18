import 'package:authpass_cloud_backend/src/endpoint/email_confirmation.dart';
import 'package:authpass_cloud_backend/src/env/env.dart';
import 'package:logging/logging.dart';
import 'package:openapi_base/openapi_base.dart';
import 'package:shelf/shelf.dart' as shelf;

final _logger = Logger('exception_middleware');

typedef OpenApiExceptionTransformer = String Function(
    OpenApiResponseException e);

shelf.Middleware handleOpenApiException(Env env) {
  return _handleOpenApiExceptions((e) => genericErrorContent(
        env,
        e.message,
        title: e.status == OpenApiHttpStatus.badRequest ? 'Bad Request' : null,
      ));
}

shelf.Middleware _handleOpenApiExceptions(
    OpenApiExceptionTransformer transform) {
  return (shelf.Handler innerHandler) {
    return (shelf.Request request) async {
      try {
        return await innerHandler(request);
      } on OpenApiResponseException catch (e, stackTrace) {
        _logger.fine(
            'response exception during request handling', e, stackTrace);
        return shelf.Response(
          e.status,
          body: transform(e),
          headers: {
            OpenApiHttpHeaders.contentType: OpenApiContentType.html.toString(),
          },
        );
      }
    };
  };
}
