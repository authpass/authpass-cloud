import 'package:shelf/shelf.dart';

const ACCESS_CONTROL_ALLOW_ORIGIN = 'Access-Control-Allow-Origin';
const ACCESS_CONTROL_EXPOSE_HEADERS = 'Access-Control-Expose-Headers';
const ACCESS_CONTROL_ALLOW_CREDENTIALS = 'Access-Control-Allow-Credentials';
const ACCESS_CONTROL_ALLOW_HEADERS = 'Access-Control-Allow-Headers';
const ACCESS_CONTROL_ALLOW_METHODS = 'Access-Control-Allow-Methods';
const ACCESS_CONTROL_MAX_AGE = 'Access-Control-Max-Age';

const ORIGIN = 'origin';

const _defaultHeadersList = [
  'accept',
  'accept-encoding',
  'authorization',
  'content-type',
  'dnt',
  'origin',
  'user-agent',
];

const _defaultMethodsList = [
  'DELETE',
  'GET',
  'OPTIONS',
  'PATCH',
  'POST',
  'PUT'
];

final Map<String, String> _defaultHeadersMap = {
  // ACCESS_CONTROL_ALLOW_ORIGIN: '*',
  ACCESS_CONTROL_EXPOSE_HEADERS: '',
  ACCESS_CONTROL_ALLOW_CREDENTIALS: 'true',
  ACCESS_CONTROL_ALLOW_HEADERS: _defaultHeadersList.join(','),
  ACCESS_CONTROL_ALLOW_METHODS: _defaultMethodsList.join(','),
  ACCESS_CONTROL_MAX_AGE: '86400',
};

final _defaultHeaders =
    _defaultHeadersMap.map((key, value) => MapEntry(key, [value]));

typedef OriginChecker = bool Function(String origin);

bool allowAll(String origin) => true;

OriginChecker originOneOf(List<String> origins) =>
    (origin) => origins.contains(origin);

Middleware corsHeaders({
  Map<String, List<String>>? headers,
  OriginChecker originChecker = allowAll,
}) {
  return (Handler handler) {
    return (Request request) async {
      final origin = request.headers[ORIGIN];
      if (origin == null || !originChecker(origin)) {
        return handler(request);
      }
      final _headers = <String, List<String>>{
        ..._defaultHeaders,
        ...?headers,
        ACCESS_CONTROL_ALLOW_ORIGIN: [origin],
      };

      if (request.method == 'OPTIONS') {
        return Response.ok(null, headers: _headers);
      }

      final response = await handler(request);
      return response.change(headers: {...response.headersAll, ..._headers});
    };
  };
  // return createMiddleware(
  //     requestHandler: updateRequest, responseHandler: updateResponse);
}
