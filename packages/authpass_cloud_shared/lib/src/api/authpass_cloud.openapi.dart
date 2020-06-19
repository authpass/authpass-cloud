// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_initializing_formals

import 'package:json_annotation/json_annotation.dart' as _i1;
import 'package:meta/meta.dart' as _i3;
import 'package:openapi_base/openapi_base.dart' as _i2;
part 'authpass_cloud.openapi.g.dart';

///
@_i1.JsonSerializable()
class RegisterRequest {
  RegisterRequest({this.email});

  factory RegisterRequest.fromJson(Map<String, dynamic> jsonMap) =>
      _$RegisterRequestFromJson(jsonMap);

  /// Email address for the current user.
  final String email;

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}

///
@_i1.JsonSerializable()
class RegisterResponse {
  RegisterResponse({this.userUuid});

  factory RegisterResponse.fromJson(Map<String, dynamic> jsonMap) =>
      _$RegisterResponseFromJson(jsonMap);

  /// Uuid of the newly registered user.
  final String userUuid;

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}

class UserRegisterPostResponse200 extends UserRegisterPostResponse {
  /// OK
  UserRegisterPostResponse200.response200(this.body) : status = 200 {
    bodyJson = body.toJson();
  }

  @override
  final int status;

  final RegisterResponse body;
}

abstract class UserRegisterPostResponse extends _i2.OpenApiResponse {
  UserRegisterPostResponse();

  /// OK
  factory UserRegisterPostResponse.response200(RegisterResponse body) =>
      UserRegisterPostResponse200.response200(body);

  void map({@_i3.required _i2.ResponseMap<UserRegisterPostResponse200> on200}) {
    if (this is UserRegisterPostResponse200) {
      on200((this as UserRegisterPostResponse200));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }
}

class EmailConfirmPutResponse200 extends EmailConfirmPutResponse {
  /// OK
  EmailConfirmPutResponse200.response200() : status = 200;

  @override
  final int status;
}

class EmailConfirmPutResponse400 extends EmailConfirmPutResponse {
  /// Invalid token or email address.
  EmailConfirmPutResponse400.response400() : status = 400;

  @override
  final int status;
}

abstract class EmailConfirmPutResponse extends _i2.OpenApiResponse {
  EmailConfirmPutResponse();

  /// OK
  factory EmailConfirmPutResponse.response200() =>
      EmailConfirmPutResponse200.response200();

  /// Invalid token or email address.
  factory EmailConfirmPutResponse.response400() =>
      EmailConfirmPutResponse400.response400();

  void map(
      {@_i3.required _i2.ResponseMap<EmailConfirmPutResponse200> on200,
      @_i3.required _i2.ResponseMap<EmailConfirmPutResponse400> on400}) {
    if (this is EmailConfirmPutResponse200) {
      on200((this as EmailConfirmPutResponse200));
    } else if (this is EmailConfirmPutResponse400) {
      on400((this as EmailConfirmPutResponse400));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }
}

abstract class AuthPassCloud implements _i2.Service {
  /// Create new user
  /// post: /user/register
  Future<UserRegisterPostResponse> userRegisterPost(
      _i2.OpenApiRequest request, RegisterRequest body);

  /// Confirm email address
  /// put: /email/confirm
  Future<EmailConfirmPutResponse> emailConfirmPut(
      _i2.OpenApiRequest request, String token);
}

abstract class AuthPassCloudClient {
  factory AuthPassCloudClient(
          Uri baseUri, _i2.OpenApiRequestSender requestSender) =>
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

class _AuthPassCloudClientImpl extends _i2.OpenApiClientBase
    implements AuthPassCloudClient {
  _AuthPassCloudClientImpl._(this.baseUri, this.requestSender);

  @override
  final Uri baseUri;

  @override
  final _i2.OpenApiRequestSender requestSender;

  /// Create new user
  /// post: /user/register
  ///
  @override
  Future<UserRegisterPostResponse> userRegisterPost(
      RegisterRequest body) async {
    final request = _i2.OpenApiClientRequest('post', '/user/register');
    request.setJsonBody(body.toJson());
    return await sendRequest(request, {
      '200': (_i2.OpenApiClientResponse response) async =>
          UserRegisterPostResponse200.response200(
              RegisterResponse.fromJson(await response.responseBodyJson()))
    });
  }

  /// Confirm email address
  /// put: /email/confirm
  ///
  /// * [token]: Unique token which was sent to email address.
  @override
  Future<EmailConfirmPutResponse> emailConfirmPut({String token}) async {
    final request = _i2.OpenApiClientRequest('put', '/email/confirm');
    request.addQueryParameter('token', encodeString(token));
    return await sendRequest(request, {
      '200': (_i2.OpenApiClientResponse response) async =>
          EmailConfirmPutResponse200.response200(),
      '400': (_i2.OpenApiClientResponse response) async =>
          EmailConfirmPutResponse400.response400()
    });
  }
}

class AuthPassCloudRouter extends _i2.OpenApiServerRouterBase {
  AuthPassCloudRouter(this.impl);

  final _i2.ServiceProvider<AuthPassCloud> impl;

  void configure() {
    addRoute('/user/register', 'post', (_i2.OpenApiRequest request) async {
      return await impl.invoke((AuthPassCloud impl) async =>
          impl.userRegisterPost(
              request, RegisterRequest.fromJson(await request.readJsonBody())));
    });
    addRoute('/email/confirm', 'put', (_i2.OpenApiRequest request) async {
      return await impl.invoke((AuthPassCloud impl) async =>
          impl.emailConfirmPut(
              request, paramToString(request.queryParameter('token'))));
    });
  }
}
