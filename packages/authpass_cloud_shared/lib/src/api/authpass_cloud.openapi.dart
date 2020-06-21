// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_initializing_formals

import 'package:json_annotation/json_annotation.dart' as _i1;
import 'package:meta/meta.dart' as _i2;
import 'package:openapi_base/openapi_base.dart' as _i3;
part 'authpass_cloud.openapi.g.dart';

///
@_i1.JsonSerializable()
class RegisterRequest {
  RegisterRequest({@_i2.required this.email});

  factory RegisterRequest.fromJson(Map<String, dynamic> jsonMap) =>
      _$RegisterRequestFromJson(jsonMap);

  /// Email address for the current user.
  final String email;

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}

///
@_i1.JsonSerializable()
class RegisterResponse {
  RegisterResponse({@_i2.required this.userUuid});

  factory RegisterResponse.fromJson(Map<String, dynamic> jsonMap) =>
      _$RegisterResponseFromJson(jsonMap);

  /// Uuid of the newly registered user.
  final String userUuid;

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}

class _UserRegisterPostResponse200 extends UserRegisterPostResponse {
  /// OK
  _UserRegisterPostResponse200.response200(this.body) : status = 200 {
    bodyJson = body.toJson();
  }

  @override
  final int status;

  final RegisterResponse body;
}

abstract class UserRegisterPostResponse extends _i3.OpenApiResponse {
  UserRegisterPostResponse();

  /// OK
  factory UserRegisterPostResponse.response200(RegisterResponse body) =>
      _UserRegisterPostResponse200.response200(body);

  void map(
      {@_i2.required _i3.ResponseMap<_UserRegisterPostResponse200> on200}) {
    if (this is _UserRegisterPostResponse200) {
      on200((this as _UserRegisterPostResponse200));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }
}

class _EmailConfirmPutResponse200 extends EmailConfirmPutResponse {
  /// OK
  _EmailConfirmPutResponse200.response200() : status = 200;

  @override
  final int status;
}

class _EmailConfirmPutResponse400 extends EmailConfirmPutResponse {
  /// Invalid token or email address.
  _EmailConfirmPutResponse400.response400() : status = 400;

  @override
  final int status;
}

abstract class EmailConfirmPutResponse extends _i3.OpenApiResponse {
  EmailConfirmPutResponse();

  /// OK
  factory EmailConfirmPutResponse.response200() =>
      _EmailConfirmPutResponse200.response200();

  /// Invalid token or email address.
  factory EmailConfirmPutResponse.response400() =>
      _EmailConfirmPutResponse400.response400();

  void map(
      {@_i2.required _i3.ResponseMap<_EmailConfirmPutResponse200> on200,
      @_i2.required _i3.ResponseMap<_EmailConfirmPutResponse400> on400}) {
    if (this is _EmailConfirmPutResponse200) {
      on200((this as _EmailConfirmPutResponse200));
    } else if (this is _EmailConfirmPutResponse400) {
      on400((this as _EmailConfirmPutResponse400));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }
}

abstract class AuthPassCloud implements _i3.ApiEndpoint {
  /// Create new user
  /// post: /user/register
  Future<UserRegisterPostResponse> userRegisterPost(RegisterRequest body);

  /// Confirm email address
  /// put: /email/confirm
  Future<EmailConfirmPutResponse> emailConfirmPut(String token);
}

abstract class AuthPassCloudClient {
  factory AuthPassCloudClient(
          Uri baseUri, _i3.OpenApiRequestSender requestSender) =>
      _AuthPassCloudClientImpl._(baseUri, requestSender);

  /// Create new user
  /// post: /user/register
  ///
  Future<UserRegisterPostResponse> userRegisterPost(RegisterRequest body);

  /// Confirm email address
  /// put: /email/confirm
  ///
  /// * [token]: Unique token which was sent to email address.
  Future<EmailConfirmPutResponse> emailConfirmPut({String token});
}

class _AuthPassCloudClientImpl extends _i3.OpenApiClientBase
    implements AuthPassCloudClient {
  _AuthPassCloudClientImpl._(this.baseUri, this.requestSender);

  @override
  final Uri baseUri;

  @override
  final _i3.OpenApiRequestSender requestSender;

  /// Create new user
  /// post: /user/register
  ///
  @override
  Future<UserRegisterPostResponse> userRegisterPost(
      RegisterRequest body) async {
    final request = _i3.OpenApiClientRequest('post', '/user/register');
    request.setJsonBody(body.toJson());
    return await sendRequest(request, {
      '200': (_i3.OpenApiClientResponse response) async =>
          _UserRegisterPostResponse200.response200(
              RegisterResponse.fromJson(await response.responseBodyJson()))
    });
  }

  /// Confirm email address
  /// put: /email/confirm
  ///
  /// * [token]: Unique token which was sent to email address.
  @override
  Future<EmailConfirmPutResponse> emailConfirmPut({String token}) async {
    final request = _i3.OpenApiClientRequest('put', '/email/confirm');
    request.addQueryParameter('token', encodeString(token));
    return await sendRequest(request, {
      '200': (_i3.OpenApiClientResponse response) async =>
          _EmailConfirmPutResponse200.response200(),
      '400': (_i3.OpenApiClientResponse response) async =>
          _EmailConfirmPutResponse400.response400()
    });
  }
}

class AuthPassCloudRouter extends _i3.OpenApiServerRouterBase {
  AuthPassCloudRouter(this.impl);

  final _i3.ApiEndpointProvider<AuthPassCloud> impl;

  void configure() {
    addRoute('/user/register', 'post', (_i3.OpenApiRequest request) async {
      return await impl.invoke((AuthPassCloud impl) async =>
          impl.userRegisterPost(
              RegisterRequest.fromJson(await request.readJsonBody())));
    });
    addRoute('/email/confirm', 'put', (_i3.OpenApiRequest request) async {
      return await impl.invoke((AuthPassCloud impl) async =>
          impl.emailConfirmPut(paramToString(request.queryParameter('token'))));
    });
  }
}
