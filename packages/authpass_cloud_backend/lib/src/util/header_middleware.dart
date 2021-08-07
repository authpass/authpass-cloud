import 'package:shelf/shelf.dart';

Middleware customizeHeaders(Map<String, String> headers) {
  final headersAll = headers.map((key, value) => MapEntry(key, [value]));
  return (Handler handler) {
    return (Request request) async {
      final response = await handler(request);
      return response.change(headers: {
        ...response.headersAll,
        ...headersAll,
      });
    };
  };
}
