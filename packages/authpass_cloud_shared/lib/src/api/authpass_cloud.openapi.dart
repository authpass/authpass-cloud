// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_initializing_formals

import 'package:json_annotation/json_annotation.dart' as _i1;
import 'package:meta/meta.dart' as _i3;
import 'package:openapi_base/openapi_base.dart' as _i2;
part 'authpass_cloud.openapi.g.dart';

@_i1.JsonSerializable()
class RegisterRequest implements _i2.OpenApiContent {
  RegisterRequest({@_i3.required this.email}) : assert(email != null);

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

@_i1.JsonSerializable()
class RegisterResponse implements _i2.OpenApiContent {
  RegisterResponse(
      {@_i3.required this.userUuid,
      @_i3.required this.authToken,
      @_i3.required this.status})
      : assert(userUuid != null),
        assert(authToken != null),
        assert(status != null);

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
class Page implements _i2.OpenApiContent {
  Page({this.nextPageToken, this.sinceToken});

  factory Page.fromJson(Map<String, dynamic> jsonMap) =>
      _$PageFromJson(jsonMap);

  /// Token for the next page, might be null if there are no more pages.
  @_i1.JsonKey(name: 'nextPageToken')
  final String nextPageToken;

  /// Once everything is synced, this token can be used for subsequent syncs.
  @_i1.JsonKey(name: 'sinceToken')
  final String sinceToken;

  Map<String, dynamic> toJson() => _$PageToJson(this);
  @override
  String toString() => toJson().toString();
}

@_i1.JsonSerializable()
class EmailMessage implements _i2.OpenApiContent {
  EmailMessage(
      {@_i3.required this.id,
      @_i3.required this.subject,
      @_i3.required this.sender,
      @_i3.required this.mailboxEntryUuid,
      @_i3.required this.createdAt,
      @_i3.required this.size,
      @_i3.required this.isRead})
      : assert(id != null),
        assert(subject != null),
        assert(sender != null),
        assert(mailboxEntryUuid != null),
        assert(createdAt != null),
        assert(size != null),
        assert(isRead != null);

  factory EmailMessage.fromJson(Map<String, dynamic> jsonMap) =>
      _$EmailMessageFromJson(jsonMap);

  @_i1.JsonKey(name: 'id')
  final String id;

  @_i1.JsonKey(name: 'subject')
  final String subject;

  @_i1.JsonKey(name: 'sender')
  final String sender;

  @_i1.JsonKey(name: 'mailboxEntryUuid')
  final String mailboxEntryUuid;

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
class Mailbox implements _i2.OpenApiContent {
  Mailbox(
      {@_i3.required this.address,
      @_i3.required this.label,
      @_i3.required this.entryUuid,
      @_i3.required this.createdAt,
      @_i3.required this.isDisabled})
      : assert(address != null),
        assert(label != null),
        assert(entryUuid != null),
        assert(createdAt != null),
        assert(isDisabled != null);

  factory Mailbox.fromJson(Map<String, dynamic> jsonMap) =>
      _$MailboxFromJson(jsonMap);

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
  /// /// Everything OK
  _CheckGetResponse200.response200() : status = 200;

  @override
  final int status;

  @override
  final _i2.OpenApiContentType contentType = null;

