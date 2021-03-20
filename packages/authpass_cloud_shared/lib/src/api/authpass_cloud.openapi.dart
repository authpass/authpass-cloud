// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_initializing_formals

import 'dart:typed_data' as _i2;

import 'package:json_annotation/json_annotation.dart' as _i1;
import 'package:openapi_base/openapi_base.dart';
part 'authpass_cloud.openapi.g.dart';

@_i1.JsonSerializable()
class SystemStatusUser implements OpenApiContent {
  SystemStatusUser(
      {required this.emailConfirmed,
      required this.userConfirmed,
      required this.emailUnconfirmed});

  factory SystemStatusUser.fromJson(Map<String, dynamic> jsonMap) =>
      _$SystemStatusUserFromJson(jsonMap);

  @_i1.JsonKey(name: 'emailConfirmed')
  final int emailConfirmed;

  @_i1.JsonKey(name: 'userConfirmed')
  final int userConfirmed;

  @_i1.JsonKey(name: 'emailUnconfirmed')
  final int emailUnconfirmed;

  Map<String, dynamic> toJson() => _$SystemStatusUserToJson(this);
  @override
  String toString() => toJson().toString();
}

@_i1.JsonSerializable()
class SystemStatusWebsite implements OpenApiContent {
  SystemStatusWebsite(
      {required this.websiteCount, required this.urlCanonicalCount});

  factory SystemStatusWebsite.fromJson(Map<String, dynamic> jsonMap) =>
      _$SystemStatusWebsiteFromJson(jsonMap);

  @_i1.JsonKey(name: 'websiteCount')
  final int websiteCount;

  @_i1.JsonKey(name: 'urlCanonicalCount')
  final int urlCanonicalCount;

  Map<String, dynamic> toJson() => _$SystemStatusWebsiteToJson(this);
  @override
  String toString() => toJson().toString();
}

@_i1.JsonSerializable()
class SystemStatusMailbox implements OpenApiContent {
  SystemStatusMailbox(
      {required this.mailboxCount,
      required this.messageCount,
      required this.messageReadCount});

  factory SystemStatusMailbox.fromJson(Map<String, dynamic> jsonMap) =>
      _$SystemStatusMailboxFromJson(jsonMap);

  @_i1.JsonKey(name: 'mailboxCount')
  final int mailboxCount;

  @_i1.JsonKey(name: 'messageCount')
  final int messageCount;

  @_i1.JsonKey(name: 'messageReadCount')
  final int messageReadCount;

  Map<String, dynamic> toJson() => _$SystemStatusMailboxToJson(this);
  @override
  String toString() => toJson().toString();
}

@_i1.JsonSerializable()
class SystemStatus implements OpenApiContent {
  SystemStatus(
      {required this.user,
      required this.website,
      required this.mailbox,
      required this.queryTime});

  factory SystemStatus.fromJson(Map<String, dynamic> jsonMap) =>
      _$SystemStatusFromJson(jsonMap);

  @_i1.JsonKey(name: 'user')
  final SystemStatusUser user;

  @_i1.JsonKey(name: 'website')
  final SystemStatusWebsite website;

  @_i1.JsonKey(name: 'mailbox')
  final SystemStatusMailbox mailbox;

  @_i1.JsonKey(name: 'queryTime')
  final int queryTime;

  Map<String, dynamic> toJson() => _$SystemStatusToJson(this);
  @override
  String toString() => toJson().toString();
}

@_i1.JsonSerializable()
class UserEmail implements OpenApiContent {
  UserEmail({required this.address, required this.confirmedAt});

  factory UserEmail.fromJson(Map<String, dynamic> jsonMap) =>
      _$UserEmailFromJson(jsonMap);

  @_i1.JsonKey(name: 'address')
  final String address;

  @_i1.JsonKey(name: 'confirmedAt')
  final DateTime confirmedAt;

  Map<String, dynamic> toJson() => _$UserEmailToJson(this);
  @override
  String toString() => toJson().toString();
}

@_i1.JsonSerializable()
class UserInfo implements OpenApiContent {
  UserInfo({this.emails});

  factory UserInfo.fromJson(Map<String, dynamic> jsonMap) =>
      _$UserInfoFromJson(jsonMap);

  @_i1.JsonKey(name: 'emails')
  final List<UserEmail>? emails;

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
  @override
  String toString() => toJson().toString();
}

@_i1.JsonSerializable()
class RegisterRequest implements OpenApiContent {
  RegisterRequest({required this.email});

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
  static RegisterResponseStatus fromName(String name) =>
      _names[name] ??
      _throwStateError('Invalid enum name: $name for RegisterResponseStatus');
  String get name => toString().substring(23);
}

@_i1.JsonSerializable()
class RegisterResponse implements OpenApiContent {
  RegisterResponse(
      {required this.userUuid, required this.authToken, required this.status});

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

@_i1.JsonSerializable()
class Page implements OpenApiContent {
  Page({this.nextPageToken, this.sinceToken});

  factory Page.fromJson(Map<String, dynamic> jsonMap) =>
      _$PageFromJson(jsonMap);

  /// Token for the next page, might be null if there are no more pages.
  @_i1.JsonKey(name: 'nextPageToken')
  final String? nextPageToken;

  /// Once everything is synced, this token can be used for subsequent syncs.
  @_i1.JsonKey(name: 'sinceToken')
  final String? sinceToken;

  Map<String, dynamic> toJson() => _$PageToJson(this);
  @override
  String toString() => toJson().toString();
}

@_i1.JsonSerializable()
class EmailMessage implements OpenApiContent {
  EmailMessage(
      {required this.id,
      required this.subject,
      required this.sender,
      required this.mailboxEntryUuid,
      required this.createdAt,
      required this.size,
      required this.isRead});

  factory EmailMessage.fromJson(Map<String, dynamic> jsonMap) =>
      _$EmailMessageFromJson(jsonMap);

  @_i1.JsonKey(name: 'id')
  @ApiUuidJsonConverter()
  final ApiUuid id;

  @_i1.JsonKey(name: 'subject')
  final String subject;

  @_i1.JsonKey(name: 'sender')
  final String sender;

  @_i1.JsonKey(name: 'mailboxEntryUuid')
  @ApiUuidJsonConverter()
  final ApiUuid mailboxEntryUuid;

  @_i1.JsonKey(name: 'createdAt')
  final DateTime createdAt;

  /// Body size in bytes.
  @_i1.JsonKey(name: 'size')
  final int size;

  /// true if this mail was marked as read.
  @_i1.JsonKey(name: 'isRead')
  final bool isRead;

  Map<String, dynamic> toJson() => _$EmailMessageToJson(this);
  @override
  String toString() => toJson().toString();
}

@_i1.JsonSerializable()
class Mailbox implements OpenApiContent {
  Mailbox(
      {required this.id,
      required this.address,
      required this.label,
      required this.entryUuid,
      required this.createdAt,
      required this.isDisabled});

  factory Mailbox.fromJson(Map<String, dynamic> jsonMap) =>
      _$MailboxFromJson(jsonMap);

  @_i1.JsonKey(name: 'id')
  @ApiUuidJsonConverter()
  final ApiUuid id;

  /// Unique email address (a@example.com)
  @_i1.JsonKey(name: 'address')
  final String address;

  /// Label as given during create. (Can be empty string)
  @_i1.JsonKey(name: 'label')
  final String label;

  /// Entry uuid given during create. (Can be empty string)
  @_i1.JsonKey(name: 'entryUuid')
  final String entryUuid;

  @_i1.JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @_i1.JsonKey(name: 'isDisabled')
  final bool isDisabled;

  Map<String, dynamic> toJson() => _$MailboxToJson(this);
  @override
  String toString() => toJson().toString();
}

class _CheckGetResponse200 extends CheckGetResponse {
  /// Everything OK
  _CheckGetResponse200.response200() : status = 200;

  @override
  final int status;

  @override
  final OpenApiContentType? contentType = null;

