// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_initializing_formals

import 'package:json_annotation/json_annotation.dart' as _i1;
import 'package:meta/meta.dart' as _i3;
import 'package:openapi_base/openapi_base.dart' as _i2;
part 'authpass_cloud.openapi.g.dart';

///
@_i1.JsonSerializable()
class RegisterRequest implements _i2.OpenApiContent {
  RegisterRequest({@_i3.required this.email});

  factory RegisterRequest.fromJson(Map<String, dynamic> jsonMap) =>
      _$RegisterRequestFromJson(jsonMap);

  /// Email address for the current user.
  @_i1.JsonKey(name: 'email')
  final String email;

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
  @override
  String toString() => toJson().toString();
}

enum RegisterResponseStatus {
  @_i1.JsonValue('created')
  created,
  @_i1.JsonValue('confirmed')
  confirmed,
}

extension RegisterResponseStatusExt on RegisterResponseStatus {
  static final Map<String, RegisterResponseStatus> _names = {
    'created': RegisterResponseStatus.created,
    'confirmed': RegisterResponseStatus.confirmed
  };
  static RegisterResponseStatus fromName(String name) => _names[name];
  String get name => toString().substring(23);
}

///
@_i1.JsonSerializable()
class RegisterResponse implements _i2.OpenApiContent {
  RegisterResponse(
      {@_i3.required this.userUuid,
      @_i3.required this.authToken,
      @_i3.required this.status});

  factory RegisterResponse.fromJson(Map<String, dynamic> jsonMap) =>
      _$RegisterResponseFromJson(jsonMap);

  /// Uuid of the newly registered user.
  @_i1.JsonKey(name: 'userUuid')
  final String userUuid;

  /// Auth token which can be used for authentication, once email is confirmed.
  @_i1.JsonKey(name: 'authToken')
  final String authToken;

  /// Status of the user and auth token (created or confirmed).
  @_i1.JsonKey(name: 'status')
  final RegisterResponseStatus status;

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
  @override
  String toString() => toJson().toString();
}

class _CheckGetResponse200 extends CheckGetResponse {
  /// Everything OK
  _CheckGetResponse200.response200() : status = 200;

  @override
  final int status;

  @override
  final _i2.OpenApiContentType contentType = null;

  @override
  Map<String, Object> propertiesToString() =>
      {'status': status, 'contentType': contentType};
}

abstract class CheckGetResponse extends _i2.OpenApiResponse {
  CheckGetResponse();

  /// Everything OK
  factory CheckGetResponse.response200() => _CheckGetResponse200.response200();