  @override
  Map<String, Object> propertiesToString() =>
      {'status': status, 'contentType': contentType};
}

abstract class CheckGetResponse extends _i2.OpenApiResponse
    implements _i2.HasSuccessResponse<void> {
  CheckGetResponse();

  /// /// Everything OK
  factory CheckGetResponse.response200() => _CheckGetResponse200.response200();

  void map({@_i3.required _i2.ResponseMap<_CheckGetResponse200> on200}) {
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

class _UserRegisterPostResponse200 extends UserRegisterPostResponse
    implements _i2.OpenApiResponseBodyJson {
  /// /// OK
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

  /// /// OK
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
      _names[name];
  String get name => toString().substring(36);
}

@_i1.JsonSerializable()
class EmailStatusGetResponseBody200 implements _i2.OpenApiContent {
  EmailStatusGetResponseBody200({this.status});

  factory EmailStatusGetResponseBody200.fromJson(
          Map<String, dynamic> jsonMap) =>
      _$EmailStatusGetResponseBody200FromJson(jsonMap);

  @_i1.JsonKey(name: 'status')
  final EmailStatusGetResponseBody200Status status;

  Map<String, dynamic> toJson() => _$EmailStatusGetResponseBody200ToJson(this);
  @override
  String toString() => toJson().toString();
}

class _EmailStatusGetResponse200 extends EmailStatusGetResponse
    implements _i2.OpenApiResponseBodyJson {
  /// /// Whether it was confirmed or not.
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

  /// /// Whether it was confirmed or not.
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
    implements _i2.OpenApiResponseBodyString {
  /// /// OK
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
  /// /// Invalid token or email address.
  _EmailConfirmGetResponse400.response400() : status = 400;

  @override
  final int status;

  @override
  final _i2.OpenApiContentType contentType = null;

  @override
  Map<String, Object> propertiesToString() =>
      {'status': status, 'contentType': contentType};
}

abstract class EmailConfirmGetResponse extends _i2.OpenApiResponse
    implements _i2.HasSuccessResponse<String> {
  EmailConfirmGetResponse();

  /// /// OK
  factory EmailConfirmGetResponse.response200(String body) =>
      _EmailConfirmGetResponse200.response200(body);

  /// /// Invalid token or email address.
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
    implements _i2.OpenApiResponseBodyString {
  /// /// OK
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
  /// /// Invalid token or email address.
  _EmailConfirmPostResponse400.response400() : status = 400;

  @override
  final int status;

  @override
  final _i2.OpenApiContentType contentType = null;

  @override
  Map<String, Object> propertiesToString() =>
      {'status': status, 'contentType': contentType};
}

abstract class EmailConfirmPostResponse extends _i2.OpenApiResponse
    implements _i2.HasSuccessResponse<String> {
  EmailConfirmPostResponse();

  /// /// OK
  factory EmailConfirmPostResponse.response200(String body) =>
      _EmailConfirmPostResponse200.response200(body);

  /// /// Invalid token or email address.
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
class EmailConfirmPostSchema implements _i2.OpenApiContent {
  EmailConfirmPostSchema(
      {@_i3.required this.token, @_i3.required this.gRecaptchaResponse})
      : assert(token != null),
        assert(gRecaptchaResponse != null);

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
class StatusGetResponseBody200Mail implements _i2.OpenApiContent {
  StatusGetResponseBody200Mail({@_i3.required this.messagesUnread})
      : assert(messagesUnread != null);

  factory StatusGetResponseBody200Mail.fromJson(Map<String, dynamic> jsonMap) =>
      _$StatusGetResponseBody200MailFromJson(jsonMap);

  @_i1.JsonKey(name: 'messagesUnread')
  final int messagesUnread;

  Map<String, dynamic> toJson() => _$StatusGetResponseBody200MailToJson(this);
  @override
  String toString() => toJson().toString();
}

@_i1.JsonSerializable()
class StatusGetResponseBody200 implements _i2.OpenApiContent {
  StatusGetResponseBody200({@_i3.required this.mail}) : assert(mail != null);

  factory StatusGetResponseBody200.fromJson(Map<String, dynamic> jsonMap) =>
      _$StatusGetResponseBody200FromJson(jsonMap);

  @_i1.JsonKey(name: 'mail')
  final StatusGetResponseBody200Mail mail;

  Map<String, dynamic> toJson() => _$StatusGetResponseBody200ToJson(this);
  @override
  String toString() => toJson().toString();
}

class _StatusGetResponse200 extends StatusGetResponse
    implements _i2.OpenApiResponseBodyJson {
  /// /// Information of the logged in account.
  _StatusGetResponse200.response200(this.body)
      : status = 200,
        bodyJson = body.toJson();

  @override
  final int status;

  final StatusGetResponseBody200 body;

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

abstract class StatusGetResponse extends _i2.OpenApiResponse
    implements _i2.HasSuccessResponse<StatusGetResponseBody200> {
  StatusGetResponse();

  /// /// Information of the logged in account.
  factory StatusGetResponse.response200(StatusGetResponseBody200 body) =>
      _StatusGetResponse200.response200(body);

  void map({@_i3.required _i2.ResponseMap<_StatusGetResponse200> on200}) {
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
class MailboxGetResponseBody200 implements _i2.OpenApiContent {
  MailboxGetResponseBody200({this.data});

  factory MailboxGetResponseBody200.fromJson(Map<String, dynamic> jsonMap) =>
      _$MailboxGetResponseBody200FromJson(jsonMap);

  @_i1.JsonKey(name: 'data')
  final List<Mailbox> data;

  Map<String, dynamic> toJson() => _$MailboxGetResponseBody200ToJson(this);
  @override
  String toString() => toJson().toString();
}

class _MailboxGetResponse200 extends MailboxGetResponse
    implements _i2.OpenApiResponseBodyJson {
  /// /// On Success returns unpaginated list (right now) of all mailboxes.
  _MailboxGetResponse200.response200(this.body)
      : status = 200,
        bodyJson = body.toJson();

  @override
  final int status;

  final MailboxGetResponseBody200 body;

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

abstract class MailboxGetResponse extends _i2.OpenApiResponse
    implements _i2.HasSuccessResponse<MailboxGetResponseBody200> {
  MailboxGetResponse();

  /// /// On Success returns unpaginated list (right now) of all mailboxes.
  factory MailboxGetResponse.response200(MailboxGetResponseBody200 body) =>
      _MailboxGetResponse200.response200(body);

  void map({@_i3.required _i2.ResponseMap<_MailboxGetResponse200> on200}) {
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
  /// /// Successfully created mailbox.
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

  /// /// Successfully created mailbox.
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
class MailboxCreatePostSchema implements _i2.OpenApiContent {
  MailboxCreatePostSchema(
      {@_i3.required this.label, @_i3.required this.entryUuid})
      : assert(label != null),
        assert(entryUuid != null);

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
class MailboxListGetResponseBody200 implements _i2.OpenApiContent {
  MailboxListGetResponseBody200(
      {@_i3.required this.page, @_i3.required this.data})
      : assert(page != null),
        assert(data != null);

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
    implements _i2.OpenApiResponseBodyJson {
  /// /// Successful list
  _MailboxListGetResponse200.response200(this.body)
      : status = 200,
        bodyJson = body.toJson();

  @override
  final int status;

  final MailboxListGetResponseBody200 body;

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

abstract class MailboxListGetResponse extends _i2.OpenApiResponse
    implements _i2.HasSuccessResponse<MailboxListGetResponseBody200> {
  MailboxListGetResponse();

  /// /// Successful list
  factory MailboxListGetResponse.response200(
          MailboxListGetResponseBody200 body) =>
      _MailboxListGetResponse200.response200(body);

  void map({@_i3.required _i2.ResponseMap<_MailboxListGetResponse200> on200}) {
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
  /// /// Update finished.
  _MailMassupdatePostResponse200.response200() : status = 200;

  @override
  final int status;

  @override
  final _i2.OpenApiContentType contentType = null;

  @override
  Map<String, Object> propertiesToString() =>
      {'status': status, 'contentType': contentType};
}

abstract class MailMassupdatePostResponse extends _i2.OpenApiResponse
    implements _i2.HasSuccessResponse<void> {
  MailMassupdatePostResponse();

  /// /// Update finished.
  factory MailMassupdatePostResponse.response200() =>
      _MailMassupdatePostResponse200.response200();

  void map(
      {@_i3.required _i2.ResponseMap<_MailMassupdatePostResponse200> on200}) {
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
  static MailMassupdatePostSchemaFilter fromName(String name) => _names[name];
  String get name => toString().substring(31);
}

@_i1.JsonSerializable()
class MailMassupdatePostSchema implements _i2.OpenApiContent {
  MailMassupdatePostSchema(
      {@_i3.required this.filter, this.messageIds, this.isRead})
      : assert(filter != null);

  factory MailMassupdatePostSchema.fromJson(Map<String, dynamic> jsonMap) =>
      _$MailMassupdatePostSchemaFromJson(jsonMap);

  @_i1.JsonKey(name: 'filter')
  final MailMassupdatePostSchemaFilter filter;

  /// Only used if filter=messageIds
  @_i1.JsonKey(name: 'messageIds')
  final List<String> messageIds;

  @_i1.JsonKey(name: 'isRead')
  final bool isRead;

  Map<String, dynamic> toJson() => _$MailMassupdatePostSchemaToJson(this);
  @override
  String toString() => toJson().toString();
}

class _MailboxUpdateResponse200 extends MailboxUpdateResponse {
  /// /// Success.
  _MailboxUpdateResponse200.response200() : status = 200;

  @override
  final int status;

  @override
  final _i2.OpenApiContentType contentType = null;

  @override
  Map<String, Object> propertiesToString() =>
      {'status': status, 'contentType': contentType};
}

abstract class MailboxUpdateResponse extends _i2.OpenApiResponse
    implements _i2.HasSuccessResponse<void> {
  MailboxUpdateResponse();

  /// /// Success.
  factory MailboxUpdateResponse.response200() =>
      _MailboxUpdateResponse200.response200();

  void map({@_i3.required _i2.ResponseMap<_MailboxUpdateResponse200> on200}) {
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
class MailboxUpdateSchema implements _i2.OpenApiContent {
  MailboxUpdateSchema(
      {this.label,
      this.entryUuid,
      this.isDeleted,
      this.isDisabled,
      this.isHidden});

  factory MailboxUpdateSchema.fromJson(Map<String, dynamic> jsonMap) =>
      _$MailboxUpdateSchemaFromJson(jsonMap);

  @_i1.JsonKey(name: 'label')
  final String label;

  @_i1.JsonKey(name: 'entryUuid')
  final String entryUuid;

  @_i1.JsonKey(name: 'isDeleted')
  final bool isDeleted;

  @_i1.JsonKey(name: 'isDisabled')
  final bool isDisabled;

  @_i1.JsonKey(name: 'isHidden')
  final bool isHidden;

  Map<String, dynamic> toJson() => _$MailboxUpdateSchemaToJson(this);
  @override
  String toString() => toJson().toString();
}

class _MailboxMessageGetResponse200 extends MailboxMessageGetResponse
    implements _i2.OpenApiResponseBodyString {
  /// /// Raw email message incluuding all headers, body and attachment.
  _MailboxMessageGetResponse200.response200(this.body) : status = 200;

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

abstract class MailboxMessageGetResponse extends _i2.OpenApiResponse
    implements _i2.HasSuccessResponse<String> {
  MailboxMessageGetResponse();

  /// /// Raw email message incluuding all headers, body and attachment.
  factory MailboxMessageGetResponse.response200(String body) =>
      _MailboxMessageGetResponse200.response200(body);

  void map(
      {@_i3.required _i2.ResponseMap<_MailboxMessageGetResponse200> on200}) {
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
  /// /// Message was deleted successfully.
  _MailboxMessageDeleteResponse200.response200() : status = 200;

  @override
  final int status;

  @override
  final _i2.OpenApiContentType contentType = null;

  @override
  Map<String, Object> propertiesToString() =>
      {'status': status, 'contentType': contentType};
}

abstract class MailboxMessageDeleteResponse extends _i2.OpenApiResponse
    implements _i2.HasSuccessResponse<void> {
  MailboxMessageDeleteResponse();

  /// /// Message was deleted successfully.
  factory MailboxMessageDeleteResponse.response200() =>
      _MailboxMessageDeleteResponse200.response200();

  void map(
      {@_i3.required _i2.ResponseMap<_MailboxMessageDeleteResponse200> on200}) {
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

class _MailboxMessageMarkReadResponse200
    extends MailboxMessageMarkReadResponse {
  /// /// Successfully marked as read.
  _MailboxMessageMarkReadResponse200.response200() : status = 200;

  @override
  final int status;

  @override
  final _i2.OpenApiContentType contentType = null;

  @override
  Map<String, Object> propertiesToString() =>
      {'status': status, 'contentType': contentType};
}

abstract class MailboxMessageMarkReadResponse extends _i2.OpenApiResponse
    implements _i2.HasSuccessResponse<void> {
  MailboxMessageMarkReadResponse();

  /// /// Successfully marked as read.
  factory MailboxMessageMarkReadResponse.response200() =>
      _MailboxMessageMarkReadResponse200.response200();

  void map(
      {@_i3.required
          _i2.ResponseMap<_MailboxMessageMarkReadResponse200> on200}) {
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
  /// /// Successfully marked as unread.
  _MailboxMessageMarkUnReadResponse200.response200() : status = 200;

  @override
  final int status;

  @override
  final _i2.OpenApiContentType contentType = null;

  @override
  Map<String, Object> propertiesToString() =>
      {'status': status, 'contentType': contentType};
}

abstract class MailboxMessageMarkUnReadResponse extends _i2.OpenApiResponse
    implements _i2.HasSuccessResponse<void> {
  MailboxMessageMarkUnReadResponse();

  /// /// Successfully marked as unread.
  factory MailboxMessageMarkUnReadResponse.response200() =>
      _MailboxMessageMarkUnReadResponse200.response200();

  void map(
      {@_i3.required
          _i2.ResponseMap<_MailboxMessageMarkUnReadResponse200> on200}) {
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
  /// /// Received and delivered successfully.
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
  /// /// Delivery not accepted.
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

abstract class EmailReceivePostResponse extends _i2.OpenApiResponse
    implements _i2.HasSuccessResponse<void> {
  EmailReceivePostResponse();

  /// /// Received and delivered successfully.
  factory EmailReceivePostResponse.response200() =>
      _EmailReceivePostResponse200.response200();

  /// /// Delivery not accepted.
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

abstract class AuthPassCloud implements _i2.ApiEndpoint {
  /// Health check.
  /// Health check of endpoint data
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
      {String pageToken, String sinceToken});

  /// Apply the given update to all matching mails.
  /// post: /mail/massupdate
  Future<MailMassupdatePostResponse> mailMassupdatePost(
      MailMassupdatePostSchema body);

  /// Update information about mailbox
  /// put: /mailbox/update/{mailboxAddress}
  Future<MailboxUpdateResponse> mailboxUpdate(MailboxUpdateSchema body,
      {@_i3.required String mailboxAddress});

  /// Fetch raw email message.
  /// get: /mailbox/message/{messageId}
  Future<MailboxMessageGetResponse> mailboxMessageGet(
      {@_i3.required String messageId});

  /// Delete the given message.
  /// delete: /mailbox/message/{messageId}
  Future<MailboxMessageDeleteResponse> mailboxMessageDelete(
      {@_i3.required String messageId});

  /// Mark message as read
  /// put: /mailbox/message/{messageId}/read
  Future<MailboxMessageMarkReadResponse> mailboxMessageMarkRead(
      {@_i3.required String messageId});

  /// Mark message as unread (again)
  /// delete: /mailbox/message/{messageId}/read
  Future<MailboxMessageMarkUnReadResponse> mailboxMessageMarkUnRead(
      {@_i3.required String messageId});

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
  /// Health check of endpoint data
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
      {String pageToken, String sinceToken});

  /// Apply the given update to all matching mails.
  /// post: /mail/massupdate
  ///
  Future<MailMassupdatePostResponse> mailMassupdatePost(
      MailMassupdatePostSchema body);

  /// Update information about mailbox
  /// put: /mailbox/update/{mailboxAddress}
  ///
  Future<MailboxUpdateResponse> mailboxUpdate(MailboxUpdateSchema body,
      {@_i3.required String mailboxAddress});

  /// Fetch raw email message.
  /// get: /mailbox/message/{messageId}
  ///
  Future<MailboxMessageGetResponse> mailboxMessageGet(
      {@_i3.required String messageId});

  /// Delete the given message.
  /// delete: /mailbox/message/{messageId}
  ///
  Future<MailboxMessageDeleteResponse> mailboxMessageDelete(
      {@_i3.required String messageId});

  /// Mark message as read
  /// put: /mailbox/message/{messageId}/read
  ///
  Future<MailboxMessageMarkReadResponse> mailboxMessageMarkRead(
      {@_i3.required String messageId});

  /// Mark message as unread (again)
  /// delete: /mailbox/message/{messageId}/read
  ///
  Future<MailboxMessageMarkUnReadResponse> mailboxMessageMarkUnRead(
      {@_i3.required String messageId});

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
  /// Health check of endpoint data
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
      EmailConfirmPostSchema body) async {
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

  /// Get status of the user account.
  /// get: /status
  ///
  @override
  Future<StatusGetResponse> statusGet() async {
    final request = _i2.OpenApiClientRequest('get', '/status', [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    return await sendRequest(request, {
      '200': (_i2.OpenApiClientResponse response) async =>
          _StatusGetResponse200.response200(StatusGetResponseBody200.fromJson(
              await response.responseBodyJson()))
    });
  }

  /// List of all mailboxes of the current user.
  /// get: /mailbox
  ///
  @override
  Future<MailboxGetResponse> mailboxGet() async {
    final request = _i2.OpenApiClientRequest('get', '/mailbox', [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    return await sendRequest(request, {
      '200': (_i2.OpenApiClientResponse response) async =>
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

  /// List all emails in all mailboxes of the current user.
  ///
  /// get: /mailbox/list
  ///
  /// * [pageToken]: Page token as returned by Page
  /// * [sinceToken]: As returned from a previous page object for a finished sync.
  @override
  Future<MailboxListGetResponse> mailboxListGet(
      {String pageToken, String sinceToken}) async {
    final request = _i2.OpenApiClientRequest('get', '/mailbox/list', [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addQueryParameter('page_token', encodeString(pageToken));
    request.addQueryParameter('since_token', encodeString(sinceToken));
    return await sendRequest(request, {
      '200': (_i2.OpenApiClientResponse response) async =>
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
    final request = _i2.OpenApiClientRequest('post', '/mail/massupdate', [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.setHeader('content-type', 'application/json');
    request.setBody(_i2.OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(request, {
      '200': (_i2.OpenApiClientResponse response) async =>
          _MailMassupdatePostResponse200.response200()
    });
  }

  /// Update information about mailbox
  /// put: /mailbox/update/{mailboxAddress}
  ///
  @override
  Future<MailboxUpdateResponse> mailboxUpdate(MailboxUpdateSchema body,
      {@_i3.required String mailboxAddress}) async {
    final request =
        _i2.OpenApiClientRequest('put', '/mailbox/update/{mailboxAddress}', [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addPathParameter('mailboxAddress', encodeString(mailboxAddress));
    request.setHeader('content-type', 'application/json');
    request.setBody(_i2.OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(request, {
      '200': (_i2.OpenApiClientResponse response) async =>
          _MailboxUpdateResponse200.response200()
    });
  }

  /// Fetch raw email message.
  /// get: /mailbox/message/{messageId}
  ///
  @override
  Future<MailboxMessageGetResponse> mailboxMessageGet(
      {@_i3.required String messageId}) async {
    final request =
        _i2.OpenApiClientRequest('get', '/mailbox/message/{messageId}', [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addPathParameter('messageId', encodeString(messageId));
    return await sendRequest(request, {
      '200': (_i2.OpenApiClientResponse response) async =>
          _MailboxMessageGetResponse200.response200(
              await response.responseBodyString())
    });
  }

  /// Delete the given message.
  /// delete: /mailbox/message/{messageId}
  ///
  @override
  Future<MailboxMessageDeleteResponse> mailboxMessageDelete(
      {@_i3.required String messageId}) async {
    final request =
        _i2.OpenApiClientRequest('delete', '/mailbox/message/{messageId}', [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addPathParameter('messageId', encodeString(messageId));
    return await sendRequest(request, {
      '200': (_i2.OpenApiClientResponse response) async =>
          _MailboxMessageDeleteResponse200.response200()
    });
  }

  /// Mark message as read
  /// put: /mailbox/message/{messageId}/read
  ///
  @override
  Future<MailboxMessageMarkReadResponse> mailboxMessageMarkRead(
      {@_i3.required String messageId}) async {
    final request =
        _i2.OpenApiClientRequest('put', '/mailbox/message/{messageId}/read', [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addPathParameter('messageId', encodeString(messageId));
    return await sendRequest(request, {
      '200': (_i2.OpenApiClientResponse response) async =>
          _MailboxMessageMarkReadResponse200.response200()
    });
  }

  /// Mark message as unread (again)
  /// delete: /mailbox/message/{messageId}/read
  ///
  @override
  Future<MailboxMessageMarkUnReadResponse> mailboxMessageMarkUnRead(
      {@_i3.required String messageId}) async {
    final request = _i2.OpenApiClientRequest(
        'delete', '/mailbox/message/{messageId}/read', [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addPathParameter('messageId', encodeString(messageId));
    return await sendRequest(request, {
      '200': (_i2.OpenApiClientResponse response) async =>
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
  /// Health check of endpoint data
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

  /// Get status of the user account.
  /// get: /status
  ///
  _i2.OpenApiClientRequest statusGet() {
    final request = _i2.OpenApiClientRequest('get', '/status', [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    return request;
  }

  /// List of all mailboxes of the current user.
  /// get: /mailbox
  ///
  _i2.OpenApiClientRequest mailboxGet() {
    final request = _i2.OpenApiClientRequest('get', '/mailbox', [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
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

  /// List all emails in all mailboxes of the current user.
  ///
  /// get: /mailbox/list
  ///
  /// * [pageToken]: Page token as returned by Page
  /// * [sinceToken]: As returned from a previous page object for a finished sync.
  _i2.OpenApiClientRequest mailboxListGet(
      {String pageToken, String sinceToken}) {
    final request = _i2.OpenApiClientRequest('get', '/mailbox/list', [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addQueryParameter('page_token', encodeString(pageToken));
    request.addQueryParameter('since_token', encodeString(sinceToken));
    return request;
  }

  /// Apply the given update to all matching mails.
  /// post: /mail/massupdate
  ///
  _i2.OpenApiClientRequest mailMassupdatePost() {
    final request = _i2.OpenApiClientRequest('post', '/mail/massupdate', [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    return request;
  }

  /// Update information about mailbox
  /// put: /mailbox/update/{mailboxAddress}
  ///
  _i2.OpenApiClientRequest mailboxUpdate(
      {@_i3.required String mailboxAddress}) {
    final request =
        _i2.OpenApiClientRequest('put', '/mailbox/update/{mailboxAddress}', [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addPathParameter('mailboxAddress', encodeString(mailboxAddress));
    return request;
  }

  /// Fetch raw email message.
  /// get: /mailbox/message/{messageId}
  ///
  _i2.OpenApiClientRequest mailboxMessageGet({@_i3.required String messageId}) {
    final request =
        _i2.OpenApiClientRequest('get', '/mailbox/message/{messageId}', [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addPathParameter('messageId', encodeString(messageId));
    return request;
  }

  /// Delete the given message.
  /// delete: /mailbox/message/{messageId}
  ///
  _i2.OpenApiClientRequest mailboxMessageDelete(
      {@_i3.required String messageId}) {
    final request =
        _i2.OpenApiClientRequest('delete', '/mailbox/message/{messageId}', [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addPathParameter('messageId', encodeString(messageId));
    return request;
  }

  /// Mark message as read
  /// put: /mailbox/message/{messageId}/read
  ///
  _i2.OpenApiClientRequest mailboxMessageMarkRead(
      {@_i3.required String messageId}) {
    final request =
        _i2.OpenApiClientRequest('put', '/mailbox/message/{messageId}/read', [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addPathParameter('messageId', encodeString(messageId));
    return request;
  }

  /// Mark message as unread (again)
  /// delete: /mailbox/message/{messageId}/read
  ///
  _i2.OpenApiClientRequest mailboxMessageMarkUnRead(
      {@_i3.required String messageId}) {
    final request = _i2.OpenApiClientRequest(
        'delete', '/mailbox/message/{messageId}/read', [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    request.addPathParameter('messageId', encodeString(messageId));
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
              token: param(
                  isRequired: true,
                  name: 'token',
                  value: request.queryParameter('token'),
                  decode: (value) => paramToString(value))));
    }, security: []);
    addRoute('/email/confirm', 'post', (_i2.OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.emailConfirmPost(
              EmailConfirmPostSchema.fromJson(
                  await request.readUrlEncodedBodyFlat())));
    }, security: []);
    addRoute('/status', 'get', (_i2.OpenApiRequest request) async {
      return await impl.invoke(
          request, (AuthPassCloud impl) async => impl.statusGet());
    }, security: [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    addRoute('/mailbox', 'get', (_i2.OpenApiRequest request) async {
      return await impl.invoke(
          request, (AuthPassCloud impl) async => impl.mailboxGet());
    }, security: [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    addRoute('/mailbox/create', 'post', (_i2.OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailboxCreatePost(
              MailboxCreatePostSchema.fromJson(await request.readJsonBody())));
    }, security: [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    addRoute('/mailbox/list', 'get', (_i2.OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailboxListGet(
              pageToken: param(
                  isRequired: false,
                  name: 'page_token',
                  value: request.queryParameter('page_token'),
                  decode: (value) => paramToString(value)),
              sinceToken: param(
                  isRequired: false,
                  name: 'since_token',
                  value: request.queryParameter('since_token'),
                  decode: (value) => paramToString(value))));
    }, security: [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    addRoute('/mail/massupdate', 'post', (_i2.OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailMassupdatePost(
              MailMassupdatePostSchema.fromJson(await request.readJsonBody())));
    }, security: [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    addRoute('/mailbox/update/{mailboxAddress}', 'put',
        (_i2.OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailboxUpdate(
              MailboxUpdateSchema.fromJson(await request.readJsonBody()),
              mailboxAddress: param(
                  isRequired: true,
                  name: 'mailboxAddress',
                  value: request.pathParameter('mailboxAddress'),
                  decode: (value) => paramToString(value))));
    }, security: [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    addRoute('/mailbox/message/{messageId}', 'get',
        (_i2.OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailboxMessageGet(
              messageId: param(
                  isRequired: true,
                  name: 'messageId',
                  value: request.pathParameter('messageId'),
                  decode: (value) => paramToString(value))));
    }, security: [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    addRoute('/mailbox/message/{messageId}', 'delete',
        (_i2.OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailboxMessageDelete(
              messageId: param(
                  isRequired: true,
                  name: 'messageId',
                  value: request.pathParameter('messageId'),
                  decode: (value) => paramToString(value))));
    }, security: [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    addRoute('/mailbox/message/{messageId}/read', 'put',
        (_i2.OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailboxMessageMarkRead(
              messageId: param(
                  isRequired: true,
                  name: 'messageId',
                  value: request.pathParameter('messageId'),
                  decode: (value) => paramToString(value))));
    }, security: [
      _i2.SecurityRequirement(schemes: [
        _i2.SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken, scopes: [])
      ])
    ]);
    addRoute('/mailbox/message/{messageId}/read', 'delete',
        (_i2.OpenApiRequest request) async {
      return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailboxMessageMarkUnRead(
              messageId: param(
                  isRequired: true,
                  name: 'messageId',
                  value: request.pathParameter('messageId'),
                  decode: (value) => paramToString(value))));
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
              xAuthpassToken: param(
                  isRequired: true,
                  name: 'x-authpass-token',
                  value: request.headerParameter('x-authpass-token'),
                  decode: (value) => paramToString(value))));
    }, security: []);
  }
}

class SecuritySchemes {
  static final authToken =
      _i2.SecuritySchemeHttp(scheme: _i2.SecuritySchemeHttpScheme.bearer);
}