  @override
  Map<String, Object?> propertiesToString() =>
      {'status': status, 'contentType': contentType};
}

abstract class CheckGetResponse extends OpenApiResponse
    implements HasSuccessResponse<void> {
  CheckGetResponse();

  /// Everything OK
  factory CheckGetResponse.response200() => _CheckGetResponse200.response200();

  void map({required ResponseMap<_CheckGetResponse200> on200}) {
    if (this is _CheckGetResponse200) {
      on200((this as _CheckGetResponse200));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }

  /// status 200:  Everything OK
  @override
  void requireSuccess() {
    if (this is _CheckGetResponse200) {
      return;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class _CheckStatusPostResponse200 extends CheckStatusPostResponse
    implements OpenApiResponseBodyJson {
  /// Status
  _CheckStatusPostResponse200.response200(this.body)
      : status = 200,
        bodyJson = body.toJson();

  @override
  final int status;

  final SystemStatus body;

  @override
  final Map<String, dynamic> bodyJson;

  @override
  final OpenApiContentType contentType =
      OpenApiContentType.parse('application/json');

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'body': body,
        'bodyJson': bodyJson,
        'contentType': contentType
      };
}

abstract class CheckStatusPostResponse extends OpenApiResponse
    implements HasSuccessResponse<SystemStatus> {
  CheckStatusPostResponse();

  /// Status
  factory CheckStatusPostResponse.response200(SystemStatus body) =>
      _CheckStatusPostResponse200.response200(body);

  void map({required ResponseMap<_CheckStatusPostResponse200> on200}) {
    if (this is _CheckStatusPostResponse200) {
      on200((this as _CheckStatusPostResponse200));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }

  /// status 200:  Status
  @override
  SystemStatus requireSuccess() {
    if (this is _CheckStatusPostResponse200) {
      return (this as _CheckStatusPostResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class _UserGetResponse200 extends UserGetResponse
    implements OpenApiResponseBodyJson {
  /// OK
  _UserGetResponse200.response200(this.body)
      : status = 200,
        bodyJson = body.toJson();

  @override
  final int status;

  final UserInfo body;

  @override
  final Map<String, dynamic> bodyJson;

  @override
  final OpenApiContentType contentType =
      OpenApiContentType.parse('application/json');

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'body': body,
        'bodyJson': bodyJson,
        'contentType': contentType
      };
}

abstract class UserGetResponse extends OpenApiResponse
    implements HasSuccessResponse<UserInfo> {
  UserGetResponse();

  /// OK
  factory UserGetResponse.response200(UserInfo body) =>
      _UserGetResponse200.response200(body);

  void map({required ResponseMap<_UserGetResponse200> on200}) {
    if (this is _UserGetResponse200) {
      on200((this as _UserGetResponse200));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }

  /// status 200:  OK
  @override
  UserInfo requireSuccess() {
    if (this is _UserGetResponse200) {
      return (this as _UserGetResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class _UserRegisterPostResponse200 extends UserRegisterPostResponse
    implements OpenApiResponseBodyJson {
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
  final OpenApiContentType contentType =
      OpenApiContentType.parse('application/json');

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'body': body,
        'bodyJson': bodyJson,
        'contentType': contentType
      };
}

abstract class UserRegisterPostResponse extends OpenApiResponse
    implements HasSuccessResponse<RegisterResponse> {
  UserRegisterPostResponse();

  /// OK
  factory UserRegisterPostResponse.response200(RegisterResponse body) =>
      _UserRegisterPostResponse200.response200(body);

  void map({required ResponseMap<_UserRegisterPostResponse200> on200}) {
    if (this is _UserRegisterPostResponse200) {
      on200((this as _UserRegisterPostResponse200));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }

  /// status 200:  OK
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
      _names[name] ??
      _throwStateError(
          'Invalid enum name: $name for EmailStatusGetResponseBody200Status');
  String get name => toString().substring(36);
}

@_i1.JsonSerializable()
class EmailStatusGetResponseBody200 implements OpenApiContent {
  EmailStatusGetResponseBody200({this.status});

  factory EmailStatusGetResponseBody200.fromJson(
          Map<String, dynamic> jsonMap) =>
      _$EmailStatusGetResponseBody200FromJson(jsonMap);

  @_i1.JsonKey(name: 'status')
  final EmailStatusGetResponseBody200Status? status;

  Map<String, dynamic> toJson() => _$EmailStatusGetResponseBody200ToJson(this);
  @override
  String toString() => toJson().toString();
}

class _EmailStatusGetResponse200 extends EmailStatusGetResponse
    implements OpenApiResponseBodyJson {
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
  final OpenApiContentType contentType =
      OpenApiContentType.parse('application/json');

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'body': body,
        'bodyJson': bodyJson,
        'contentType': contentType
      };
}

abstract class EmailStatusGetResponse extends OpenApiResponse
    implements HasSuccessResponse<EmailStatusGetResponseBody200> {
  EmailStatusGetResponse();

  /// Whether it was confirmed or not.
  factory EmailStatusGetResponse.response200(
          EmailStatusGetResponseBody200 body) =>
      _EmailStatusGetResponse200.response200(body);

  void map({required ResponseMap<_EmailStatusGetResponse200> on200}) {
    if (this is _EmailStatusGetResponse200) {
      on200((this as _EmailStatusGetResponse200));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }

  /// status 200:  Whether it was confirmed or not.
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
    implements OpenApiResponseBodyString {
  /// OK
  _EmailConfirmGetResponse200.response200(this.body) : status = 200;

  @override
  final int status;

  @override
  final String body;

  @override
  final OpenApiContentType contentType = OpenApiContentType.parse('text/html');

  @override
  Map<String, Object?> propertiesToString() =>
      {'status': status, 'body': body, 'contentType': contentType};
}

class _EmailConfirmGetResponse400 extends EmailConfirmGetResponse {
  /// Invalid token or email address.
  _EmailConfirmGetResponse400.response400() : status = 400;

  @override
  final int status;

  @override
  final OpenApiContentType? contentType = null;

  @override
  Map<String, Object?> propertiesToString() =>
      {'status': status, 'contentType': contentType};
}

abstract class EmailConfirmGetResponse extends OpenApiResponse
    implements HasSuccessResponse<String> {
  EmailConfirmGetResponse();

  /// OK
  factory EmailConfirmGetResponse.response200(String body) =>
      _EmailConfirmGetResponse200.response200(body);

  /// Invalid token or email address.
  factory EmailConfirmGetResponse.response400() =>
      _EmailConfirmGetResponse400.response400();

  void map(
      {required ResponseMap<_EmailConfirmGetResponse200> on200,
      required ResponseMap<_EmailConfirmGetResponse400> on400}) {
    if (this is _EmailConfirmGetResponse200) {
      on200((this as _EmailConfirmGetResponse200));
    } else if (this is _EmailConfirmGetResponse400) {
      on400((this as _EmailConfirmGetResponse400));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }

  /// status 200:  OK
  @override
  String requireSuccess() {
    if (this is _EmailConfirmGetResponse200) {
      return (this as _EmailConfirmGetResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class _EmailConfirmPostResponse200 extends EmailConfirmPostResponse
    implements OpenApiResponseBodyString {
  /// OK
  _EmailConfirmPostResponse200.response200(this.body) : status = 200;

  @override
  final int status;

  @override
  final String body;

  @override
  final OpenApiContentType contentType = OpenApiContentType.parse('text/html');

  @override
  Map<String, Object?> propertiesToString() =>
      {'status': status, 'body': body, 'contentType': contentType};
}

class _EmailConfirmPostResponse400 extends EmailConfirmPostResponse {
  /// Invalid token or email address.
  _EmailConfirmPostResponse400.response400() : status = 400;

  @override
  final int status;

  @override
  final OpenApiContentType? contentType = null;

  @override
  Map<String, Object?> propertiesToString() =>
      {'status': status, 'contentType': contentType};
}

abstract class EmailConfirmPostResponse extends OpenApiResponse
    implements HasSuccessResponse<String> {
  EmailConfirmPostResponse();

  /// OK
  factory EmailConfirmPostResponse.response200(String body) =>
      _EmailConfirmPostResponse200.response200(body);

  /// Invalid token or email address.
  factory EmailConfirmPostResponse.response400() =>
      _EmailConfirmPostResponse400.response400();

  void map(
      {required ResponseMap<_EmailConfirmPostResponse200> on200,
      required ResponseMap<_EmailConfirmPostResponse400> on400}) {
    if (this is _EmailConfirmPostResponse200) {
      on200((this as _EmailConfirmPostResponse200));
    } else if (this is _EmailConfirmPostResponse400) {
      on400((this as _EmailConfirmPostResponse400));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }

  /// status 200:  OK
  @override
  String requireSuccess() {
    if (this is _EmailConfirmPostResponse200) {
      return (this as _EmailConfirmPostResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

@_i1.JsonSerializable()
class EmailConfirmPostSchema implements OpenApiContent {
  EmailConfirmPostSchema(
      {required this.token, required this.gRecaptchaResponse});

  factory EmailConfirmPostSchema.fromJson(Map<String, dynamic> jsonMap) =>
      _$EmailConfirmPostSchemaFromJson(jsonMap);

  @_i1.JsonKey(name: 'token')
  final String token;

  @_i1.JsonKey(name: 'g-recaptcha-response')
  final String gRecaptchaResponse;

  Map<String, dynamic> toJson() => _$EmailConfirmPostSchemaToJson(this);
  @override
  String toString() => toJson().toString();
}

@_i1.JsonSerializable()
class StatusGetResponseBody200Mail implements OpenApiContent {
  StatusGetResponseBody200Mail({required this.messagesUnread});

  factory StatusGetResponseBody200Mail.fromJson(Map<String, dynamic> jsonMap) =>
      _$StatusGetResponseBody200MailFromJson(jsonMap);

  @_i1.JsonKey(name: 'messagesUnread')
  final int messagesUnread;

  Map<String, dynamic> toJson() => _$StatusGetResponseBody200MailToJson(this);
  @override
  String toString() => toJson().toString();
}

@_i1.JsonSerializable()
class StatusGetResponseBody200 implements OpenApiContent {
  StatusGetResponseBody200({required this.mail});

  factory StatusGetResponseBody200.fromJson(Map<String, dynamic> jsonMap) =>
      _$StatusGetResponseBody200FromJson(jsonMap);

  @_i1.JsonKey(name: 'mail')
  final StatusGetResponseBody200Mail mail;

  Map<String, dynamic> toJson() => _$StatusGetResponseBody200ToJson(this);
  @override
  String toString() => toJson().toString();
}

class _StatusGetResponse200 extends StatusGetResponse
    implements OpenApiResponseBodyJson {
  /// Information of the logged in account.
  _StatusGetResponse200.response200(this.body)
      : status = 200,
        bodyJson = body.toJson();

  @override
  final int status;

  final StatusGetResponseBody200 body;

  @override
  final Map<String, dynamic> bodyJson;

  @override
  final OpenApiContentType contentType =
      OpenApiContentType.parse('application/json');

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'body': body,
        'bodyJson': bodyJson,
        'contentType': contentType
      };
}

abstract class StatusGetResponse extends OpenApiResponse
    implements HasSuccessResponse<StatusGetResponseBody200> {
  StatusGetResponse();

  /// Information of the logged in account.
  factory StatusGetResponse.response200(StatusGetResponseBody200 body) =>
      _StatusGetResponse200.response200(body);

  void map({required ResponseMap<_StatusGetResponse200> on200}) {
    if (this is _StatusGetResponse200) {
      on200((this as _StatusGetResponse200));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }

  /// status 200:  Information of the logged in account.
  @override
  StatusGetResponseBody200 requireSuccess() {
    if (this is _StatusGetResponse200) {
      return (this as _StatusGetResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

@_i1.JsonSerializable()
class MailboxGetResponseBody200 implements OpenApiContent {
  MailboxGetResponseBody200({this.data});

  factory MailboxGetResponseBody200.fromJson(Map<String, dynamic> jsonMap) =>
      _$MailboxGetResponseBody200FromJson(jsonMap);

  @_i1.JsonKey(name: 'data')
  final List<Mailbox>? data;

  Map<String, dynamic> toJson() => _$MailboxGetResponseBody200ToJson(this);
  @override
  String toString() => toJson().toString();
}

class _MailboxGetResponse200 extends MailboxGetResponse
    implements OpenApiResponseBodyJson {
  /// On Success returns unpaginated list (right now) of all mailboxes.
  _MailboxGetResponse200.response200(this.body)
      : status = 200,
        bodyJson = body.toJson();

  @override
  final int status;

  final MailboxGetResponseBody200 body;

  @override
  final Map<String, dynamic> bodyJson;

  @override
  final OpenApiContentType contentType =
      OpenApiContentType.parse('application/json');

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'body': body,
        'bodyJson': bodyJson,
        'contentType': contentType
      };
}

abstract class MailboxGetResponse extends OpenApiResponse
    implements HasSuccessResponse<MailboxGetResponseBody200> {
  MailboxGetResponse();

  /// On Success returns unpaginated list (right now) of all mailboxes.
  factory MailboxGetResponse.response200(MailboxGetResponseBody200 body) =>
      _MailboxGetResponse200.response200(body);

  void map({required ResponseMap<_MailboxGetResponse200> on200}) {
    if (this is _MailboxGetResponse200) {
      on200((this as _MailboxGetResponse200));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }

  /// status 200:  On Success returns unpaginated list (right now) of all mailboxes.
  @override
  MailboxGetResponseBody200 requireSuccess() {
    if (this is _MailboxGetResponse200) {
      return (this as _MailboxGetResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

@_i1.JsonSerializable()
class MailboxCreatePostResponseBody200 implements OpenApiContent {
  MailboxCreatePostResponseBody200({this.address});

  factory MailboxCreatePostResponseBody200.fromJson(
          Map<String, dynamic> jsonMap) =>
      _$MailboxCreatePostResponseBody200FromJson(jsonMap);

  /// The address of the new mailbox.
  @_i1.JsonKey(name: 'address')
  final String? address;

  Map<String, dynamic> toJson() =>
      _$MailboxCreatePostResponseBody200ToJson(this);
  @override
  String toString() => toJson().toString();
}

class _MailboxCreatePostResponse200 extends MailboxCreatePostResponse
    implements OpenApiResponseBodyJson {
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
  final OpenApiContentType contentType =
      OpenApiContentType.parse('application/json');

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'body': body,
        'bodyJson': bodyJson,
        'contentType': contentType
      };
}

abstract class MailboxCreatePostResponse extends OpenApiResponse
    implements HasSuccessResponse<MailboxCreatePostResponseBody200> {
  MailboxCreatePostResponse();

  /// Successfully created mailbox.
  factory MailboxCreatePostResponse.response200(
          MailboxCreatePostResponseBody200 body) =>
      _MailboxCreatePostResponse200.response200(body);

  void map({required ResponseMap<_MailboxCreatePostResponse200> on200}) {
    if (this is _MailboxCreatePostResponse200) {
      on200((this as _MailboxCreatePostResponse200));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }

  /// status 200:  Successfully created mailbox.
  @override
  MailboxCreatePostResponseBody200 requireSuccess() {
    if (this is _MailboxCreatePostResponse200) {
      return (this as _MailboxCreatePostResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

@_i1.JsonSerializable()
class MailboxCreatePostSchema implements OpenApiContent {
  MailboxCreatePostSchema({required this.label, required this.entryUuid});

  factory MailboxCreatePostSchema.fromJson(Map<String, dynamic> jsonMap) =>
      _$MailboxCreatePostSchemaFromJson(jsonMap);

  /// label for this mailbox, can be an empty string.
  @_i1.JsonKey(name: 'label')
  final String label;

  /// Client provided entry uuid to match with password entry, can be an empty string.
  @_i1.JsonKey(name: 'entryUuid')
  final String entryUuid;

  Map<String, dynamic> toJson() => _$MailboxCreatePostSchemaToJson(this);
  @override
  String toString() => toJson().toString();
}

@_i1.JsonSerializable()
class MailboxListGetResponseBody200 implements OpenApiContent {
  MailboxListGetResponseBody200({required this.page, required this.data});

  factory MailboxListGetResponseBody200.fromJson(
          Map<String, dynamic> jsonMap) =>
      _$MailboxListGetResponseBody200FromJson(jsonMap);

  @_i1.JsonKey(name: 'page')
  final Page page;

  @_i1.JsonKey(name: 'data')
  final List<EmailMessage> data;

  Map<String, dynamic> toJson() => _$MailboxListGetResponseBody200ToJson(this);
  @override
  String toString() => toJson().toString();
}

class _MailboxListGetResponse200 extends MailboxListGetResponse
    implements OpenApiResponseBodyJson {
  /// Successful list
  _MailboxListGetResponse200.response200(this.body)
      : status = 200,
        bodyJson = body.toJson();

  @override
  final int status;

  final MailboxListGetResponseBody200 body;

  @override
  final Map<String, dynamic> bodyJson;

  @override
  final OpenApiContentType contentType =
      OpenApiContentType.parse('application/json');

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'body': body,
        'bodyJson': bodyJson,
        'contentType': contentType
      };
}

abstract class MailboxListGetResponse extends OpenApiResponse
    implements HasSuccessResponse<MailboxListGetResponseBody200> {
  MailboxListGetResponse();

  /// Successful list
  factory MailboxListGetResponse.response200(
          MailboxListGetResponseBody200 body) =>
      _MailboxListGetResponse200.response200(body);

  void map({required ResponseMap<_MailboxListGetResponse200> on200}) {
    if (this is _MailboxListGetResponse200) {
      on200((this as _MailboxListGetResponse200));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }

  /// status 200:  Successful list
  @override
  MailboxListGetResponseBody200 requireSuccess() {
    if (this is _MailboxListGetResponse200) {
      return (this as _MailboxListGetResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class _MailMassupdatePostResponse200 extends MailMassupdatePostResponse {
  /// Update finished.
  _MailMassupdatePostResponse200.response200() : status = 200;

  @override
  final int status;

  @override
  final OpenApiContentType? contentType = null;

  @override
  Map<String, Object?> propertiesToString() =>
      {'status': status, 'contentType': contentType};
}

abstract class MailMassupdatePostResponse extends OpenApiResponse
    implements HasSuccessResponse<void> {
  MailMassupdatePostResponse();

  /// Update finished.
  factory MailMassupdatePostResponse.response200() =>
      _MailMassupdatePostResponse200.response200();

  void map({required ResponseMap<_MailMassupdatePostResponse200> on200}) {
    if (this is _MailMassupdatePostResponse200) {
      on200((this as _MailMassupdatePostResponse200));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }

  /// status 200:  Update finished.
  @override
  void requireSuccess() {
    if (this is _MailMassupdatePostResponse200) {
      return;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

enum MailMassupdatePostSchemaFilter {
  @_i1.JsonValue('messageIds')
  messageIds,
  @_i1.JsonValue('all')
  all,
}

extension MailMassupdatePostSchemaFilterExt on MailMassupdatePostSchemaFilter {
  static final Map<String, MailMassupdatePostSchemaFilter> _names = {
    'messageIds': MailMassupdatePostSchemaFilter.messageIds,
    'all': MailMassupdatePostSchemaFilter.all
  };
  static MailMassupdatePostSchemaFilter fromName(String name) =>
      _names[name] ??
      _throwStateError(
          'Invalid enum name: $name for MailMassupdatePostSchemaFilter');
  String get name => toString().substring(31);
}

@_i1.JsonSerializable()
class MailMassupdatePostSchema implements OpenApiContent {
  MailMassupdatePostSchema(
      {required this.filter, this.messageIds, this.isRead});

  factory MailMassupdatePostSchema.fromJson(Map<String, dynamic> jsonMap) =>
      _$MailMassupdatePostSchemaFromJson(jsonMap);

  @_i1.JsonKey(name: 'filter')
  final MailMassupdatePostSchemaFilter filter;

  /// Only used if filter=messageIds
  @_i1.JsonKey(name: 'messageIds')
  final List<String>? messageIds;

  @_i1.JsonKey(name: 'isRead')
  final bool? isRead;

  Map<String, dynamic> toJson() => _$MailMassupdatePostSchemaToJson(this);
  @override
  String toString() => toJson().toString();
}

class _MailboxUpdateResponse200 extends MailboxUpdateResponse {
  /// Success.
  _MailboxUpdateResponse200.response200() : status = 200;

  @override
  final int status;

  @override
  final OpenApiContentType? contentType = null;

  @override
  Map<String, Object?> propertiesToString() =>
      {'status': status, 'contentType': contentType};
}

abstract class MailboxUpdateResponse extends OpenApiResponse
    implements HasSuccessResponse<void> {
  MailboxUpdateResponse();

  /// Success.
  factory MailboxUpdateResponse.response200() =>
      _MailboxUpdateResponse200.response200();

  void map({required ResponseMap<_MailboxUpdateResponse200> on200}) {
    if (this is _MailboxUpdateResponse200) {
      on200((this as _MailboxUpdateResponse200));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }

  /// status 200:  Success.
  @override
  void requireSuccess() {
    if (this is _MailboxUpdateResponse200) {
      return;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

@_i1.JsonSerializable()
class MailboxUpdateSchema implements OpenApiContent {
  MailboxUpdateSchema(
      {this.label,
      this.entryUuid,
      this.isDeleted,
      this.isDisabled,
      this.isHidden});

  factory MailboxUpdateSchema.fromJson(Map<String, dynamic> jsonMap) =>
      _$MailboxUpdateSchemaFromJson(jsonMap);

  @_i1.JsonKey(name: 'label')
  final String? label;

  @_i1.JsonKey(name: 'entryUuid')
  final String? entryUuid;

  @_i1.JsonKey(name: 'isDeleted')
  final bool? isDeleted;

  @_i1.JsonKey(name: 'isDisabled')
  final bool? isDisabled;

  @_i1.JsonKey(name: 'isHidden')
  final bool? isHidden;

  Map<String, dynamic> toJson() => _$MailboxUpdateSchemaToJson(this);
  @override
  String toString() => toJson().toString();
}

class _MailboxMessageGetResponse200 extends MailboxMessageGetResponse
    implements OpenApiResponseBodyString {
  /// Raw email message incluuding all headers, body and attachment.
  _MailboxMessageGetResponse200.response200(this.body) : status = 200;

  @override
  final int status;

  @override
  final String body;

  @override
  final OpenApiContentType contentType = OpenApiContentType.parse('text/plain');

  @override
  Map<String, Object?> propertiesToString() =>
      {'status': status, 'body': body, 'contentType': contentType};
}

abstract class MailboxMessageGetResponse extends OpenApiResponse
    implements HasSuccessResponse<String> {
  MailboxMessageGetResponse();

  /// Raw email message incluuding all headers, body and attachment.
  factory MailboxMessageGetResponse.response200(String body) =>
      _MailboxMessageGetResponse200.response200(body);

  void map({required ResponseMap<_MailboxMessageGetResponse200> on200}) {
    if (this is _MailboxMessageGetResponse200) {
      on200((this as _MailboxMessageGetResponse200));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }

  /// status 200:  Raw email message incluuding all headers, body and attachment.
  @override
  String requireSuccess() {
    if (this is _MailboxMessageGetResponse200) {
      return (this as _MailboxMessageGetResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class _MailboxMessageDeleteResponse200 extends MailboxMessageDeleteResponse {
  /// Message was deleted successfully.
  _MailboxMessageDeleteResponse200.response200() : status = 200;

  @override
  final int status;

  @override
  final OpenApiContentType? contentType = null;

  @override
  Map<String, Object?> propertiesToString() =>
      {'status': status, 'contentType': contentType};
}

abstract class MailboxMessageDeleteResponse extends OpenApiResponse
    implements HasSuccessResponse<void> {
  MailboxMessageDeleteResponse();

  /// Message was deleted successfully.
  factory MailboxMessageDeleteResponse.response200() =>
      _MailboxMessageDeleteResponse200.response200();

  void map({required ResponseMap<_MailboxMessageDeleteResponse200> on200}) {
    if (this is _MailboxMessageDeleteResponse200) {
      on200((this as _MailboxMessageDeleteResponse200));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }

  /// status 200:  Message was deleted successfully.
  @override
  void requireSuccess() {
    if (this is _MailboxMessageDeleteResponse200) {
      return;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class _MailboxMessageForwardResponse200 extends MailboxMessageForwardResponse {
  /// Successfully forwarded message.
  _MailboxMessageForwardResponse200.response200() : status = 200;

  @override
  final int status;

  @override
  final OpenApiContentType? contentType = null;

  @override
  Map<String, Object?> propertiesToString() =>
      {'status': status, 'contentType': contentType};
}

abstract class MailboxMessageForwardResponse extends OpenApiResponse
    implements HasSuccessResponse<void> {
  MailboxMessageForwardResponse();

  /// Successfully forwarded message.
  factory MailboxMessageForwardResponse.response200() =>
      _MailboxMessageForwardResponse200.response200();

  void map({required ResponseMap<_MailboxMessageForwardResponse200> on200}) {
    if (this is _MailboxMessageForwardResponse200) {
      on200((this as _MailboxMessageForwardResponse200));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }

  /// status 200:  Successfully forwarded message.
  @override
  void requireSuccess() {
    if (this is _MailboxMessageForwardResponse200) {
      return;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

@_i1.JsonSerializable()
class MailboxMessageForwardSchema implements OpenApiContent {
  MailboxMessageForwardSchema({this.email});

  factory MailboxMessageForwardSchema.fromJson(Map<String, dynamic> jsonMap) =>
      _$MailboxMessageForwardSchemaFromJson(jsonMap);

  @_i1.JsonKey(name: 'email')
  final String? email;

  Map<String, dynamic> toJson() => _$MailboxMessageForwardSchemaToJson(this);
  @override
  String toString() => toJson().toString();
}

class _MailboxMessageMarkReadResponse200
    extends MailboxMessageMarkReadResponse {
  /// Successfully marked as read.
  _MailboxMessageMarkReadResponse200.response200() : status = 200;

  @override
  final int status;

  @override
  final OpenApiContentType? contentType = null;

  @override
  Map<String, Object?> propertiesToString() =>
      {'status': status, 'contentType': contentType};
}

abstract class MailboxMessageMarkReadResponse extends OpenApiResponse
    implements HasSuccessResponse<void> {
  MailboxMessageMarkReadResponse();

  /// Successfully marked as read.
  factory MailboxMessageMarkReadResponse.response200() =>
      _MailboxMessageMarkReadResponse200.response200();

  void map({required ResponseMap<_MailboxMessageMarkReadResponse200> on200}) {
    if (this is _MailboxMessageMarkReadResponse200) {
      on200((this as _MailboxMessageMarkReadResponse200));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }

  /// status 200:  Successfully marked as read.
  @override
  void requireSuccess() {
    if (this is _MailboxMessageMarkReadResponse200) {
      return;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class _MailboxMessageMarkUnReadResponse200
    extends MailboxMessageMarkUnReadResponse {
  /// Successfully marked as unread.
  _MailboxMessageMarkUnReadResponse200.response200() : status = 200;

  @override
  final int status;

  @override
  final OpenApiContentType? contentType = null;

  @override
  Map<String, Object?> propertiesToString() =>
      {'status': status, 'contentType': contentType};
}

abstract class MailboxMessageMarkUnReadResponse extends OpenApiResponse
    implements HasSuccessResponse<void> {
  MailboxMessageMarkUnReadResponse();

  /// Successfully marked as unread.
  factory MailboxMessageMarkUnReadResponse.response200() =>
      _MailboxMessageMarkUnReadResponse200.response200();

  void map({required ResponseMap<_MailboxMessageMarkUnReadResponse200> on200}) {
    if (this is _MailboxMessageMarkUnReadResponse200) {
      on200((this as _MailboxMessageMarkUnReadResponse200));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }

  /// status 200:  Successfully marked as unread.
  @override
  void requireSuccess() {
    if (this is _MailboxMessageMarkUnReadResponse200) {
      return;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class _EmailReceivePostResponse200 extends EmailReceivePostResponse {
  /// Received and delivered successfully.
  _EmailReceivePostResponse200.response200() : status = 200;

  @override
  final int status;

  @override
  final OpenApiContentType? contentType = null;

  @override
  Map<String, Object?> propertiesToString() =>
      {'status': status, 'contentType': contentType};
}

class _EmailReceivePostResponse403 extends EmailReceivePostResponse
    implements OpenApiResponseBodyString {
  /// Delivery not accepted.
  _EmailReceivePostResponse403.response403(this.body) : status = 403;

  @override
  final int status;

  @override
  final String body;

  @override
  final OpenApiContentType contentType = OpenApiContentType.parse('text/plain');

  @override
  Map<String, Object?> propertiesToString() =>
      {'status': status, 'body': body, 'contentType': contentType};
}

abstract class EmailReceivePostResponse extends OpenApiResponse
    implements HasSuccessResponse<void> {
  EmailReceivePostResponse();

  /// Received and delivered successfully.
  factory EmailReceivePostResponse.response200() =>
      _EmailReceivePostResponse200.response200();

  /// Delivery not accepted.
  factory EmailReceivePostResponse.response403(String body) =>
      _EmailReceivePostResponse403.response403(body);

  void map(
      {required ResponseMap<_EmailReceivePostResponse200> on200,
      required ResponseMap<_EmailReceivePostResponse403> on403}) {
    if (this is _EmailReceivePostResponse200) {
      on200((this as _EmailReceivePostResponse200));
    } else if (this is _EmailReceivePostResponse403) {
      on403((this as _EmailReceivePostResponse403));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }

  /// status 200:  Received and delivered successfully.
  @override
  void requireSuccess() {
    if (this is _EmailReceivePostResponse200) {
      return;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class _WebsiteImageGetResponse200 extends WebsiteImageGetResponse
    implements OpenApiResponseBodyBinary {
  /// Image
  _WebsiteImageGetResponse200.response200(this.contentType, this.body)
      : status = 200;

  @override
  final int status;

  @override
  final _i2.Uint8List body;

  @override
  final OpenApiContentType contentType;

  @override
  Map<String, Object?> propertiesToString() =>
      {'status': status, 'body': body, 'contentType': contentType};
}

abstract class WebsiteImageGetResponse extends OpenApiResponse
    implements HasSuccessResponse<_i2.Uint8List> {
  WebsiteImageGetResponse();

  /// Image
  factory WebsiteImageGetResponse.response200(
          OpenApiContentType contentType, _i2.Uint8List body) =>
      _WebsiteImageGetResponse200.response200(contentType, body);

  void map({required ResponseMap<_WebsiteImageGetResponse200> on200}) {
    if (this is _WebsiteImageGetResponse200) {
      on200((this as _WebsiteImageGetResponse200));
    } else {
      throw StateError('Invalid instance type $this');
    }
  }

  /// status 200:  Image
  @override
  _i2.Uint8List requireSuccess() {
    if (this is _WebsiteImageGetResponse200) {
      return (this as _WebsiteImageGetResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

abstract class AuthPassCloud implements ApiEndpoint {
  /// Health check.
  /// Health check of endpoint data
  /// get: /check
  Future<CheckGetResponse> checkGet();

  /// Status Check.
  /// post: /check/status
  Future<CheckStatusPostResponse> checkStatusPost({String? xSecret});

  /// Retrieve info about the currently logged in user and about the token.
  /// get: /user
  Future<UserGetResponse> userGet();

  /// Create new user, or login the user using confirmation email.
  /// post: /user/register
  Future<UserRegisterPostResponse> userRegisterPost(RegisterRequest body);

  /// Get the status of the current auth token (whether it was confirmed or not).
  /// get: /email/status
  Future<EmailStatusGetResponse> emailStatusGet();

  /// Confirm email address
  /// get: /email/confirm
  Future<EmailConfirmGetResponse> emailConfirmGet({required String token});

  /// Confirm with recaptcha
  /// post: /email/confirm
  Future<EmailConfirmPostResponse> emailConfirmPost(
      EmailConfirmPostSchema body);

  /// Get status of the user account.
  /// get: /status
  Future<StatusGetResponse> statusGet();

  /// List of all mailboxes of the current user.
  /// get: /mailbox
  Future<MailboxGetResponse> mailboxGet();

  /// Creates a new (random) email address mailbox.
  /// post: /mailbox/create
  Future<MailboxCreatePostResponse> mailboxCreatePost(
      MailboxCreatePostSchema body);

  /// List all emails in all mailboxes of the current user.
  ///
  /// get: /mailbox/list
  Future<MailboxListGetResponse> mailboxListGet(
      {String? pageToken, String? sinceToken});

  /// Apply the given update to all matching mails.
  /// post: /mail/massupdate
  Future<MailMassupdatePostResponse> mailMassupdatePost(
      MailMassupdatePostSchema body);

  /// Update information about mailbox
  /// put: /mailbox/update/{mailboxAddress}
  Future<MailboxUpdateResponse> mailboxUpdate(MailboxUpdateSchema body,
      {required String mailboxAddress});

  /// Fetch raw email message.
  /// get: /mailbox/message/{messageId}
  Future<MailboxMessageGetResponse> mailboxMessageGet(
      {required ApiUuid messageId});

  /// Delete the given message.
  /// delete: /mailbox/message/{messageId}
  Future<MailboxMessageDeleteResponse> mailboxMessageDelete(
      {required ApiUuid messageId});

  /// Forward email to users actual email address
  /// post: /mailbox/message/{messageId}/forward
  Future<MailboxMessageForwardResponse> mailboxMessageForward(
      MailboxMessageForwardSchema body,
      {required ApiUuid messageId});

  /// Mark message as read
  /// put: /mailbox/message/{messageId}/read
  Future<MailboxMessageMarkReadResponse> mailboxMessageMarkRead(
      {required ApiUuid messageId});

  /// Mark message as unread (again)
  /// delete: /mailbox/message/{messageId}/read
  Future<MailboxMessageMarkUnReadResponse> mailboxMessageMarkUnRead(
      {required ApiUuid messageId});

  /// Receive emails throw smtp bridge.
  /// post: /email/receive
  /// [body]: Email content (header and body)
  Future<EmailReceivePostResponse> emailReceivePost(String body,
      {required String xAuthpassToken});

  /// Load the best image for the given website.
  /// get: /website/image
  Future<WebsiteImageGetResponse> websiteImageGet({required String url});
}

abstract class AuthPassCloudClient implements OpenApiClient {
  factory AuthPassCloudClient(
          Uri baseUri, OpenApiRequestSender requestSender) =>
      _AuthPassCloudClientImpl._(baseUri, requestSender);

  /// Health check.
  /// Health check of endpoint data
  /// get: /check
  ///
  Future<CheckGetResponse> checkGet();

  /// Status Check.
  /// post: /check/status
  ///
  Future<CheckStatusPostResponse> checkStatusPost({String? xSecret});

  /// Retrieve info about the currently logged in user and about the token.
  /// get: /user
  ///
  Future<UserGetResponse> userGet();

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
  Future<EmailConfirmGetResponse> emailConfirmGet({required String token});

  /// Confirm with recaptcha
  /// post: /email/confirm
  ///
  Future<EmailConfirmPostResponse> emailConfirmPost(
      EmailConfirmPostSchema body);

  /// Get status of the user account.
  /// get: /status
  ///
  Future<StatusGetResponse> statusGet();

  /// List of all mailboxes of the current user.
  /// get: /mailbox
  ///
  Future<MailboxGetResponse> mailboxGet();

  /// Creates a new (random) email address mailbox.
  /// post: /mailbox/create
  ///
  Future<MailboxCreatePostResponse> mailboxCreatePost(
      MailboxCreatePostSchema body);

  /// List all emails in all mailboxes of the current user.
  ///
  /// get: /mailbox/list
  ///
  /// * [pageToken]: Page token as returned by Page
  /// * [sinceToken]: As returned from a previous page object for a finished sync.
  Future<MailboxListGetResponse> mailboxListGet(
      {String? pageToken, String? sinceToken});

  /// Apply the given update to all matching mails.
  /// post: /mail/massupdate
  ///
  Future<MailMassupdatePostResponse> mailMassupdatePost(
      MailMassupdatePostSchema body);

  /// Update information about mailbox
  /// put: /mailbox/update/{mailboxAddress}
  ///
  Future<MailboxUpdateResponse> mailboxUpdate(MailboxUpdateSchema body,
      {required String mailboxAddress});

  /// Fetch raw email message.
  /// get: /mailbox/message/{messageId}
  ///
  Future<MailboxMessageGetResponse> mailboxMessageGet(
      {required ApiUuid messageId});

  /// Delete the given message.
  /// delete: /mailbox/message/{messageId}
  ///
  Future<MailboxMessageDeleteResponse> mailboxMessageDelete(
      {required ApiUuid messageId});

  /// Forward email to users actual email address
  /// post: /mailbox/message/{messageId}/forward
  ///
  Future<MailboxMessageForwardResponse> mailboxMessageForward(
      MailboxMessageForwardSchema body,
      {required ApiUuid messageId});

  /// Mark message as read
  /// put: /mailbox/message/{messageId}/read
  ///
  Future<MailboxMessageMarkReadResponse> mailboxMessageMarkRead(
      {required ApiUuid messageId});

  /// Mark message as unread (again)
  /// delete: /mailbox/message/{messageId}/read
  ///
  Future<MailboxMessageMarkUnReadResponse> mailboxMessageMarkUnRead(
      {required ApiUuid messageId});

  /// Receive emails throw smtp bridge.
  /// post: /email/receive
  ///
  /// * [xAuthpassToken]: Security token to validate origin from trusted server
  /// [body]: Email content (header and body)
  Future<EmailReceivePostResponse> emailReceivePost(String body,
      {required String xAuthpassToken});

  /// Load the best image for the given website.
  /// get: /website/image
  ///
  Future<WebsiteImageGetResponse> websiteImageGet({required String url});
}

class _AuthPassCloudClientImpl extends OpenApiClientBase
    implements AuthPassCloudClient {
  _AuthPassCloudClientImpl._(this.baseUri, this.requestSender);

  @override
  final Uri baseUri;

  @override
  final OpenApiRequestSender requestSender;

  /// Health check.
  /// Health check of endpoint data
  /// get: /check
  ///
  @override
  Future<CheckGetResponse> checkGet() async {
    final request = OpenApiClientRequest('get', '/check', []);
    return await sendRequest(request, {
      '200': (OpenApiClientResponse response) async =>
          _CheckGetResponse200.response200()
    });
  }

  /// Status Check.
  /// post: /check/status
  ///
  @override
  Future<CheckStatusPostResponse> checkStatusPost({String? xSecret}) async {
    final request = OpenApiClientRequest('post', '/check/status', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addHeaderParameter('x-secret', encodeString(xSecret));
    return await sendRequest(request, {
      '200': (OpenApiClientResponse response) async =>
          _CheckStatusPostResponse200.response200(
              SystemStatus.fromJson(await response.responseBodyJson()))
    });
  }

  /// Retrieve info about the currently logged in user and about the token.
  /// get: /user
  ///
  @override
  Future<UserGetResponse> userGet() async {
    final request = OpenApiClientRequest('get', '/user', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    return await sendRequest(request, {
      '200': (OpenApiClientResponse response) async =>
          _UserGetResponse200.response200(
              UserInfo.fromJson(await response.responseBodyJson()))
    });
  }

  /// Create new user, or login the user using confirmation email.
  /// post: /user/register
  ///
  @override
  Future<UserRegisterPostResponse> userRegisterPost(
      RegisterRequest body) async {
    final request = OpenApiClientRequest('post', '/user/register', []);
    request.setHeader('content-type', 'application/json');
    request.setBody(OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(request, {
      '200': (OpenApiClientResponse response) async =>
          _UserRegisterPostResponse200.response200(
              RegisterResponse.fromJson(await response.responseBodyJson()))
    });
  }

  /// Get the status of the current auth token (whether it was confirmed or not).
  /// get: /email/status
  ///
  @override
  Future<EmailStatusGetResponse> emailStatusGet() async {
    final request = OpenApiClientRequest('get', '/email/status', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    return await sendRequest(request, {
      '200': (OpenApiClientResponse response) async =>
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
      {required String token}) async {
    final request = OpenApiClientRequest('get', '/email/confirm', []);
    request.addQueryParameter('token', encodeString(token));
    return await sendRequest(request, {
      '200': (OpenApiClientResponse response) async =>
          _EmailConfirmGetResponse200.response200(
              await response.responseBodyString()),
      '400': (OpenApiClientResponse response) async =>
          _EmailConfirmGetResponse400.response400()
    });
  }

  /// Confirm with recaptcha
  /// post: /email/confirm
  ///
  @override
  Future<EmailConfirmPostResponse> emailConfirmPost(
      EmailConfirmPostSchema body) async {
    final request = OpenApiClientRequest('post', '/email/confirm', []);
    request.setHeader('content-type', 'application/x-www-form-urlencoded');
    request.setBody(OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(request, {
      '200': (OpenApiClientResponse response) async =>
          _EmailConfirmPostResponse200.response200(
              await response.responseBodyString()),
      '400': (OpenApiClientResponse response) async =>
          _EmailConfirmPostResponse400.response400()
    });
  }

  /// Get status of the user account.
  /// get: /status
  ///
  @override
  Future<StatusGetResponse> statusGet() async {
    final request = OpenApiClientRequest('get', '/status', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    return await sendRequest(request, {
      '200': (OpenApiClientResponse response) async =>
          _StatusGetResponse200.response200(StatusGetResponseBody200.fromJson(
              await response.responseBodyJson()))
    });
  }

  /// List of all mailboxes of the current user.
  /// get: /mailbox
  ///
  @override
  Future<MailboxGetResponse> mailboxGet() async {
    final request = OpenApiClientRequest('get', '/mailbox', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    return await sendRequest(request, {
      '200': (OpenApiClientResponse response) async =>
          _MailboxGetResponse200.response200(MailboxGetResponseBody200.fromJson(
              await response.responseBodyJson()))
    });
  }

  /// Creates a new (random) email address mailbox.
  /// post: /mailbox/create
  ///
  @override
  Future<MailboxCreatePostResponse> mailboxCreatePost(
      MailboxCreatePostSchema body) async {
    final request = OpenApiClientRequest('post', '/mailbox/create', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.setHeader('content-type', 'application/json');
    request.setBody(OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(request, {
      '200': (OpenApiClientResponse response) async =>
          _MailboxCreatePostResponse200.response200(
              MailboxCreatePostResponseBody200.fromJson(
                  await response.responseBodyJson()))
    });
  }

  /// List all emails in all mailboxes of the current user.
  ///
  /// get: /mailbox/list
  ///
  /// * [pageToken]: Page token as returned by Page
  /// * [sinceToken]: As returned from a previous page object for a finished sync.
  @override
  Future<MailboxListGetResponse> mailboxListGet(
      {String? pageToken, String? sinceToken}) async {
    final request = OpenApiClientRequest('get', '/mailbox/list', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addQueryParameter('page_token', encodeString(pageToken));
    request.addQueryParameter('since_token', encodeString(sinceToken));
    return await sendRequest(request, {
      '200': (OpenApiClientResponse response) async =>
          _MailboxListGetResponse200.response200(
              MailboxListGetResponseBody200.fromJson(
                  await response.responseBodyJson()))
    });
  }

  /// Apply the given update to all matching mails.
  /// post: /mail/massupdate
  ///
  @override
  Future<MailMassupdatePostResponse> mailMassupdatePost(
      MailMassupdatePostSchema body) async {
    final request = OpenApiClientRequest('post', '/mail/massupdate', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.setHeader('content-type', 'application/json');
    request.setBody(OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(request, {
      '200': (OpenApiClientResponse response) async =>
          _MailMassupdatePostResponse200.response200()
    });
  }

  /// Update information about mailbox
  /// put: /mailbox/update/{mailboxAddress}
  ///
  @override
  Future<MailboxUpdateResponse> mailboxUpdate(MailboxUpdateSchema body,
      {required String mailboxAddress}) async {
    final request =
        OpenApiClientRequest('put', '/mailbox/update/{mailboxAddress}', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addPathParameter('mailboxAddress', encodeString(mailboxAddress));
    request.setHeader('content-type', 'application/json');
    request.setBody(OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(request, {
      '200': (OpenApiClientResponse response) async =>
          _MailboxUpdateResponse200.response200()
    });
  }

  /// Fetch raw email message.
  /// get: /mailbox/message/{messageId}
  ///
  @override
  Future<MailboxMessageGetResponse> mailboxMessageGet(
      {required ApiUuid messageId}) async {
    final request =
        OpenApiClientRequest('get', '/mailbox/message/{messageId}', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addPathParameter(
        'messageId', encodeString(messageId.encodeToString()));
    return await sendRequest(request, {
      '200': (OpenApiClientResponse response) async =>
          _MailboxMessageGetResponse200.response200(
              await response.responseBodyString())
    });
  }

  /// Delete the given message.
  /// delete: /mailbox/message/{messageId}
  ///
  @override
  Future<MailboxMessageDeleteResponse> mailboxMessageDelete(
      {required ApiUuid messageId}) async {
    final request =
        OpenApiClientRequest('delete', '/mailbox/message/{messageId}', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addPathParameter(
        'messageId', encodeString(messageId.encodeToString()));
    return await sendRequest(request, {
      '200': (OpenApiClientResponse response) async =>
          _MailboxMessageDeleteResponse200.response200()
    });
  }

  /// Forward email to users actual email address
  /// post: /mailbox/message/{messageId}/forward
  ///
  @override
  Future<MailboxMessageForwardResponse> mailboxMessageForward(
      MailboxMessageForwardSchema body,
      {required ApiUuid messageId}) async {
    final request =
        OpenApiClientRequest('post', '/mailbox/message/{messageId}/forward', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addPathParameter(
        'messageId', encodeString(messageId.encodeToString()));
    request.setHeader('content-type', 'application/json');
    request.setBody(OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(request, {
      '200': (OpenApiClientResponse response) async =>
          _MailboxMessageForwardResponse200.response200()
    });
  }

  /// Mark message as read
  /// put: /mailbox/message/{messageId}/read
  ///
  @override
  Future<MailboxMessageMarkReadResponse> mailboxMessageMarkRead(
      {required ApiUuid messageId}) async {
    final request =
        OpenApiClientRequest('put', '/mailbox/message/{messageId}/read', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addPathParameter(
        'messageId', encodeString(messageId.encodeToString()));
    return await sendRequest(request, {
      '200': (OpenApiClientResponse response) async =>
          _MailboxMessageMarkReadResponse200.response200()
    });
  }

  /// Mark message as unread (again)
  /// delete: /mailbox/message/{messageId}/read
  ///
  @override
  Future<MailboxMessageMarkUnReadResponse> mailboxMessageMarkUnRead(
      {required ApiUuid messageId}) async {
    final request =
        OpenApiClientRequest('delete', '/mailbox/message/{messageId}/read', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addPathParameter(
        'messageId', encodeString(messageId.encodeToString()));
    return await sendRequest(request, {
      '200': (OpenApiClientResponse response) async =>
          _MailboxMessageMarkUnReadResponse200.response200()
    });
  }

  /// Receive emails throw smtp bridge.
  /// post: /email/receive
  ///
  /// * [xAuthpassToken]: Security token to validate origin from trusted server
  /// [body]: Email content (header and body)
  @override
  Future<EmailReceivePostResponse> emailReceivePost(String body,
      {required String xAuthpassToken}) async {
    final request = OpenApiClientRequest('post', '/email/receive', []);
    request.addHeaderParameter(
        'x-authpass-token', encodeString(xAuthpassToken));
    request.setHeader('content-type', 'text/plain');
    request.setBody(OpenApiClientRequestBodyText(body));
    return await sendRequest(request, {
      '200': (OpenApiClientResponse response) async =>
          _EmailReceivePostResponse200.response200(),
      '403': (OpenApiClientResponse response) async =>
          _EmailReceivePostResponse403.response403(
              await response.responseBodyString())
    });
  }

  /// Load the best image for the given website.
  /// get: /website/image
  ///
  @override
  Future<WebsiteImageGetResponse> websiteImageGet({required String url}) async {
    final request = OpenApiClientRequest('get', '/website/image', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addQueryParameter('url', encodeString(url));
    return await sendRequest(request, {
      '200': (OpenApiClientResponse response) async =>
          _WebsiteImageGetResponse200.response200(
              response.responseContentType(),
              await response.responseBodyBytes())
    });
  }
}

class AuthPassCloudUrlResolve with OpenApiUrlEncodeMixin {
  /// Health check.
  /// Health check of endpoint data
  /// get: /check
  ///
  OpenApiClientRequest checkGet() {
    final request = OpenApiClientRequest('get', '/check', []);
    return request;
  }

  /// Status Check.
  /// post: /check/status
  ///
  OpenApiClientRequest checkStatusPost({String? xSecret}) {
    final request = OpenApiClientRequest('post', '/check/status', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addHeaderParameter('x-secret', encodeString(xSecret));
    return request;
  }

  /// Retrieve info about the currently logged in user and about the token.
  /// get: /user
  ///
  OpenApiClientRequest userGet() {
    final request = OpenApiClientRequest('get', '/user', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    return request;
  }

  /// Create new user, or login the user using confirmation email.
  /// post: /user/register
  ///
  OpenApiClientRequest userRegisterPost() {
    final request = OpenApiClientRequest('post', '/user/register', []);
    return request;
  }

  /// Get the status of the current auth token (whether it was confirmed or not).
  /// get: /email/status
  ///
  OpenApiClientRequest emailStatusGet() {
    final request = OpenApiClientRequest('get', '/email/status', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    return request;
  }

  /// Confirm email address
  /// get: /email/confirm
  ///
  /// * [token]: Unique token which was sent to email address.
  OpenApiClientRequest emailConfirmGet({required String token}) {
    final request = OpenApiClientRequest('get', '/email/confirm', []);
    request.addQueryParameter('token', encodeString(token));
    return request;
  }

  /// Confirm with recaptcha
  /// post: /email/confirm
  ///
  OpenApiClientRequest emailConfirmPost() {
    final request = OpenApiClientRequest('post', '/email/confirm', []);
    return request;
  }

  /// Get status of the user account.
  /// get: /status
  ///
  OpenApiClientRequest statusGet() {
    final request = OpenApiClientRequest('get', '/status', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    return request;
  }

  /// List of all mailboxes of the current user.
  /// get: /mailbox
  ///
  OpenApiClientRequest mailboxGet() {
    final request = OpenApiClientRequest('get', '/mailbox', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    return request;
  }

  /// Creates a new (random) email address mailbox.
  /// post: /mailbox/create
  ///
  OpenApiClientRequest mailboxCreatePost() {
    final request = OpenApiClientRequest('post', '/mailbox/create', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    return request;
  }

  /// List all emails in all mailboxes of the current user.
  ///
  /// get: /mailbox/list
  ///
  /// * [pageToken]: Page token as returned by Page
  /// * [sinceToken]: As returned from a previous page object for a finished sync.
  OpenApiClientRequest mailboxListGet({String? pageToken, String? sinceToken}) {
    final request = OpenApiClientRequest('get', '/mailbox/list', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addQueryParameter('page_token', encodeString(pageToken));
    request.addQueryParameter('since_token', encodeString(sinceToken));
    return request;
  }

  /// Apply the given update to all matching mails.
  /// post: /mail/massupdate
  ///
  OpenApiClientRequest mailMassupdatePost() {
    final request = OpenApiClientRequest('post', '/mail/massupdate', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    return request;
  }

  /// Update information about mailbox
  /// put: /mailbox/update/{mailboxAddress}
  ///
  OpenApiClientRequest mailboxUpdate({required String mailboxAddress}) {
    final request =
        OpenApiClientRequest('put', '/mailbox/update/{mailboxAddress}', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addPathParameter('mailboxAddress', encodeString(mailboxAddress));
    return request;
  }

  /// Fetch raw email message.
  /// get: /mailbox/message/{messageId}
  ///
  OpenApiClientRequest mailboxMessageGet({required ApiUuid messageId}) {
    final request =
        OpenApiClientRequest('get', '/mailbox/message/{messageId}', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addPathParameter(
        'messageId', encodeString(messageId.encodeToString()));
    return request;
  }

  /// Delete the given message.
  /// delete: /mailbox/message/{messageId}
  ///
  OpenApiClientRequest mailboxMessageDelete({required ApiUuid messageId}) {
    final request =
        OpenApiClientRequest('delete', '/mailbox/message/{messageId}', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addPathParameter(
        'messageId', encodeString(messageId.encodeToString()));
    return request;
  }

  /// Forward email to users actual email address
  /// post: /mailbox/message/{messageId}/forward
  ///
  OpenApiClientRequest mailboxMessageForward({required ApiUuid messageId}) {
    final request =
        OpenApiClientRequest('post', '/mailbox/message/{messageId}/forward', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addPathParameter(
        'messageId', encodeString(messageId.encodeToString()));
    return request;
  }

  /// Mark message as read
  /// put: /mailbox/message/{messageId}/read
  ///
  OpenApiClientRequest mailboxMessageMarkRead({required ApiUuid messageId}) {
    final request =
        OpenApiClientRequest('put', '/mailbox/message/{messageId}/read', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addPathParameter(
        'messageId', encodeString(messageId.encodeToString()));
    return request;
  }

  /// Mark message as unread (again)
  /// delete: /mailbox/message/{messageId}/read
  ///
  OpenApiClientRequest mailboxMessageMarkUnRead({required ApiUuid messageId}) {
    final request =
        OpenApiClientRequest('delete', '/mailbox/message/{messageId}/read', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addPathParameter(
        'messageId', encodeString(messageId.encodeToString()));
    return request;
  }

  /// Receive emails throw smtp bridge.
  /// post: /email/receive
  ///
  /// * [xAuthpassToken]: Security token to validate origin from trusted server
  OpenApiClientRequest emailReceivePost({required String xAuthpassToken}) {
    final request = OpenApiClientRequest('post', '/email/receive', []);
    request.addHeaderParameter(
        'x-authpass-token', encodeString(xAuthpassToken));
    return request;
  }

  /// Load the best image for the given website.
  /// get: /website/image
  ///
  OpenApiClientRequest websiteImageGet({required String url}) {
    final request = OpenApiClientRequest('get', '/website/image', [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addQueryParameter('url', encodeString(url));
    return request;
  }
}

class AuthPassCloudRouter extends OpenApiServerRouterBase {
  AuthPassCloudRouter(this.impl);

  final ApiEndpointProvider<AuthPassCloud> impl;

  @override
  void configure() {
    addRoute('/check', 'get', (OpenApiRequest request) async {
      return await impl.invoke(
          request, (AuthPassCloud impl) async => impl.checkGet());
    }, security: []);
    addRoute('/check/status', 'post', (OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.checkStatusPost(
              xSecret: paramOpt(
                  name: 'x-secret',
                  value: request.headerParameter('x-secret'),
                  decode: (value) => paramToString(value))));
    }, security: [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    addRoute('/user', 'get', (OpenApiRequest request) async {
      return await impl.invoke(
          request, (AuthPassCloud impl) async => impl.userGet());
    }, security: [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    addRoute('/user/register', 'post', (OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.userRegisterPost(
              RegisterRequest.fromJson(await request.readJsonBody())));
    }, security: []);
    addRoute('/email/status', 'get', (OpenApiRequest request) async {
      return await impl.invoke(
          request, (AuthPassCloud impl) async => impl.emailStatusGet());
    }, security: [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    addRoute('/email/confirm', 'get', (OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.emailConfirmGet(
              token: paramRequired(
                  name: 'token',
                  value: request.queryParameter('token'),
                  decode: (value) => paramToString(value))));
    }, security: []);
    addRoute('/email/confirm', 'post', (OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.emailConfirmPost(
              EmailConfirmPostSchema.fromJson(
                  await request.readUrlEncodedBodyFlat())));
    }, security: []);
    addRoute('/status', 'get', (OpenApiRequest request) async {
      return await impl.invoke(
          request, (AuthPassCloud impl) async => impl.statusGet());
    }, security: [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    addRoute('/mailbox', 'get', (OpenApiRequest request) async {
      return await impl.invoke(
          request, (AuthPassCloud impl) async => impl.mailboxGet());
    }, security: [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    addRoute('/mailbox/create', 'post', (OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailboxCreatePost(
              MailboxCreatePostSchema.fromJson(await request.readJsonBody())));
    }, security: [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    addRoute('/mailbox/list', 'get', (OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailboxListGet(
              pageToken: paramOpt(
                  name: 'page_token',
                  value: request.queryParameter('page_token'),
                  decode: (value) => paramToString(value)),
              sinceToken: paramOpt(
                  name: 'since_token',
                  value: request.queryParameter('since_token'),
                  decode: (value) => paramToString(value))));
    }, security: [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    addRoute('/mail/massupdate', 'post', (OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailMassupdatePost(
              MailMassupdatePostSchema.fromJson(await request.readJsonBody())));
    }, security: [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    addRoute('/mailbox/update/{mailboxAddress}', 'put',
        (OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailboxUpdate(
              MailboxUpdateSchema.fromJson(await request.readJsonBody()),
              mailboxAddress: paramRequired(
                  name: 'mailboxAddress',
                  value: request.pathParameter('mailboxAddress'),
                  decode: (value) => paramToString(value))));
    }, security: [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    addRoute('/mailbox/message/{messageId}', 'get',
        (OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailboxMessageGet(
              messageId: paramRequired(
                  name: 'messageId',
                  value: request.pathParameter('messageId'),
                  decode: (value) => ApiUuid.parse(paramToString(value)))));
    }, security: [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    addRoute('/mailbox/message/{messageId}', 'delete',
        (OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailboxMessageDelete(
              messageId: paramRequired(
                  name: 'messageId',
                  value: request.pathParameter('messageId'),
                  decode: (value) => ApiUuid.parse(paramToString(value)))));
    }, security: [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    addRoute('/mailbox/message/{messageId}/forward', 'post',
        (OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailboxMessageForward(
              MailboxMessageForwardSchema.fromJson(
                  await request.readJsonBody()),
              messageId: paramRequired(
                  name: 'messageId',
                  value: request.pathParameter('messageId'),
                  decode: (value) => ApiUuid.parse(paramToString(value)))));
    }, security: [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    addRoute('/mailbox/message/{messageId}/read', 'put',
        (OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailboxMessageMarkRead(
              messageId: paramRequired(
                  name: 'messageId',
                  value: request.pathParameter('messageId'),
                  decode: (value) => ApiUuid.parse(paramToString(value)))));
    }, security: [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    addRoute('/mailbox/message/{messageId}/read', 'delete',
        (OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailboxMessageMarkUnRead(
              messageId: paramRequired(
                  name: 'messageId',
                  value: request.pathParameter('messageId'),
                  decode: (value) => ApiUuid.parse(paramToString(value)))));
    }, security: [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    addRoute('/email/receive', 'post', (OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.emailReceivePost(
              await request.readBodyString(),
              xAuthpassToken: paramRequired(
                  name: 'x-authpass-token',
                  value: request.headerParameter('x-authpass-token'),
                  decode: (value) => paramToString(value))));
    }, security: []);
    addRoute('/website/image', 'get', (OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.websiteImageGet(
              url: paramRequired(
                  name: 'url',
                  value: request.queryParameter('url'),
                  decode: (value) => paramToString(value))));
    }, security: [
      SecurityRequirement(schemes: [
        SecurityRequirementScheme(scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
  }
}

class SecuritySchemes {
  static final authToken =
      SecuritySchemeHttp(scheme: SecuritySchemeHttpScheme.bearer);
}

T _throwStateError<T>(String message) => throw StateError(message);