  void map({@_i3.required _i2.ResponseMap<_CheckGetResponse200> on200}) {
    if (this is _CheckGetResponse200) {
      on200((this as _CheckGetResponse200));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }
}

class _UserRegisterPostResponse200 extends UserRegisterPostResponse
    implements _i2.OpenApiResponseBodyJson {
  /// OK
  _UserRegisterPostResponse200.response200(this.body)
      : status = 200,
        bodyJson = body.toJson();

  @override
  final int status;

  final RegisterResponse body;

  @override
  final Map<String, dynamic> bodyJson;

  @override
  final _i2.OpenApiContentType contentType =
      _i2.OpenApiContentType.parse('application/json');

  @override
  Map<String, Object> propertiesToString() => {
        'status': status,
        'body': body,
        'bodyJson': bodyJson,
        'contentType': contentType
      };
}

abstract class UserRegisterPostResponse extends _i2.OpenApiResponse
    implements _i2.HasSuccessResponse<RegisterResponse> {
  UserRegisterPostResponse();

  /// OK
  factory UserRegisterPostResponse.response200(RegisterResponse body) =>
      _UserRegisterPostResponse200.response200(body);

  void map(
      {@_i3.required _i2.ResponseMap<_UserRegisterPostResponse200> on200}) {
    if (this is _UserRegisterPostResponse200) {
      on200((this as _UserRegisterPostResponse200));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }

  @override
  RegisterResponse requireSuccess() {
    if (this is _UserRegisterPostResponse200) {
      return (this as _UserRegisterPostResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

enum EmailStatusGetResponseBody200Status {
  @_i1.JsonValue('created')
  created,
  @_i1.JsonValue('confirmed')
  confirmed,
}

extension EmailStatusGetResponseBody200StatusExt
    on EmailStatusGetResponseBody200Status {
  static final Map<String, EmailStatusGetResponseBody200Status> _names = {
    'created': EmailStatusGetResponseBody200Status.created,
    'confirmed': EmailStatusGetResponseBody200Status.confirmed
  };
  static EmailStatusGetResponseBody200Status fromName(String name) =>
      _names[name];
  String get name => toString().substring(36);
}

///
@_i1.JsonSerializable()
class EmailStatusGetResponseBody200 implements _i2.OpenApiContent {
  EmailStatusGetResponseBody200({this.status});

  factory EmailStatusGetResponseBody200.fromJson(
          Map<String, dynamic> jsonMap) =>
      _$EmailStatusGetResponseBody200FromJson(jsonMap);

  /// null
  @_i1.JsonKey(name: 'status')
  final EmailStatusGetResponseBody200Status status;

  Map<String, dynamic> toJson() => _$EmailStatusGetResponseBody200ToJson(this);
  @override
  String toString() => toJson().toString();
}

class _EmailStatusGetResponse200 extends EmailStatusGetResponse
    implements _i2.OpenApiResponseBodyJson {
  /// Whether it was confirmed or not.
  _EmailStatusGetResponse200.response200(this.body)
      : status = 200,
        bodyJson = body.toJson();

  @override
  final int status;

  final EmailStatusGetResponseBody200 body;

  @override
  final Map<String, dynamic> bodyJson;

  @override
  final _i2.OpenApiContentType contentType =
      _i2.OpenApiContentType.parse('application/json');

  @override
  Map<String, Object> propertiesToString() => {
        'status': status,
        'body': body,
        'bodyJson': bodyJson,
        'contentType': contentType
      };
}

abstract class EmailStatusGetResponse extends _i2.OpenApiResponse
    implements _i2.HasSuccessResponse<EmailStatusGetResponseBody200> {
  EmailStatusGetResponse();

  /// Whether it was confirmed or not.
  factory EmailStatusGetResponse.response200(
          EmailStatusGetResponseBody200 body) =>
      _EmailStatusGetResponse200.response200(body);

  void map({@_i3.required _i2.ResponseMap<_EmailStatusGetResponse200> on200}) {
    if (this is _EmailStatusGetResponse200) {
      on200((this as _EmailStatusGetResponse200));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }

  @override
  EmailStatusGetResponseBody200 requireSuccess() {
    if (this is _EmailStatusGetResponse200) {
      return (this as _EmailStatusGetResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class _EmailConfirmGetResponse200 extends EmailConfirmGetResponse
    implements _i2.OpenApiResponseBodyString {
  /// OK
  _EmailConfirmGetResponse200.response200(this.body) : status = 200;

  @override
  final int status;

  @override
  final String body;

  @override
  final _i2.OpenApiContentType contentType =
      _i2.OpenApiContentType.parse('text/html');

  @override
  Map<String, Object> propertiesToString() =>
      {'status': status, 'body': body, 'contentType': contentType};
}

class _EmailConfirmGetResponse400 extends EmailConfirmGetResponse {
  /// Invalid token or email address.
  _EmailConfirmGetResponse400.response400() : status = 400;

  @override
  final int status;

  @override
  final _i2.OpenApiContentType contentType = null;

  @override
  Map<String, Object> propertiesToString() =>
      {'status': status, 'contentType': contentType};
}

abstract class EmailConfirmGetResponse extends _i2.OpenApiResponse {
  EmailConfirmGetResponse();

  /// OK
  factory EmailConfirmGetResponse.response200(String body) =>
      _EmailConfirmGetResponse200.response200(body);

  /// Invalid token or email address.
  factory EmailConfirmGetResponse.response400() =>
      _EmailConfirmGetResponse400.response400();

  void map(
      {@_i3.required _i2.ResponseMap<_EmailConfirmGetResponse200> on200,
      @_i3.required _i2.ResponseMap<_EmailConfirmGetResponse400> on400}) {
    if (this is _EmailConfirmGetResponse200) {
      on200((this as _EmailConfirmGetResponse200));
    } else if (this is _EmailConfirmGetResponse400) {
      on400((this as _EmailConfirmGetResponse400));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }
}

class _EmailConfirmPostResponse200 extends EmailConfirmPostResponse
    implements _i2.OpenApiResponseBodyString {
  /// OK
  _EmailConfirmPostResponse200.response200(this.body) : status = 200;

  @override
  final int status;

  @override
  final String body;

  @override
  final _i2.OpenApiContentType contentType =
      _i2.OpenApiContentType.parse('text/html');

  @override
  Map<String, Object> propertiesToString() =>
      {'status': status, 'body': body, 'contentType': contentType};
}

class _EmailConfirmPostResponse400 extends EmailConfirmPostResponse {
  /// Invalid token or email address.
  _EmailConfirmPostResponse400.response400() : status = 400;

  @override
  final int status;

  @override
  final _i2.OpenApiContentType contentType = null;

  @override
  Map<String, Object> propertiesToString() =>
      {'status': status, 'contentType': contentType};
}

abstract class EmailConfirmPostResponse extends _i2.OpenApiResponse {
  EmailConfirmPostResponse();

  /// OK
  factory EmailConfirmPostResponse.response200(String body) =>
      _EmailConfirmPostResponse200.response200(body);

  /// Invalid token or email address.
  factory EmailConfirmPostResponse.response400() =>
      _EmailConfirmPostResponse400.response400();

  void map(
      {@_i3.required _i2.ResponseMap<_EmailConfirmPostResponse200> on200,
      @_i3.required _i2.ResponseMap<_EmailConfirmPostResponse400> on400}) {
    if (this is _EmailConfirmPostResponse200) {
      on200((this as _EmailConfirmPostResponse200));
    } else if (this is _EmailConfirmPostResponse400) {
      on400((this as _EmailConfirmPostResponse400));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }
}

///
@_i1.JsonSerializable()
class EmailConfirmSchema implements _i2.OpenApiContent {
  EmailConfirmSchema({@_i3.required this.token, this.gRecaptchaResponse});

  factory EmailConfirmSchema.fromJson(Map<String, dynamic> jsonMap) =>
      _$EmailConfirmSchemaFromJson(jsonMap);

  /// null
  @_i1.JsonKey(name: 'token')
  final String token;

  /// null
  @_i1.JsonKey(name: 'g-recaptcha-response')
  final String gRecaptchaResponse;

  Map<String, dynamic> toJson() => _$EmailConfirmSchemaToJson(this);
  @override
  String toString() => toJson().toString();
}

///
@_i1.JsonSerializable()
class MailboxCreatePostResponseBody200 implements _i2.OpenApiContent {
  MailboxCreatePostResponseBody200({this.address});

  factory MailboxCreatePostResponseBody200.fromJson(
          Map<String, dynamic> jsonMap) =>
      _$MailboxCreatePostResponseBody200FromJson(jsonMap);

  /// The address of the new mailbox.
  @_i1.JsonKey(name: 'address')
  final String address;

  Map<String, dynamic> toJson() =>
      _$MailboxCreatePostResponseBody200ToJson(this);
  @override
  String toString() => toJson().toString();
}

class _MailboxCreatePostResponse200 extends MailboxCreatePostResponse
    implements _i2.OpenApiResponseBodyJson {
  /// Successfully created mailbox.
  _MailboxCreatePostResponse200.response200(this.body)
      : status = 200,
        bodyJson = body.toJson();

  @override
  final int status;

  final MailboxCreatePostResponseBody200 body;

  @override
  final Map<String, dynamic> bodyJson;

  @override
  final _i2.OpenApiContentType contentType =
      _i2.OpenApiContentType.parse('application/json');

  @override
  Map<String, Object> propertiesToString() => {
        'status': status,
        'body': body,
        'bodyJson': bodyJson,
        'contentType': contentType
      };
}

abstract class MailboxCreatePostResponse extends _i2.OpenApiResponse
    implements _i2.HasSuccessResponse<MailboxCreatePostResponseBody200> {
  MailboxCreatePostResponse();

  /// Successfully created mailbox.
  factory MailboxCreatePostResponse.response200(
          MailboxCreatePostResponseBody200 body) =>
      _MailboxCreatePostResponse200.response200(body);

  void map(
      {@_i3.required _i2.ResponseMap<_MailboxCreatePostResponse200> on200}) {
    if (this is _MailboxCreatePostResponse200) {
      on200((this as _MailboxCreatePostResponse200));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }

  @override
  MailboxCreatePostResponseBody200 requireSuccess() {
    if (this is _MailboxCreatePostResponse200) {
      return (this as _MailboxCreatePostResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

///
@_i1.JsonSerializable()
class MailboxCreateSchema implements _i2.OpenApiContent {
  MailboxCreateSchema({this.label, this.entryUuid});

  factory MailboxCreateSchema.fromJson(Map<String, dynamic> jsonMap) =>
      _$MailboxCreateSchemaFromJson(jsonMap);

  /// label for this mailbox, can be an empty string.
  @_i1.JsonKey(name: 'label')
  final String label;

  /// Client provided entry uuid to match with password entry, can be an empty string.
  @_i1.JsonKey(name: 'entryUuid')
  final String entryUuid;

  Map<String, dynamic> toJson() => _$MailboxCreateSchemaToJson(this);
  @override
  String toString() => toJson().toString();
}

class _EmailReceivePostResponse200 extends EmailReceivePostResponse {
  /// Received and delivered successfully.
  _EmailReceivePostResponse200.response200() : status = 200;

  @override
  final int status;

  @override
  final _i2.OpenApiContentType contentType = null;

  @override
  Map<String, Object> propertiesToString() =>
      {'status': status, 'contentType': contentType};
}

class _EmailReceivePostResponse403 extends EmailReceivePostResponse
    implements _i2.OpenApiResponseBodyString {
  /// Delivery not accepted.
  _EmailReceivePostResponse403.response403(this.body) : status = 403;

  @override
  final int status;

  @override
  final String body;

  @override
  final _i2.OpenApiContentType contentType =
      _i2.OpenApiContentType.parse('text/plain');

  @override
  Map<String, Object> propertiesToString() =>
      {'status': status, 'body': body, 'contentType': contentType};
}

abstract class EmailReceivePostResponse extends _i2.OpenApiResponse {
  EmailReceivePostResponse();

  /// Received and delivered successfully.
  factory EmailReceivePostResponse.response200() =>
      _EmailReceivePostResponse200.response200();

  /// Delivery not accepted.
  factory EmailReceivePostResponse.response403(String body) =>
      _EmailReceivePostResponse403.response403(body);

  void map(
      {@_i3.required _i2.ResponseMap<_EmailReceivePostResponse200> on200,
      @_i3.required _i2.ResponseMap<_EmailReceivePostResponse403> on403}) {
    if (this is _EmailReceivePostResponse200) {
      on200((this as _EmailReceivePostResponse200));
    } else if (this is _EmailReceivePostResponse403) {
      on403((this as _EmailReceivePostResponse403));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }
}

abstract class AuthPassCloud implements _i2.ApiEndpoint {
  /// Health check.
  /// get: /check
  Future<CheckGetResponse> checkGet();

  /// Create new user, or login the user using confirmation email.
  /// post: /user/register
  Future<UserRegisterPostResponse> userRegisterPost(RegisterRequest body);

  /// Get the status of the current auth token (whether it was confirmed or not).
  /// get: /email/status
  Future<EmailStatusGetResponse> emailStatusGet();

  /// Confirm email address
  /// get: /email/confirm
  Future<EmailConfirmGetResponse> emailConfirmGet({@_i3.required String token});

  /// Confirm with recaptcha
  /// post: /email/confirm
  Future<EmailConfirmPostResponse> emailConfirmPost(EmailConfirmSchema body);

  /// Creates a new (random) email address mailbox.
  /// post: /mailbox/create
  Future<MailboxCreatePostResponse> mailboxCreatePost(MailboxCreateSchema body);

  /// Receive emails throw smtp bridge.
  /// post: /email/receive
  /// [body]: Email content (header and body)
  Future<EmailReceivePostResponse> emailReceivePost(String body,
      {@_i3.required String xAuthpassToken});
}

abstract class AuthPassCloudClient implements _i2.OpenApiClient {
  factory AuthPassCloudClient(
          Uri baseUri, _i2.OpenApiRequestSender requestSender) =>
      _AuthPassCloudClientImpl._(baseUri, requestSender);

  /// Health check.
  /// get: /check
  ///
  Future<CheckGetResponse> checkGet();

  /// Create new user, or login the user using confirmation email.
  /// post: /user/register
  ///
  Future<UserRegisterPostResponse> userRegisterPost(RegisterRequest body);

  /// Get the status of the current auth token (whether it was confirmed or not).
  /// get: /email/status
  ///
  Future<EmailStatusGetResponse> emailStatusGet();

  /// Confirm email address
  /// get: /email/confirm
  ///
  /// * [token]: Unique token which was sent to email address.
  Future<EmailConfirmGetResponse> emailConfirmGet({@_i3.required String token});

  /// Confirm with recaptcha
  /// post: /email/confirm
  ///
  Future<EmailConfirmPostResponse> emailConfirmPost(EmailConfirmSchema body);

  /// Creates a new (random) email address mailbox.
  /// post: /mailbox/create
  ///
  Future<MailboxCreatePostResponse> mailboxCreatePost(MailboxCreateSchema body);

  /// Receive emails throw smtp bridge.
  /// post: /email/receive
  ///
  /// * [xAuthpassToken]: Security token to validate origin from trusted server
  /// [body]: Email content (header and body)
  Future<EmailReceivePostResponse> emailReceivePost(String body,
      {@_i3.required String xAuthpassToken});
}

class _AuthPassCloudClientImpl extends _i2.OpenApiClientBase
    implements AuthPassCloudClient {
  _AuthPassCloudClientImpl._(this.baseUri, this.requestSender);

  @override
  final Uri baseUri;

  @override
  final _i2.OpenApiRequestSender requestSender;

  /// Health check.
  /// get: /check
  ///
  @override
  Future<CheckGetResponse> checkGet() async {
    final request = _i2.OpenApiClientRequest('get', '/check', []);
    return await sendRequest(request, {
      '200': (_i2.OpenApiClientResponse response) async =>
          _CheckGetResponse200.response200()
    });
  }

  /// Create new user, or login the user using confirmation email.
  /// post: /user/register
  ///
  @override
  Future<UserRegisterPostResponse> userRegisterPost(
      RegisterRequest body) async {
    final request = _i2.OpenApiClientRequest('post', '/user/register', []);
    request.setHeader('content-type', 'application/json');
    request.setBody(_i2.OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(request, {
      '200': (_i2.OpenApiClientResponse response) async =>
          _UserRegisterPostResponse200.response200(
              RegisterResponse.fromJson(await response.responseBodyJson()))
    });
  }

  /// Get the status of the current auth token (whether it was confirmed or not).
  /// get: /email/status
  ///
  @override
  Future<EmailStatusGetResponse> emailStatusGet() async {
    final request = _i2.OpenApiClientRequest('get', '/email/status', [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    return await sendRequest(request, {
      '200': (_i2.OpenApiClientResponse response) async =>
          _EmailStatusGetResponse200.response200(
              EmailStatusGetResponseBody200.fromJson(
                  await response.responseBodyJson()))
    });
  }

  /// Confirm email address
  /// get: /email/confirm
  ///
  /// * [token]: Unique token which was sent to email address.
  @override
  Future<EmailConfirmGetResponse> emailConfirmGet(
      {@_i3.required String token}) async {
    final request = _i2.OpenApiClientRequest('get', '/email/confirm', []);
    request.addQueryParameter('token', encodeString(token));
    return await sendRequest(request, {
      '200': (_i2.OpenApiClientResponse response) async =>
          _EmailConfirmGetResponse200.response200(
              await response.responseBodyString()),
      '400': (_i2.OpenApiClientResponse response) async =>
          _EmailConfirmGetResponse400.response400()
    });
  }

  /// Confirm with recaptcha
  /// post: /email/confirm
  ///
  @override
  Future<EmailConfirmPostResponse> emailConfirmPost(
      EmailConfirmSchema body) async {
    final request = _i2.OpenApiClientRequest('post', '/email/confirm', []);
    request.setHeader('content-type', 'application/x-www-form-urlencoded');
    request.setBody(_i2.OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(request, {
      '200': (_i2.OpenApiClientResponse response) async =>
          _EmailConfirmPostResponse200.response200(
              await response.responseBodyString()),
      '400': (_i2.OpenApiClientResponse response) async =>
          _EmailConfirmPostResponse400.response400()
    });
  }

  /// Creates a new (random) email address mailbox.
  /// post: /mailbox/create
  ///
  @override
  Future<MailboxCreatePostResponse> mailboxCreatePost(
      MailboxCreateSchema body) async {
    final request = _i2.OpenApiClientRequest('post', '/mailbox/create', [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.setHeader('content-type', 'application/json');
    request.setBody(_i2.OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(request, {
      '200': (_i2.OpenApiClientResponse response) async =>
          _MailboxCreatePostResponse200.response200(
              MailboxCreatePostResponseBody200.fromJson(
                  await response.responseBodyJson()))
    });
  }

  /// Receive emails throw smtp bridge.
  /// post: /email/receive
  ///
  /// * [xAuthpassToken]: Security token to validate origin from trusted server
  /// [body]: Email content (header and body)
  @override
  Future<EmailReceivePostResponse> emailReceivePost(String body,
      {@_i3.required String xAuthpassToken}) async {
    final request = _i2.OpenApiClientRequest('post', '/email/receive', []);
    request.addHeaderParameter(
        'x-authpass-token', encodeString(xAuthpassToken));
    request.setHeader('content-type', 'text/plain');
    request.setBody(_i2.OpenApiClientRequestBodyText(body));
    return await sendRequest(request, {
      '200': (_i2.OpenApiClientResponse response) async =>
          _EmailReceivePostResponse200.response200(),
      '403': (_i2.OpenApiClientResponse response) async =>
          _EmailReceivePostResponse403.response403(
              await response.responseBodyString())
    });
  }
}

class AuthPassCloudUrlResolve with _i2.OpenApiUrlEncodeMixin {
  /// Health check.
  /// get: /check
  ///
  _i2.OpenApiClientRequest checkGet() {
    final request = _i2.OpenApiClientRequest('get', '/check', []);
    return request;
  }

  /// Create new user, or login the user using confirmation email.
  /// post: /user/register
  ///
  _i2.OpenApiClientRequest userRegisterPost() {
    final request = _i2.OpenApiClientRequest('post', '/user/register', []);
    return request;
  }

  /// Get the status of the current auth token (whether it was confirmed or not).
  /// get: /email/status
  ///
  _i2.OpenApiClientRequest emailStatusGet() {
    final request = _i2.OpenApiClientRequest('get', '/email/status', [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    return request;
  }

  /// Confirm email address
  /// get: /email/confirm
  ///
  /// * [token]: Unique token which was sent to email address.
  _i2.OpenApiClientRequest emailConfirmGet({@_i3.required String token}) {
    final request = _i2.OpenApiClientRequest('get', '/email/confirm', []);
    request.addQueryParameter('token', encodeString(token));
    return request;
  }

  /// Confirm with recaptcha
  /// post: /email/confirm
  ///
  _i2.OpenApiClientRequest emailConfirmPost() {
    final request = _i2.OpenApiClientRequest('post', '/email/confirm', []);
    return request;
  }

  /// Creates a new (random) email address mailbox.
  /// post: /mailbox/create
  ///
  _i2.OpenApiClientRequest mailboxCreatePost() {
    final request = _i2.OpenApiClientRequest('post', '/mailbox/create', [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    return request;
  }

  /// Receive emails throw smtp bridge.
  /// post: /email/receive
  ///
  /// * [xAuthpassToken]: Security token to validate origin from trusted server
  _i2.OpenApiClientRequest emailReceivePost(
      {@_i3.required String xAuthpassToken}) {
    final request = _i2.OpenApiClientRequest('post', '/email/receive', []);
    request.addHeaderParameter(
        'x-authpass-token', encodeString(xAuthpassToken));
    return request;
  }
}

class AuthPassCloudRouter extends _i2.OpenApiServerRouterBase {
  AuthPassCloudRouter(this.impl);

  final _i2.ApiEndpointProvider<AuthPassCloud> impl;

  @override
  void configure() {
    addRoute('/check', 'get', (_i2.OpenApiRequest request) async {
      return await impl.invoke(
          request, (AuthPassCloud impl) async => impl.checkGet());
    }, security: []);
    addRoute('/user/register', 'post', (_i2.OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.userRegisterPost(
              RegisterRequest.fromJson(await request.readJsonBody())));
    }, security: []);
    addRoute('/email/status', 'get', (_i2.OpenApiRequest request) async {
      return await impl.invoke(
          request, (AuthPassCloud impl) async => impl.emailStatusGet());
    }, security: [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    addRoute('/email/confirm', 'get', (_i2.OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.emailConfirmGet(
              token: paramToString(request.queryParameter('token'))));
    }, security: []);
    addRoute('/email/confirm', 'post', (_i2.OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.emailConfirmPost(
              EmailConfirmSchema.fromJson(
                  await request.readUrlEncodedBodyFlat())));
    }, security: []);
    addRoute('/mailbox/create', 'post', (_i2.OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailboxCreatePost(
              MailboxCreateSchema.fromJson(await request.readJsonBody())));
    }, security: [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    addRoute('/email/receive', 'post', (_i2.OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.emailReceivePost(
              await request.readBodyString(),
              xAuthpassToken:
                  paramToString(request.headerParameter('x-authpass-token'))));
    }, security: []);
  }
}

class SecuritySchemes {
  static final authToken =
      _i2.SecuritySchemeHttp(scheme: _i2.SecuritySchemeHttpScheme.bearer);
}
