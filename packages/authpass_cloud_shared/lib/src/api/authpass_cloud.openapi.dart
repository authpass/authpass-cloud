// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_initializing_formals, library_private_types_in_public_api

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i1;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:openapi_base/openapi_base.dart';
part 'authpass_cloud.openapi.g.dart';

@JsonSerializable()
@ApiUuidJsonConverter()
class SystemStatusUser implements OpenApiContent {
  SystemStatusUser({
    required this.emailConfirmed,
    required this.userConfirmed,
    required this.emailUnconfirmed,
  });

  factory SystemStatusUser.fromJson(Map<String, dynamic> jsonMap) =>
      _$SystemStatusUserFromJson(jsonMap);

  @JsonKey(
    name: 'emailConfirmed',
    includeIfNull: false,
  )
  final int emailConfirmed;

  @JsonKey(
    name: 'userConfirmed',
    includeIfNull: false,
  )
  final int userConfirmed;

  @JsonKey(
    name: 'emailUnconfirmed',
    includeIfNull: false,
  )
  final int emailUnconfirmed;

  Map<String, dynamic> toJson() => _$SystemStatusUserToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
@ApiUuidJsonConverter()
class SystemStatusWebsite implements OpenApiContent {
  SystemStatusWebsite({
    required this.websiteCount,
    required this.urlCanonicalCount,
  });

  factory SystemStatusWebsite.fromJson(Map<String, dynamic> jsonMap) =>
      _$SystemStatusWebsiteFromJson(jsonMap);

  @JsonKey(
    name: 'websiteCount',
    includeIfNull: false,
  )
  final int websiteCount;

  @JsonKey(
    name: 'urlCanonicalCount',
    includeIfNull: false,
  )
  final int urlCanonicalCount;

  Map<String, dynamic> toJson() => _$SystemStatusWebsiteToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
@ApiUuidJsonConverter()
class SystemStatusMailbox implements OpenApiContent {
  SystemStatusMailbox({
    required this.mailboxCount,
    required this.messageCount,
    required this.messageReadCount,
  });

  factory SystemStatusMailbox.fromJson(Map<String, dynamic> jsonMap) =>
      _$SystemStatusMailboxFromJson(jsonMap);

  @JsonKey(
    name: 'mailboxCount',
    includeIfNull: false,
  )
  final int mailboxCount;

  @JsonKey(
    name: 'messageCount',
    includeIfNull: false,
  )
  final int messageCount;

  @JsonKey(
    name: 'messageReadCount',
    includeIfNull: false,
  )
  final int messageReadCount;

  Map<String, dynamic> toJson() => _$SystemStatusMailboxToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
@ApiUuidJsonConverter()
class SystemStatusFileCloud implements OpenApiContent {
  SystemStatusFileCloud({
    required this.fileCount,
    required this.fileTotalLength,
    required this.fileContentCount,
    required this.attachmentLength,
    required this.attachmentCount,
    required this.attachmentUntouchedMonth,
    required this.countRecentlyAccessed,
    required this.countWeekAccessed,
  });

  factory SystemStatusFileCloud.fromJson(Map<String, dynamic> jsonMap) =>
      _$SystemStatusFileCloudFromJson(jsonMap);

  @JsonKey(
    name: 'fileCount',
    includeIfNull: false,
  )
  final int fileCount;

  @JsonKey(
    name: 'fileTotalLength',
    includeIfNull: false,
  )
  final int fileTotalLength;

  @JsonKey(
    name: 'fileContentCount',
    includeIfNull: false,
  )
  final int fileContentCount;

  @JsonKey(
    name: 'attachmentLength',
    includeIfNull: false,
  )
  final int attachmentLength;

  @JsonKey(
    name: 'attachmentCount',
    includeIfNull: false,
  )
  final int attachmentCount;

  @JsonKey(
    name: 'attachmentUntouchedMonth',
    includeIfNull: false,
  )
  final int attachmentUntouchedMonth;

  /// Number of files accessed in the last 24 hours, but are older than 48 hours.
  @JsonKey(
    name: 'countRecentlyAccessed',
    includeIfNull: false,
  )
  final int countRecentlyAccessed;

  /// Number of files older than 14 days, accessed within the last 7 days.
  @JsonKey(
    name: 'countWeekAccessed',
    includeIfNull: false,
  )
  final int countWeekAccessed;

  Map<String, dynamic> toJson() => _$SystemStatusFileCloudToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
@ApiUuidJsonConverter()
class SystemStatus implements OpenApiContent {
  SystemStatus({
    required this.user,
    required this.website,
    required this.mailbox,
    required this.fileCloud,
    required this.queryTime,
  });

  factory SystemStatus.fromJson(Map<String, dynamic> jsonMap) =>
      _$SystemStatusFromJson(jsonMap);

  @JsonKey(
    name: 'user',
    includeIfNull: false,
  )
  final SystemStatusUser user;

  @JsonKey(
    name: 'website',
    includeIfNull: false,
  )
  final SystemStatusWebsite website;

  @JsonKey(
    name: 'mailbox',
    includeIfNull: false,
  )
  final SystemStatusMailbox mailbox;

  @JsonKey(
    name: 'fileCloud',
    includeIfNull: false,
  )
  final SystemStatusFileCloud fileCloud;

  @JsonKey(
    name: 'queryTime',
    includeIfNull: false,
  )
  final int queryTime;

  Map<String, dynamic> toJson() => _$SystemStatusToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
@ApiUuidJsonConverter()
class UserEmail implements OpenApiContent {
  UserEmail({
    required this.address,
    required this.confirmedAt,
  });

  factory UserEmail.fromJson(Map<String, dynamic> jsonMap) =>
      _$UserEmailFromJson(jsonMap);

  @JsonKey(
    name: 'address',
    includeIfNull: false,
  )
  final String address;

  @JsonKey(
    name: 'confirmedAt',
    includeIfNull: false,
  )
  final DateTime confirmedAt;

  Map<String, dynamic> toJson() => _$UserEmailToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
@ApiUuidJsonConverter()
class UserInfo implements OpenApiContent {
  UserInfo({required this.emails});

  factory UserInfo.fromJson(Map<String, dynamic> jsonMap) =>
      _$UserInfoFromJson(jsonMap);

  @JsonKey(
    name: 'emails',
    includeIfNull: false,
  )
  final List<UserEmail> emails;

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
@ApiUuidJsonConverter()
class RegisterRequest implements OpenApiContent {
  RegisterRequest({required this.email});

  factory RegisterRequest.fromJson(Map<String, dynamic> jsonMap) =>
      _$RegisterRequestFromJson(jsonMap);

  /// Email address for the current user.
  @JsonKey(
    name: 'email',
    includeIfNull: false,
  )
  final String email;

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);

  @override
  String toString() => toJson().toString();
}

enum RegisterResponseStatus {
  @JsonValue('created')
  created,
  @JsonValue('confirmed')
  confirmed,
}

extension RegisterResponseStatusExt on RegisterResponseStatus {
  static final Map<String, RegisterResponseStatus> _names = {
    'created': RegisterResponseStatus.created,
    'confirmed': RegisterResponseStatus.confirmed,
  };
  static RegisterResponseStatus fromName(String name) =>
      _names[name] ??
      _throwStateError('Invalid enum name: $name for RegisterResponseStatus');
  String get name => toString().substring(23);
}

@JsonSerializable()
@ApiUuidJsonConverter()
class RegisterResponse implements OpenApiContent {
  RegisterResponse({
    required this.userUuid,
    required this.authToken,
    required this.status,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> jsonMap) =>
      _$RegisterResponseFromJson(jsonMap);

  /// Uuid of the newly registered user.
  @JsonKey(
    name: 'userUuid',
    includeIfNull: false,
  )
  final String userUuid;

  /// Auth token which can be used for authentication, once email is confirmed.
  @JsonKey(
    name: 'authToken',
    includeIfNull: false,
  )
  final String authToken;

  /// Status of the user and auth token (created or confirmed).
  @JsonKey(
    name: 'status',
    includeIfNull: false,
  )
  final RegisterResponseStatus status;

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
@ApiUuidJsonConverter()
class Page implements OpenApiContent {
  Page({
    this.nextPageToken,
    this.sinceToken,
  });

  factory Page.fromJson(Map<String, dynamic> jsonMap) =>
      _$PageFromJson(jsonMap);

  /// Token for the next page, might be null if there are no more pages.
  @JsonKey(
    name: 'nextPageToken',
    includeIfNull: false,
  )
  final String? nextPageToken;

  /// Once everything is synced, this token can be used for subsequent syncs.
  @JsonKey(
    name: 'sinceToken',
    includeIfNull: false,
  )
  final String? sinceToken;

  Map<String, dynamic> toJson() => _$PageToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
@ApiUuidJsonConverter()
class EmailMessage implements OpenApiContent {
  EmailMessage({
    required this.id,
    required this.subject,
    required this.sender,
    required this.mailboxEntryUuid,
    required this.createdAt,
    required this.size,
    required this.isRead,
  });

  factory EmailMessage.fromJson(Map<String, dynamic> jsonMap) =>
      _$EmailMessageFromJson(jsonMap);

  @JsonKey(
    name: 'id',
    includeIfNull: false,
  )
  @ApiUuidJsonConverter()
  final ApiUuid id;

  @JsonKey(
    name: 'subject',
    includeIfNull: false,
  )
  final String subject;

  @JsonKey(
    name: 'sender',
    includeIfNull: false,
  )
  final String sender;

  @JsonKey(
    name: 'mailboxEntryUuid',
    includeIfNull: false,
  )
  @ApiUuidJsonConverter()
  final ApiUuid mailboxEntryUuid;

  @JsonKey(
    name: 'createdAt',
    includeIfNull: false,
  )
  final DateTime createdAt;

  /// Body size in bytes.
  @JsonKey(
    name: 'size',
    includeIfNull: false,
  )
  final int size;

  /// true if this mail was marked as read.
  @JsonKey(
    name: 'isRead',
    includeIfNull: false,
  )
  final bool isRead;

  Map<String, dynamic> toJson() => _$EmailMessageToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
@ApiUuidJsonConverter()
class Mailbox implements OpenApiContent {
  Mailbox({
    required this.id,
    required this.address,
    required this.label,
    required this.entryUuid,
    required this.createdAt,
    required this.isDisabled,
  });

  factory Mailbox.fromJson(Map<String, dynamic> jsonMap) =>
      _$MailboxFromJson(jsonMap);

  @JsonKey(
    name: 'id',
    includeIfNull: false,
  )
  @ApiUuidJsonConverter()
  final ApiUuid id;

  /// Unique email address (a@example.com)
  @JsonKey(
    name: 'address',
    includeIfNull: false,
  )
  final String address;

  /// Label as given during create. (Can be empty string)
  @JsonKey(
    name: 'label',
    includeIfNull: false,
  )
  final String label;

  /// Entry uuid given during create. (Can be empty string)
  @JsonKey(
    name: 'entryUuid',
    includeIfNull: false,
  )
  final String entryUuid;

  @JsonKey(
    name: 'createdAt',
    includeIfNull: false,
  )
  final DateTime createdAt;

  @JsonKey(
    name: 'isDisabled',
    includeIfNull: false,
  )
  final bool isDisabled;

  Map<String, dynamic> toJson() => _$MailboxToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
@ApiUuidJsonConverter()
class FileInfo implements OpenApiContent {
  FileInfo({
    required this.fileToken,
    required this.versionToken,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.readOnly,
    required this.size,
  });

  factory FileInfo.fromJson(Map<String, dynamic> jsonMap) =>
      _$FileInfoFromJson(jsonMap);

  @JsonKey(
    name: 'fileToken',
    includeIfNull: false,
  )
  final String fileToken;

  @JsonKey(
    name: 'versionToken',
    includeIfNull: false,
  )
  final String versionToken;

  @JsonKey(
    name: 'name',
    includeIfNull: false,
  )
  final String name;

  @JsonKey(
    name: 'createdAt',
    includeIfNull: false,
  )
  final DateTime createdAt;

  @JsonKey(
    name: 'updatedAt',
    includeIfNull: false,
  )
  final DateTime updatedAt;

  @JsonKey(
    name: 'readOnly',
    includeIfNull: false,
  )
  final bool readOnly;

  @JsonKey(
    name: 'size',
    includeIfNull: false,
  )
  final int size;

  Map<String, dynamic> toJson() => _$FileInfoToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
@ApiUuidJsonConverter()
class FileListResponse implements OpenApiContent {
  FileListResponse({required this.files});

  factory FileListResponse.fromJson(Map<String, dynamic> jsonMap) =>
      _$FileListResponseFromJson(jsonMap);

  @JsonKey(
    name: 'files',
    includeIfNull: false,
  )
  final List<FileInfo> files;

  Map<String, dynamic> toJson() => _$FileListResponseToJson(this);

  @override
  String toString() => toJson().toString();
}

/// Object wrapping a [attachmentToken].
@JsonSerializable()
@ApiUuidJsonConverter()
class AttachmentId implements OpenApiContent {
  AttachmentId({required this.attachmentToken});

  factory AttachmentId.fromJson(Map<String, dynamic> jsonMap) =>
      _$AttachmentIdFromJson(jsonMap);

  @JsonKey(
    name: 'attachmentToken',
    includeIfNull: false,
  )
  final String attachmentToken;

  Map<String, dynamic> toJson() => _$AttachmentIdToJson(this);

  @override
  String toString() => toJson().toString();
}

/// Object wrapping a [fileToken].
@JsonSerializable()
@ApiUuidJsonConverter()
class FileId implements OpenApiContent {
  FileId({required this.fileToken});

  factory FileId.fromJson(Map<String, dynamic> jsonMap) =>
      _$FileIdFromJson(jsonMap);

  @JsonKey(
    name: 'fileToken',
    includeIfNull: false,
  )
  final String fileToken;

  Map<String, dynamic> toJson() => _$FileIdToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
@ApiUuidJsonConverter()
class AttachmentTouch implements OpenApiContent {
  AttachmentTouch({
    required this.file,
    required this.attachmentTokens,
  });

  factory AttachmentTouch.fromJson(Map<String, dynamic> jsonMap) =>
      _$AttachmentTouchFromJson(jsonMap);

  /// Object wrapping a [fileToken].
  @JsonKey(
    name: 'file',
    includeIfNull: false,
  )
  final FileId file;

  @JsonKey(
    name: 'attachmentTokens',
    includeIfNull: false,
  )
  final List<String> attachmentTokens;

  Map<String, dynamic> toJson() => _$AttachmentTouchToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
@ApiUuidJsonConverter()
class FileTokenInfo implements OpenApiContent {
  FileTokenInfo({
    required this.fileToken,
    required this.createdAt,
    required this.label,
    required this.readOnly,
  });

  factory FileTokenInfo.fromJson(Map<String, dynamic> jsonMap) =>
      _$FileTokenInfoFromJson(jsonMap);

  @JsonKey(
    name: 'fileToken',
    includeIfNull: false,
  )
  final String fileToken;

  @JsonKey(
    name: 'createdAt',
    includeIfNull: false,
  )
  final DateTime createdAt;

  @JsonKey(
    name: 'label',
    includeIfNull: false,
  )
  final String label;

  @JsonKey(
    name: 'readOnly',
    includeIfNull: false,
  )
  final bool readOnly;

  Map<String, dynamic> toJson() => _$FileTokenInfoToJson(this);

  @override
  String toString() => toJson().toString();
}

class CheckGetResponse200 extends CheckGetResponse {
  /// Everything OK
  CheckGetResponse200.response200() : status = 200;

  @override
  final int status;

  @override
  final OpenApiContentType? contentType = null;

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'contentType': contentType,
      };
}

sealed class CheckGetResponse extends OpenApiResponse
    implements HasSuccessResponse<void> {
  CheckGetResponse();

  /// Everything OK
  factory CheckGetResponse.response200() => CheckGetResponse200.response200();

  R map<R>({
    required ResponseMap<CheckGetResponse200, R> on200,
    ResponseMap<CheckGetResponse, R>? onElse,
  }) {
    if (this is CheckGetResponse200) {
      return on200((this as CheckGetResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  Everything OK
  @override
  void requireSuccess() {
    if (this is CheckGetResponse200) {
      return;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class CheckStatusPostResponse200 extends CheckStatusPostResponse
    implements OpenApiResponseBodyJson {
  /// Status
  CheckStatusPostResponse200.response200(this.body)
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
        'contentType': contentType,
      };
}

sealed class CheckStatusPostResponse extends OpenApiResponse
    implements HasSuccessResponse<SystemStatus> {
  CheckStatusPostResponse();

  /// Status
  factory CheckStatusPostResponse.response200(SystemStatus body) =>
      CheckStatusPostResponse200.response200(body);

  R map<R>({
    required ResponseMap<CheckStatusPostResponse200, R> on200,
    ResponseMap<CheckStatusPostResponse, R>? onElse,
  }) {
    if (this is CheckStatusPostResponse200) {
      return on200((this as CheckStatusPostResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  Status
  @override
  SystemStatus requireSuccess() {
    if (this is CheckStatusPostResponse200) {
      return (this as CheckStatusPostResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class UserGetResponse200 extends UserGetResponse
    implements OpenApiResponseBodyJson {
  /// OK
  UserGetResponse200.response200(this.body)
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
        'contentType': contentType,
      };
}

sealed class UserGetResponse extends OpenApiResponse
    implements HasSuccessResponse<UserInfo> {
  UserGetResponse();

  /// OK
  factory UserGetResponse.response200(UserInfo body) =>
      UserGetResponse200.response200(body);

  R map<R>({
    required ResponseMap<UserGetResponse200, R> on200,
    ResponseMap<UserGetResponse, R>? onElse,
  }) {
    if (this is UserGetResponse200) {
      return on200((this as UserGetResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  OK
  @override
  UserInfo requireSuccess() {
    if (this is UserGetResponse200) {
      return (this as UserGetResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class UserRegisterPostResponse200 extends UserRegisterPostResponse
    implements OpenApiResponseBodyJson {
  /// OK
  UserRegisterPostResponse200.response200(this.body)
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
        'contentType': contentType,
      };
}

sealed class UserRegisterPostResponse extends OpenApiResponse
    implements HasSuccessResponse<RegisterResponse> {
  UserRegisterPostResponse();

  /// OK
  factory UserRegisterPostResponse.response200(RegisterResponse body) =>
      UserRegisterPostResponse200.response200(body);

  R map<R>({
    required ResponseMap<UserRegisterPostResponse200, R> on200,
    ResponseMap<UserRegisterPostResponse, R>? onElse,
  }) {
    if (this is UserRegisterPostResponse200) {
      return on200((this as UserRegisterPostResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  OK
  @override
  RegisterResponse requireSuccess() {
    if (this is UserRegisterPostResponse200) {
      return (this as UserRegisterPostResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

enum EmailStatusGetResponseBody200Status {
  @JsonValue('created')
  created,
  @JsonValue('confirmed')
  confirmed,
}

extension EmailStatusGetResponseBody200StatusExt
    on EmailStatusGetResponseBody200Status {
  static final Map<String, EmailStatusGetResponseBody200Status> _names = {
    'created': EmailStatusGetResponseBody200Status.created,
    'confirmed': EmailStatusGetResponseBody200Status.confirmed,
  };
  static EmailStatusGetResponseBody200Status fromName(String name) =>
      _names[name] ??
      _throwStateError(
          'Invalid enum name: $name for EmailStatusGetResponseBody200Status');
  String get name => toString().substring(36);
}

@JsonSerializable()
@ApiUuidJsonConverter()
class EmailStatusGetResponseBody200 implements OpenApiContent {
  EmailStatusGetResponseBody200({this.status});

  factory EmailStatusGetResponseBody200.fromJson(
          Map<String, dynamic> jsonMap) =>
      _$EmailStatusGetResponseBody200FromJson(jsonMap);

  @JsonKey(
    name: 'status',
    includeIfNull: false,
  )
  final EmailStatusGetResponseBody200Status? status;

  Map<String, dynamic> toJson() => _$EmailStatusGetResponseBody200ToJson(this);

  @override
  String toString() => toJson().toString();
}

class EmailStatusGetResponse200 extends EmailStatusGetResponse
    implements OpenApiResponseBodyJson {
  /// Whether it was confirmed or not.
  EmailStatusGetResponse200.response200(this.body)
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
        'contentType': contentType,
      };
}

sealed class EmailStatusGetResponse extends OpenApiResponse
    implements HasSuccessResponse<EmailStatusGetResponseBody200> {
  EmailStatusGetResponse();

  /// Whether it was confirmed or not.
  factory EmailStatusGetResponse.response200(
          EmailStatusGetResponseBody200 body) =>
      EmailStatusGetResponse200.response200(body);

  R map<R>({
    required ResponseMap<EmailStatusGetResponse200, R> on200,
    ResponseMap<EmailStatusGetResponse, R>? onElse,
  }) {
    if (this is EmailStatusGetResponse200) {
      return on200((this as EmailStatusGetResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  Whether it was confirmed or not.
  @override
  EmailStatusGetResponseBody200 requireSuccess() {
    if (this is EmailStatusGetResponse200) {
      return (this as EmailStatusGetResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class EmailConfirmGetResponse200 extends EmailConfirmGetResponse
    implements OpenApiResponseBodyString {
  /// OK
  EmailConfirmGetResponse200.response200(this.body) : status = 200;

  @override
  final int status;

  @override
  final String body;

  @override
  final OpenApiContentType contentType = OpenApiContentType.parse('text/html');

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'body': body,
        'contentType': contentType,
      };
}

class EmailConfirmGetResponse400 extends EmailConfirmGetResponse
    implements OpenApiResponseBodyString {
  /// Invalid token or email address.
  EmailConfirmGetResponse400.response400(this.body) : status = 400;

  @override
  final int status;

  @override
  final String body;

  @override
  final OpenApiContentType contentType = OpenApiContentType.parse('text/html');

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'body': body,
        'contentType': contentType,
      };
}

sealed class EmailConfirmGetResponse extends OpenApiResponse
    implements HasSuccessResponse<String> {
  EmailConfirmGetResponse();

  /// OK
  factory EmailConfirmGetResponse.response200(String body) =>
      EmailConfirmGetResponse200.response200(body);

  /// Invalid token or email address.
  factory EmailConfirmGetResponse.response400(String body) =>
      EmailConfirmGetResponse400.response400(body);

  R map<R>({
    required ResponseMap<EmailConfirmGetResponse200, R> on200,
    required ResponseMap<EmailConfirmGetResponse400, R> on400,
    ResponseMap<EmailConfirmGetResponse, R>? onElse,
  }) {
    if (this is EmailConfirmGetResponse200) {
      return on200((this as EmailConfirmGetResponse200));
    } else if (this is EmailConfirmGetResponse400) {
      return on400((this as EmailConfirmGetResponse400));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  OK
  @override
  String requireSuccess() {
    if (this is EmailConfirmGetResponse200) {
      return (this as EmailConfirmGetResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class EmailConfirmPostResponse200 extends EmailConfirmPostResponse
    implements OpenApiResponseBodyString {
  /// OK
  EmailConfirmPostResponse200.response200(this.body) : status = 200;

  @override
  final int status;

  @override
  final String body;

  @override
  final OpenApiContentType contentType = OpenApiContentType.parse('text/html');

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'body': body,
        'contentType': contentType,
      };
}

class EmailConfirmPostResponse400 extends EmailConfirmPostResponse {
  /// Invalid token or email address.
  EmailConfirmPostResponse400.response400() : status = 400;

  @override
  final int status;

  @override
  final OpenApiContentType? contentType = null;

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'contentType': contentType,
      };
}

sealed class EmailConfirmPostResponse extends OpenApiResponse
    implements HasSuccessResponse<String> {
  EmailConfirmPostResponse();

  /// OK
  factory EmailConfirmPostResponse.response200(String body) =>
      EmailConfirmPostResponse200.response200(body);

  /// Invalid token or email address.
  factory EmailConfirmPostResponse.response400() =>
      EmailConfirmPostResponse400.response400();

  R map<R>({
    required ResponseMap<EmailConfirmPostResponse200, R> on200,
    required ResponseMap<EmailConfirmPostResponse400, R> on400,
    ResponseMap<EmailConfirmPostResponse, R>? onElse,
  }) {
    if (this is EmailConfirmPostResponse200) {
      return on200((this as EmailConfirmPostResponse200));
    } else if (this is EmailConfirmPostResponse400) {
      return on400((this as EmailConfirmPostResponse400));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  OK
  @override
  String requireSuccess() {
    if (this is EmailConfirmPostResponse200) {
      return (this as EmailConfirmPostResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

@JsonSerializable()
@ApiUuidJsonConverter()
class EmailConfirmPostSchema implements OpenApiContent {
  EmailConfirmPostSchema({
    required this.token,
    required this.gRecaptchaResponse,
  });

  factory EmailConfirmPostSchema.fromJson(Map<String, dynamic> jsonMap) =>
      _$EmailConfirmPostSchemaFromJson(jsonMap);

  @JsonKey(
    name: 'token',
    includeIfNull: false,
  )
  final String token;

  @JsonKey(
    name: 'g-recaptcha-response',
    includeIfNull: false,
  )
  final String gRecaptchaResponse;

  Map<String, dynamic> toJson() => _$EmailConfirmPostSchemaToJson(this);

  @override
  String toString() => toJson().toString();
}

class UserDeleteGetResponse200 extends UserDeleteGetResponse
    implements OpenApiResponseBodyString {
  /// OK
  UserDeleteGetResponse200.response200(this.body) : status = 200;

  @override
  final int status;

  @override
  final String body;

  @override
  final OpenApiContentType contentType = OpenApiContentType.parse('text/html');

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'body': body,
        'contentType': contentType,
      };
}

sealed class UserDeleteGetResponse extends OpenApiResponse
    implements HasSuccessResponse<String> {
  UserDeleteGetResponse();

  /// OK
  factory UserDeleteGetResponse.response200(String body) =>
      UserDeleteGetResponse200.response200(body);

  R map<R>({
    required ResponseMap<UserDeleteGetResponse200, R> on200,
    ResponseMap<UserDeleteGetResponse, R>? onElse,
  }) {
    if (this is UserDeleteGetResponse200) {
      return on200((this as UserDeleteGetResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  OK
  @override
  String requireSuccess() {
    if (this is UserDeleteGetResponse200) {
      return (this as UserDeleteGetResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class UserDeletePostResponse200 extends UserDeletePostResponse
    implements OpenApiResponseBodyString {
  /// OK
  UserDeletePostResponse200.response200(this.body) : status = 200;

  @override
  final int status;

  @override
  final String body;

  @override
  final OpenApiContentType contentType = OpenApiContentType.parse('text/html');

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'body': body,
        'contentType': contentType,
      };
}

class UserDeletePostResponse404 extends UserDeletePostResponse {
  /// No user found with that email.
  UserDeletePostResponse404.response404() : status = 404;

  @override
  final int status;

  @override
  final OpenApiContentType? contentType = null;

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'contentType': contentType,
      };
}

sealed class UserDeletePostResponse extends OpenApiResponse
    implements HasSuccessResponse<String> {
  UserDeletePostResponse();

  /// OK
  factory UserDeletePostResponse.response200(String body) =>
      UserDeletePostResponse200.response200(body);

  /// No user found with that email.
  factory UserDeletePostResponse.response404() =>
      UserDeletePostResponse404.response404();

  R map<R>({
    required ResponseMap<UserDeletePostResponse200, R> on200,
    required ResponseMap<UserDeletePostResponse404, R> on404,
    ResponseMap<UserDeletePostResponse, R>? onElse,
  }) {
    if (this is UserDeletePostResponse200) {
      return on200((this as UserDeletePostResponse200));
    } else if (this is UserDeletePostResponse404) {
      return on404((this as UserDeletePostResponse404));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  OK
  @override
  String requireSuccess() {
    if (this is UserDeletePostResponse200) {
      return (this as UserDeletePostResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

@JsonSerializable()
@ApiUuidJsonConverter()
class UserDeletePostSchema implements OpenApiContent {
  UserDeletePostSchema({required this.email});

  factory UserDeletePostSchema.fromJson(Map<String, dynamic> jsonMap) =>
      _$UserDeletePostSchemaFromJson(jsonMap);

  @JsonKey(
    name: 'email',
    includeIfNull: false,
  )
  final String email;

  Map<String, dynamic> toJson() => _$UserDeletePostSchemaToJson(this);

  @override
  String toString() => toJson().toString();
}

class UserDeleteConfirmGetResponse200 extends UserDeleteConfirmGetResponse
    implements OpenApiResponseBodyString {
  /// OK
  UserDeleteConfirmGetResponse200.response200(this.body) : status = 200;

  @override
  final int status;

  @override
  final String body;

  @override
  final OpenApiContentType contentType = OpenApiContentType.parse('text/html');

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'body': body,
        'contentType': contentType,
      };
}

class UserDeleteConfirmGetResponse400 extends UserDeleteConfirmGetResponse
    implements OpenApiResponseBodyString {
  /// Invalid token or email address.
  UserDeleteConfirmGetResponse400.response400(this.body) : status = 400;

  @override
  final int status;

  @override
  final String body;

  @override
  final OpenApiContentType contentType = OpenApiContentType.parse('text/html');

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'body': body,
        'contentType': contentType,
      };
}

sealed class UserDeleteConfirmGetResponse extends OpenApiResponse
    implements HasSuccessResponse<String> {
  UserDeleteConfirmGetResponse();

  /// OK
  factory UserDeleteConfirmGetResponse.response200(String body) =>
      UserDeleteConfirmGetResponse200.response200(body);

  /// Invalid token or email address.
  factory UserDeleteConfirmGetResponse.response400(String body) =>
      UserDeleteConfirmGetResponse400.response400(body);

  R map<R>({
    required ResponseMap<UserDeleteConfirmGetResponse200, R> on200,
    required ResponseMap<UserDeleteConfirmGetResponse400, R> on400,
    ResponseMap<UserDeleteConfirmGetResponse, R>? onElse,
  }) {
    if (this is UserDeleteConfirmGetResponse200) {
      return on200((this as UserDeleteConfirmGetResponse200));
    } else if (this is UserDeleteConfirmGetResponse400) {
      return on400((this as UserDeleteConfirmGetResponse400));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  OK
  @override
  String requireSuccess() {
    if (this is UserDeleteConfirmGetResponse200) {
      return (this as UserDeleteConfirmGetResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class UserDeleteConfirmPostResponse200 extends UserDeleteConfirmPostResponse
    implements OpenApiResponseBodyString {
  /// OK
  UserDeleteConfirmPostResponse200.response200(this.body) : status = 200;

  @override
  final int status;

  @override
  final String body;

  @override
  final OpenApiContentType contentType = OpenApiContentType.parse('text/html');

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'body': body,
        'contentType': contentType,
      };
}

class UserDeleteConfirmPostResponse400 extends UserDeleteConfirmPostResponse {
  /// Invalid token or email address.
  UserDeleteConfirmPostResponse400.response400() : status = 400;

  @override
  final int status;

  @override
  final OpenApiContentType? contentType = null;

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'contentType': contentType,
      };
}

sealed class UserDeleteConfirmPostResponse extends OpenApiResponse
    implements HasSuccessResponse<String> {
  UserDeleteConfirmPostResponse();

  /// OK
  factory UserDeleteConfirmPostResponse.response200(String body) =>
      UserDeleteConfirmPostResponse200.response200(body);

  /// Invalid token or email address.
  factory UserDeleteConfirmPostResponse.response400() =>
      UserDeleteConfirmPostResponse400.response400();

  R map<R>({
    required ResponseMap<UserDeleteConfirmPostResponse200, R> on200,
    required ResponseMap<UserDeleteConfirmPostResponse400, R> on400,
    ResponseMap<UserDeleteConfirmPostResponse, R>? onElse,
  }) {
    if (this is UserDeleteConfirmPostResponse200) {
      return on200((this as UserDeleteConfirmPostResponse200));
    } else if (this is UserDeleteConfirmPostResponse400) {
      return on400((this as UserDeleteConfirmPostResponse400));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  OK
  @override
  String requireSuccess() {
    if (this is UserDeleteConfirmPostResponse200) {
      return (this as UserDeleteConfirmPostResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

@JsonSerializable()
@ApiUuidJsonConverter()
class UserDeleteConfirmPostSchema implements OpenApiContent {
  UserDeleteConfirmPostSchema({
    required this.token,
    required this.gRecaptchaResponse,
  });

  factory UserDeleteConfirmPostSchema.fromJson(Map<String, dynamic> jsonMap) =>
      _$UserDeleteConfirmPostSchemaFromJson(jsonMap);

  @JsonKey(
    name: 'token',
    includeIfNull: false,
  )
  final String token;

  @JsonKey(
    name: 'g-recaptcha-response',
    includeIfNull: false,
  )
  final String gRecaptchaResponse;

  Map<String, dynamic> toJson() => _$UserDeleteConfirmPostSchemaToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
@ApiUuidJsonConverter()
class StatusGetResponseBody200Mail implements OpenApiContent {
  StatusGetResponseBody200Mail({required this.messagesUnread});

  factory StatusGetResponseBody200Mail.fromJson(Map<String, dynamic> jsonMap) =>
      _$StatusGetResponseBody200MailFromJson(jsonMap);

  @JsonKey(
    name: 'messagesUnread',
    includeIfNull: false,
  )
  final int messagesUnread;

  Map<String, dynamic> toJson() => _$StatusGetResponseBody200MailToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
@ApiUuidJsonConverter()
class StatusGetResponseBody200 implements OpenApiContent {
  StatusGetResponseBody200({required this.mail});

  factory StatusGetResponseBody200.fromJson(Map<String, dynamic> jsonMap) =>
      _$StatusGetResponseBody200FromJson(jsonMap);

  @JsonKey(
    name: 'mail',
    includeIfNull: false,
  )
  final StatusGetResponseBody200Mail mail;

  Map<String, dynamic> toJson() => _$StatusGetResponseBody200ToJson(this);

  @override
  String toString() => toJson().toString();
}

class StatusGetResponse200 extends StatusGetResponse
    implements OpenApiResponseBodyJson {
  /// Information of the logged in account.
  StatusGetResponse200.response200(this.body)
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
        'contentType': contentType,
      };
}

sealed class StatusGetResponse extends OpenApiResponse
    implements HasSuccessResponse<StatusGetResponseBody200> {
  StatusGetResponse();

  /// Information of the logged in account.
  factory StatusGetResponse.response200(StatusGetResponseBody200 body) =>
      StatusGetResponse200.response200(body);

  R map<R>({
    required ResponseMap<StatusGetResponse200, R> on200,
    ResponseMap<StatusGetResponse, R>? onElse,
  }) {
    if (this is StatusGetResponse200) {
      return on200((this as StatusGetResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  Information of the logged in account.
  @override
  StatusGetResponseBody200 requireSuccess() {
    if (this is StatusGetResponse200) {
      return (this as StatusGetResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

@JsonSerializable()
@ApiUuidJsonConverter()
class MailboxGetResponseBody200 implements OpenApiContent {
  MailboxGetResponseBody200({this.data});

  factory MailboxGetResponseBody200.fromJson(Map<String, dynamic> jsonMap) =>
      _$MailboxGetResponseBody200FromJson(jsonMap);

  @JsonKey(
    name: 'data',
    includeIfNull: false,
  )
  final List<Mailbox>? data;

  Map<String, dynamic> toJson() => _$MailboxGetResponseBody200ToJson(this);

  @override
  String toString() => toJson().toString();
}

class MailboxGetResponse200 extends MailboxGetResponse
    implements OpenApiResponseBodyJson {
  /// On Success returns unpaginated list (right now) of all mailboxes.
  MailboxGetResponse200.response200(this.body)
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
        'contentType': contentType,
      };
}

sealed class MailboxGetResponse extends OpenApiResponse
    implements HasSuccessResponse<MailboxGetResponseBody200> {
  MailboxGetResponse();

  /// On Success returns unpaginated list (right now) of all mailboxes.
  factory MailboxGetResponse.response200(MailboxGetResponseBody200 body) =>
      MailboxGetResponse200.response200(body);

  R map<R>({
    required ResponseMap<MailboxGetResponse200, R> on200,
    ResponseMap<MailboxGetResponse, R>? onElse,
  }) {
    if (this is MailboxGetResponse200) {
      return on200((this as MailboxGetResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  On Success returns unpaginated list (right now) of all mailboxes.
  @override
  MailboxGetResponseBody200 requireSuccess() {
    if (this is MailboxGetResponse200) {
      return (this as MailboxGetResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

@JsonSerializable()
@ApiUuidJsonConverter()
class MailboxCreatePostResponseBody200 implements OpenApiContent {
  MailboxCreatePostResponseBody200({this.address});

  factory MailboxCreatePostResponseBody200.fromJson(
          Map<String, dynamic> jsonMap) =>
      _$MailboxCreatePostResponseBody200FromJson(jsonMap);

  /// The address of the new mailbox.
  @JsonKey(
    name: 'address',
    includeIfNull: false,
  )
  final String? address;

  Map<String, dynamic> toJson() =>
      _$MailboxCreatePostResponseBody200ToJson(this);

  @override
  String toString() => toJson().toString();
}

class MailboxCreatePostResponse200 extends MailboxCreatePostResponse
    implements OpenApiResponseBodyJson {
  /// Successfully created mailbox.
  MailboxCreatePostResponse200.response200(this.body)
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
        'contentType': contentType,
      };
}

sealed class MailboxCreatePostResponse extends OpenApiResponse
    implements HasSuccessResponse<MailboxCreatePostResponseBody200> {
  MailboxCreatePostResponse();

  /// Successfully created mailbox.
  factory MailboxCreatePostResponse.response200(
          MailboxCreatePostResponseBody200 body) =>
      MailboxCreatePostResponse200.response200(body);

  R map<R>({
    required ResponseMap<MailboxCreatePostResponse200, R> on200,
    ResponseMap<MailboxCreatePostResponse, R>? onElse,
  }) {
    if (this is MailboxCreatePostResponse200) {
      return on200((this as MailboxCreatePostResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  Successfully created mailbox.
  @override
  MailboxCreatePostResponseBody200 requireSuccess() {
    if (this is MailboxCreatePostResponse200) {
      return (this as MailboxCreatePostResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

@JsonSerializable()
@ApiUuidJsonConverter()
class MailboxCreatePostSchema implements OpenApiContent {
  MailboxCreatePostSchema({
    required this.label,
    required this.entryUuid,
  });

  factory MailboxCreatePostSchema.fromJson(Map<String, dynamic> jsonMap) =>
      _$MailboxCreatePostSchemaFromJson(jsonMap);

  /// label for this mailbox, can be an empty string.
  @JsonKey(
    name: 'label',
    includeIfNull: false,
  )
  final String label;

  /// Client provided entry uuid to match with password entry, can be an empty string.
  @JsonKey(
    name: 'entryUuid',
    includeIfNull: false,
  )
  final String entryUuid;

  Map<String, dynamic> toJson() => _$MailboxCreatePostSchemaToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
@ApiUuidJsonConverter()
class MailboxListGetResponseBody200 implements OpenApiContent {
  MailboxListGetResponseBody200({
    required this.page,
    required this.data,
  });

  factory MailboxListGetResponseBody200.fromJson(
          Map<String, dynamic> jsonMap) =>
      _$MailboxListGetResponseBody200FromJson(jsonMap);

  @JsonKey(
    name: 'page',
    includeIfNull: false,
  )
  final Page page;

  @JsonKey(
    name: 'data',
    includeIfNull: false,
  )
  final List<EmailMessage> data;

  Map<String, dynamic> toJson() => _$MailboxListGetResponseBody200ToJson(this);

  @override
  String toString() => toJson().toString();
}

class MailboxListGetResponse200 extends MailboxListGetResponse
    implements OpenApiResponseBodyJson {
  /// Successful list
  MailboxListGetResponse200.response200(this.body)
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
        'contentType': contentType,
      };
}

sealed class MailboxListGetResponse extends OpenApiResponse
    implements HasSuccessResponse<MailboxListGetResponseBody200> {
  MailboxListGetResponse();

  /// Successful list
  factory MailboxListGetResponse.response200(
          MailboxListGetResponseBody200 body) =>
      MailboxListGetResponse200.response200(body);

  R map<R>({
    required ResponseMap<MailboxListGetResponse200, R> on200,
    ResponseMap<MailboxListGetResponse, R>? onElse,
  }) {
    if (this is MailboxListGetResponse200) {
      return on200((this as MailboxListGetResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  Successful list
  @override
  MailboxListGetResponseBody200 requireSuccess() {
    if (this is MailboxListGetResponse200) {
      return (this as MailboxListGetResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class MailMassupdatePostResponse200 extends MailMassupdatePostResponse {
  /// Update finished.
  MailMassupdatePostResponse200.response200() : status = 200;

  @override
  final int status;

  @override
  final OpenApiContentType? contentType = null;

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'contentType': contentType,
      };
}

sealed class MailMassupdatePostResponse extends OpenApiResponse
    implements HasSuccessResponse<void> {
  MailMassupdatePostResponse();

  /// Update finished.
  factory MailMassupdatePostResponse.response200() =>
      MailMassupdatePostResponse200.response200();

  R map<R>({
    required ResponseMap<MailMassupdatePostResponse200, R> on200,
    ResponseMap<MailMassupdatePostResponse, R>? onElse,
  }) {
    if (this is MailMassupdatePostResponse200) {
      return on200((this as MailMassupdatePostResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  Update finished.
  @override
  void requireSuccess() {
    if (this is MailMassupdatePostResponse200) {
      return;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

enum MailMassupdatePostSchemaFilter {
  @JsonValue('messageIds')
  messageIds,
  @JsonValue('all')
  all,
}

extension MailMassupdatePostSchemaFilterExt on MailMassupdatePostSchemaFilter {
  static final Map<String, MailMassupdatePostSchemaFilter> _names = {
    'messageIds': MailMassupdatePostSchemaFilter.messageIds,
    'all': MailMassupdatePostSchemaFilter.all,
  };
  static MailMassupdatePostSchemaFilter fromName(String name) =>
      _names[name] ??
      _throwStateError(
          'Invalid enum name: $name for MailMassupdatePostSchemaFilter');
  String get name => toString().substring(31);
}

@JsonSerializable()
@ApiUuidJsonConverter()
class MailMassupdatePostSchema implements OpenApiContent {
  MailMassupdatePostSchema({
    required this.filter,
    this.messageIds,
    this.isRead,
  });

  factory MailMassupdatePostSchema.fromJson(Map<String, dynamic> jsonMap) =>
      _$MailMassupdatePostSchemaFromJson(jsonMap);

  @JsonKey(
    name: 'filter',
    includeIfNull: false,
  )
  final MailMassupdatePostSchemaFilter filter;

  /// Only used if filter=messageIds
  @JsonKey(
    name: 'messageIds',
    includeIfNull: false,
  )
  final List<String>? messageIds;

  @JsonKey(
    name: 'isRead',
    includeIfNull: false,
  )
  final bool? isRead;

  Map<String, dynamic> toJson() => _$MailMassupdatePostSchemaToJson(this);

  @override
  String toString() => toJson().toString();
}

class MailboxUpdateResponse200 extends MailboxUpdateResponse {
  /// Success.
  MailboxUpdateResponse200.response200() : status = 200;

  @override
  final int status;

  @override
  final OpenApiContentType? contentType = null;

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'contentType': contentType,
      };
}

sealed class MailboxUpdateResponse extends OpenApiResponse
    implements HasSuccessResponse<void> {
  MailboxUpdateResponse();

  /// Success.
  factory MailboxUpdateResponse.response200() =>
      MailboxUpdateResponse200.response200();

  R map<R>({
    required ResponseMap<MailboxUpdateResponse200, R> on200,
    ResponseMap<MailboxUpdateResponse, R>? onElse,
  }) {
    if (this is MailboxUpdateResponse200) {
      return on200((this as MailboxUpdateResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  Success.
  @override
  void requireSuccess() {
    if (this is MailboxUpdateResponse200) {
      return;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

@JsonSerializable()
@ApiUuidJsonConverter()
class MailboxUpdateSchema implements OpenApiContent {
  MailboxUpdateSchema({
    this.label,
    this.entryUuid,
    this.isDeleted,
    this.isDisabled,
    this.isHidden,
  });

  factory MailboxUpdateSchema.fromJson(Map<String, dynamic> jsonMap) =>
      _$MailboxUpdateSchemaFromJson(jsonMap);

  @JsonKey(
    name: 'label',
    includeIfNull: false,
  )
  final String? label;

  @JsonKey(
    name: 'entryUuid',
    includeIfNull: false,
  )
  final String? entryUuid;

  @JsonKey(
    name: 'isDeleted',
    includeIfNull: false,
  )
  final bool? isDeleted;

  @JsonKey(
    name: 'isDisabled',
    includeIfNull: false,
  )
  final bool? isDisabled;

  @JsonKey(
    name: 'isHidden',
    includeIfNull: false,
  )
  final bool? isHidden;

  Map<String, dynamic> toJson() => _$MailboxUpdateSchemaToJson(this);

  @override
  String toString() => toJson().toString();
}

class MailboxMessageGetResponse200 extends MailboxMessageGetResponse
    implements OpenApiResponseBodyString {
  /// Raw email message incluuding all headers, body and attachment.
  MailboxMessageGetResponse200.response200(this.body) : status = 200;

  @override
  final int status;

  @override
  final String body;

  @override
  final OpenApiContentType contentType = OpenApiContentType.parse('text/plain');

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'body': body,
        'contentType': contentType,
      };
}

sealed class MailboxMessageGetResponse extends OpenApiResponse
    implements HasSuccessResponse<String> {
  MailboxMessageGetResponse();

  /// Raw email message incluuding all headers, body and attachment.
  factory MailboxMessageGetResponse.response200(String body) =>
      MailboxMessageGetResponse200.response200(body);

  R map<R>({
    required ResponseMap<MailboxMessageGetResponse200, R> on200,
    ResponseMap<MailboxMessageGetResponse, R>? onElse,
  }) {
    if (this is MailboxMessageGetResponse200) {
      return on200((this as MailboxMessageGetResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  Raw email message incluuding all headers, body and attachment.
  @override
  String requireSuccess() {
    if (this is MailboxMessageGetResponse200) {
      return (this as MailboxMessageGetResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class MailboxMessageDeleteResponse200 extends MailboxMessageDeleteResponse {
  /// Message was deleted successfully.
  MailboxMessageDeleteResponse200.response200() : status = 200;

  @override
  final int status;

  @override
  final OpenApiContentType? contentType = null;

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'contentType': contentType,
      };
}

sealed class MailboxMessageDeleteResponse extends OpenApiResponse
    implements HasSuccessResponse<void> {
  MailboxMessageDeleteResponse();

  /// Message was deleted successfully.
  factory MailboxMessageDeleteResponse.response200() =>
      MailboxMessageDeleteResponse200.response200();

  R map<R>({
    required ResponseMap<MailboxMessageDeleteResponse200, R> on200,
    ResponseMap<MailboxMessageDeleteResponse, R>? onElse,
  }) {
    if (this is MailboxMessageDeleteResponse200) {
      return on200((this as MailboxMessageDeleteResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  Message was deleted successfully.
  @override
  void requireSuccess() {
    if (this is MailboxMessageDeleteResponse200) {
      return;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class MailboxMessageForwardResponse200 extends MailboxMessageForwardResponse {
  /// Successfully forwarded message.
  MailboxMessageForwardResponse200.response200() : status = 200;

  @override
  final int status;

  @override
  final OpenApiContentType? contentType = null;

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'contentType': contentType,
      };
}

sealed class MailboxMessageForwardResponse extends OpenApiResponse
    implements HasSuccessResponse<void> {
  MailboxMessageForwardResponse();

  /// Successfully forwarded message.
  factory MailboxMessageForwardResponse.response200() =>
      MailboxMessageForwardResponse200.response200();

  R map<R>({
    required ResponseMap<MailboxMessageForwardResponse200, R> on200,
    ResponseMap<MailboxMessageForwardResponse, R>? onElse,
  }) {
    if (this is MailboxMessageForwardResponse200) {
      return on200((this as MailboxMessageForwardResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  Successfully forwarded message.
  @override
  void requireSuccess() {
    if (this is MailboxMessageForwardResponse200) {
      return;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

@JsonSerializable()
@ApiUuidJsonConverter()
class MailboxMessageForwardSchema implements OpenApiContent {
  MailboxMessageForwardSchema({this.email});

  factory MailboxMessageForwardSchema.fromJson(Map<String, dynamic> jsonMap) =>
      _$MailboxMessageForwardSchemaFromJson(jsonMap);

  @JsonKey(
    name: 'email',
    includeIfNull: false,
  )
  final String? email;

  Map<String, dynamic> toJson() => _$MailboxMessageForwardSchemaToJson(this);

  @override
  String toString() => toJson().toString();
}

class MailboxMessageMarkReadResponse200 extends MailboxMessageMarkReadResponse {
  /// Successfully marked as read.
  MailboxMessageMarkReadResponse200.response200() : status = 200;

  @override
  final int status;

  @override
  final OpenApiContentType? contentType = null;

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'contentType': contentType,
      };
}

sealed class MailboxMessageMarkReadResponse extends OpenApiResponse
    implements HasSuccessResponse<void> {
  MailboxMessageMarkReadResponse();

  /// Successfully marked as read.
  factory MailboxMessageMarkReadResponse.response200() =>
      MailboxMessageMarkReadResponse200.response200();

  R map<R>({
    required ResponseMap<MailboxMessageMarkReadResponse200, R> on200,
    ResponseMap<MailboxMessageMarkReadResponse, R>? onElse,
  }) {
    if (this is MailboxMessageMarkReadResponse200) {
      return on200((this as MailboxMessageMarkReadResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  Successfully marked as read.
  @override
  void requireSuccess() {
    if (this is MailboxMessageMarkReadResponse200) {
      return;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class MailboxMessageMarkUnReadResponse200
    extends MailboxMessageMarkUnReadResponse {
  /// Successfully marked as unread.
  MailboxMessageMarkUnReadResponse200.response200() : status = 200;

  @override
  final int status;

  @override
  final OpenApiContentType? contentType = null;

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'contentType': contentType,
      };
}

sealed class MailboxMessageMarkUnReadResponse extends OpenApiResponse
    implements HasSuccessResponse<void> {
  MailboxMessageMarkUnReadResponse();

  /// Successfully marked as unread.
  factory MailboxMessageMarkUnReadResponse.response200() =>
      MailboxMessageMarkUnReadResponse200.response200();

  R map<R>({
    required ResponseMap<MailboxMessageMarkUnReadResponse200, R> on200,
    ResponseMap<MailboxMessageMarkUnReadResponse, R>? onElse,
  }) {
    if (this is MailboxMessageMarkUnReadResponse200) {
      return on200((this as MailboxMessageMarkUnReadResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  Successfully marked as unread.
  @override
  void requireSuccess() {
    if (this is MailboxMessageMarkUnReadResponse200) {
      return;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class EmailReceivePostResponse200 extends EmailReceivePostResponse {
  /// Received and delivered successfully.
  EmailReceivePostResponse200.response200() : status = 200;

  @override
  final int status;

  @override
  final OpenApiContentType? contentType = null;

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'contentType': contentType,
      };
}

class EmailReceivePostResponse403 extends EmailReceivePostResponse
    implements OpenApiResponseBodyString {
  /// Delivery not accepted.
  EmailReceivePostResponse403.response403(this.body) : status = 403;

  @override
  final int status;

  @override
  final String body;

  @override
  final OpenApiContentType contentType = OpenApiContentType.parse('text/plain');

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'body': body,
        'contentType': contentType,
      };
}

sealed class EmailReceivePostResponse extends OpenApiResponse
    implements HasSuccessResponse<void> {
  EmailReceivePostResponse();

  /// Received and delivered successfully.
  factory EmailReceivePostResponse.response200() =>
      EmailReceivePostResponse200.response200();

  /// Delivery not accepted.
  factory EmailReceivePostResponse.response403(String body) =>
      EmailReceivePostResponse403.response403(body);

  R map<R>({
    required ResponseMap<EmailReceivePostResponse200, R> on200,
    required ResponseMap<EmailReceivePostResponse403, R> on403,
    ResponseMap<EmailReceivePostResponse, R>? onElse,
  }) {
    if (this is EmailReceivePostResponse200) {
      return on200((this as EmailReceivePostResponse200));
    } else if (this is EmailReceivePostResponse403) {
      return on403((this as EmailReceivePostResponse403));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  Received and delivered successfully.
  @override
  void requireSuccess() {
    if (this is EmailReceivePostResponse200) {
      return;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class FilecloudFileMetadataPostResponse200
    extends FilecloudFileMetadataPostResponse
    implements OpenApiResponseBodyJson {
  /// Successful retrieving file metadata.
  FilecloudFileMetadataPostResponse200.response200(this.body)
      : status = 200,
        bodyJson = body.toJson();

  @override
  final int status;

  final FileInfo body;

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
        'contentType': contentType,
      };
}

sealed class FilecloudFileMetadataPostResponse extends OpenApiResponse
    implements HasSuccessResponse<FileInfo> {
  FilecloudFileMetadataPostResponse();

  /// Successful retrieving file metadata.
  factory FilecloudFileMetadataPostResponse.response200(FileInfo body) =>
      FilecloudFileMetadataPostResponse200.response200(body);

  R map<R>({
    required ResponseMap<FilecloudFileMetadataPostResponse200, R> on200,
    ResponseMap<FilecloudFileMetadataPostResponse, R>? onElse,
  }) {
    if (this is FilecloudFileMetadataPostResponse200) {
      return on200((this as FilecloudFileMetadataPostResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  Successful retrieving file metadata.
  @override
  FileInfo requireSuccess() {
    if (this is FilecloudFileMetadataPostResponse200) {
      return (this as FilecloudFileMetadataPostResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class FilecloudFileRetrievePostResponse200
    extends FilecloudFileRetrievePostResponse
    implements OpenApiResponseBodyBinary {
  /// The requested file
  FilecloudFileRetrievePostResponse200.response200(this.body) : status = 200;

  @override
  final int status;

  @override
  final _i1.Uint8List body;

  @override
  final OpenApiContentType contentType =
      OpenApiContentType.parse('application/octet-set');

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'body': body,
        'contentType': contentType,
      };
}

sealed class FilecloudFileRetrievePostResponse extends OpenApiResponse
    implements HasSuccessResponse<_i1.Uint8List> {
  FilecloudFileRetrievePostResponse();

  /// The requested file
  factory FilecloudFileRetrievePostResponse.response200(_i1.Uint8List body) =>
      FilecloudFileRetrievePostResponse200.response200(body);

  R map<R>({
    required ResponseMap<FilecloudFileRetrievePostResponse200, R> on200,
    ResponseMap<FilecloudFileRetrievePostResponse, R>? onElse,
  }) {
    if (this is FilecloudFileRetrievePostResponse200) {
      return on200((this as FilecloudFileRetrievePostResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  The requested file
  @override
  _i1.Uint8List requireSuccess() {
    if (this is FilecloudFileRetrievePostResponse200) {
      return (this as FilecloudFileRetrievePostResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class FilecloudFileDeletePostResponse204
    extends FilecloudFileDeletePostResponse {
  /// Successfully deleted the file.
  FilecloudFileDeletePostResponse204.response204() : status = 204;

  @override
  final int status;

  @override
  final OpenApiContentType? contentType = null;

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'contentType': contentType,
      };
}

sealed class FilecloudFileDeletePostResponse extends OpenApiResponse
    implements HasSuccessResponse<void> {
  FilecloudFileDeletePostResponse();

  /// Successfully deleted the file.
  factory FilecloudFileDeletePostResponse.response204() =>
      FilecloudFileDeletePostResponse204.response204();

  R map<R>({
    required ResponseMap<FilecloudFileDeletePostResponse204, R> on204,
    ResponseMap<FilecloudFileDeletePostResponse, R>? onElse,
  }) {
    if (this is FilecloudFileDeletePostResponse204) {
      return on204((this as FilecloudFileDeletePostResponse204));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 204:  Successfully deleted the file.
  @override
  void requireSuccess() {
    if (this is FilecloudFileDeletePostResponse204) {
      return;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class FilecloudFileTokenCreatePostResponse200
    extends FilecloudFileTokenCreatePostResponse
    implements OpenApiResponseBodyJson {
  /// Successfully created token.
  FilecloudFileTokenCreatePostResponse200.response200(this.body)
      : status = 200,
        bodyJson = body.toJson();

  @override
  final int status;

  final FileId body;

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
        'contentType': contentType,
      };
}

sealed class FilecloudFileTokenCreatePostResponse extends OpenApiResponse
    implements HasSuccessResponse<FileId> {
  FilecloudFileTokenCreatePostResponse();

  /// Successfully created token.
  factory FilecloudFileTokenCreatePostResponse.response200(FileId body) =>
      FilecloudFileTokenCreatePostResponse200.response200(body);

  R map<R>({
    required ResponseMap<FilecloudFileTokenCreatePostResponse200, R> on200,
    ResponseMap<FilecloudFileTokenCreatePostResponse, R>? onElse,
  }) {
    if (this is FilecloudFileTokenCreatePostResponse200) {
      return on200((this as FilecloudFileTokenCreatePostResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  Successfully created token.
  @override
  FileId requireSuccess() {
    if (this is FilecloudFileTokenCreatePostResponse200) {
      return (this as FilecloudFileTokenCreatePostResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

@JsonSerializable()
@ApiUuidJsonConverter()
class FilecloudFileTokenCreatePostSchema implements OpenApiContent {
  FilecloudFileTokenCreatePostSchema({
    required this.fileToken,
    required this.label,
    this.userEmail,
    this.readOnly = false,
  });

  factory FilecloudFileTokenCreatePostSchema.fromJson(
          Map<String, dynamic> jsonMap) =>
      _$FilecloudFileTokenCreatePostSchemaFromJson(jsonMap);

  /// The fileToken identifying the file to share
  @JsonKey(
    name: 'fileToken',
    includeIfNull: false,
  )
  final String fileToken;

  /// Some label to help the user remember why they created the token.
  @JsonKey(
    name: 'label',
    includeIfNull: false,
  )
  final String label;

  /// Email address for the user to create a token. If null, the token will not be bound to a specific user.
  @JsonKey(
    name: 'userEmail',
    includeIfNull: false,
  )
  final String? userEmail;

  @JsonKey(
    name: 'readOnly',
    includeIfNull: false,
  )
  final bool readOnly;

  Map<String, dynamic> toJson() =>
      _$FilecloudFileTokenCreatePostSchemaToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
@ApiUuidJsonConverter()
class FilecloudFileTokenListPostResponseBody200 implements OpenApiContent {
  FilecloudFileTokenListPostResponseBody200({required this.tokens});

  factory FilecloudFileTokenListPostResponseBody200.fromJson(
          Map<String, dynamic> jsonMap) =>
      _$FilecloudFileTokenListPostResponseBody200FromJson(jsonMap);

  @JsonKey(
    name: 'tokens',
    includeIfNull: false,
  )
  final List<FileTokenInfo> tokens;

  Map<String, dynamic> toJson() =>
      _$FilecloudFileTokenListPostResponseBody200ToJson(this);

  @override
  String toString() => toJson().toString();
}

class FilecloudFileTokenListPostResponse200
    extends FilecloudFileTokenListPostResponse
    implements OpenApiResponseBodyJson {
  ///
  FilecloudFileTokenListPostResponse200.response200(this.body)
      : status = 200,
        bodyJson = body.toJson();

  @override
  final int status;

  final FilecloudFileTokenListPostResponseBody200 body;

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
        'contentType': contentType,
      };
}

sealed class FilecloudFileTokenListPostResponse extends OpenApiResponse
    implements HasSuccessResponse<FilecloudFileTokenListPostResponseBody200> {
  FilecloudFileTokenListPostResponse();

  ///
  factory FilecloudFileTokenListPostResponse.response200(
          FilecloudFileTokenListPostResponseBody200 body) =>
      FilecloudFileTokenListPostResponse200.response200(body);

  R map<R>({
    required ResponseMap<FilecloudFileTokenListPostResponse200, R> on200,
    ResponseMap<FilecloudFileTokenListPostResponse, R>? onElse,
  }) {
    if (this is FilecloudFileTokenListPostResponse200) {
      return on200((this as FilecloudFileTokenListPostResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:
  @override
  FilecloudFileTokenListPostResponseBody200 requireSuccess() {
    if (this is FilecloudFileTokenListPostResponse200) {
      return (this as FilecloudFileTokenListPostResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class FilecloudFileGetResponse200 extends FilecloudFileGetResponse
    implements OpenApiResponseBodyJson {
  /// List of files of the user
  FilecloudFileGetResponse200.response200(this.body)
      : status = 200,
        bodyJson = body.toJson();

  @override
  final int status;

  final FileListResponse body;

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
        'contentType': contentType,
      };
}

sealed class FilecloudFileGetResponse extends OpenApiResponse
    implements HasSuccessResponse<FileListResponse> {
  FilecloudFileGetResponse();

  /// List of files of the user
  factory FilecloudFileGetResponse.response200(FileListResponse body) =>
      FilecloudFileGetResponse200.response200(body);

  R map<R>({
    required ResponseMap<FilecloudFileGetResponse200, R> on200,
    ResponseMap<FilecloudFileGetResponse, R>? onElse,
  }) {
    if (this is FilecloudFileGetResponse200) {
      return on200((this as FilecloudFileGetResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  List of files of the user
  @override
  FileListResponse requireSuccess() {
    if (this is FilecloudFileGetResponse200) {
      return (this as FilecloudFileGetResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

@JsonSerializable()
@ApiUuidJsonConverter()
class FilecloudFilePutResponseBody200 implements OpenApiContent {
  FilecloudFilePutResponseBody200({required this.versionToken});

  factory FilecloudFilePutResponseBody200.fromJson(
          Map<String, dynamic> jsonMap) =>
      _$FilecloudFilePutResponseBody200FromJson(jsonMap);

  /// Token identifieing the version of this file. Must be used for updating the file.
  @JsonKey(
    name: 'versionToken',
    includeIfNull: false,
  )
  final String versionToken;

  Map<String, dynamic> toJson() =>
      _$FilecloudFilePutResponseBody200ToJson(this);

  @override
  String toString() => toJson().toString();
}

class FilecloudFilePutResponse200 extends FilecloudFilePutResponse
    implements OpenApiResponseBodyJson {
  /// Successful file update
  FilecloudFilePutResponse200.response200(this.body)
      : status = 200,
        bodyJson = body.toJson();

  @override
  final int status;

  final FilecloudFilePutResponseBody200 body;

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
        'contentType': contentType,
      };
}

class FilecloudFilePutResponse409 extends FilecloudFilePutResponse {
  /// conflict: versionToken was not the latest version.
  FilecloudFilePutResponse409.response409() : status = 409;

  @override
  final int status;

  @override
  final OpenApiContentType? contentType = null;

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'contentType': contentType,
      };
}

sealed class FilecloudFilePutResponse extends OpenApiResponse
    implements HasSuccessResponse<FilecloudFilePutResponseBody200> {
  FilecloudFilePutResponse();

  /// Successful file update
  factory FilecloudFilePutResponse.response200(
          FilecloudFilePutResponseBody200 body) =>
      FilecloudFilePutResponse200.response200(body);

  /// conflict: versionToken was not the latest version.
  factory FilecloudFilePutResponse.response409() =>
      FilecloudFilePutResponse409.response409();

  R map<R>({
    required ResponseMap<FilecloudFilePutResponse200, R> on200,
    required ResponseMap<FilecloudFilePutResponse409, R> on409,
    ResponseMap<FilecloudFilePutResponse, R>? onElse,
  }) {
    if (this is FilecloudFilePutResponse200) {
      return on200((this as FilecloudFilePutResponse200));
    } else if (this is FilecloudFilePutResponse409) {
      return on409((this as FilecloudFilePutResponse409));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  Successful file update
  @override
  FilecloudFilePutResponseBody200 requireSuccess() {
    if (this is FilecloudFilePutResponse200) {
      return (this as FilecloudFilePutResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

@JsonSerializable()
@ApiUuidJsonConverter()
class FilecloudFilePostResponseBody200 implements OpenApiContent {
  FilecloudFilePostResponseBody200({
    required this.fileToken,
    required this.versionToken,
  });

  factory FilecloudFilePostResponseBody200.fromJson(
          Map<String, dynamic> jsonMap) =>
      _$FilecloudFilePostResponseBody200FromJson(jsonMap);

  /// Unique token to reference the newly created file.
  @JsonKey(
    name: 'fileToken',
    includeIfNull: false,
  )
  final String fileToken;

  /// Token identifieing the version of this file. Must be used for updating the file.
  @JsonKey(
    name: 'versionToken',
    includeIfNull: false,
  )
  final String versionToken;

  Map<String, dynamic> toJson() =>
      _$FilecloudFilePostResponseBody200ToJson(this);

  @override
  String toString() => toJson().toString();
}

class FilecloudFilePostResponse200 extends FilecloudFilePostResponse
    implements OpenApiResponseBodyJson {
  /// successful file creation.
  FilecloudFilePostResponse200.response200(this.body)
      : status = 200,
        bodyJson = body.toJson();

  @override
  final int status;

  final FilecloudFilePostResponseBody200 body;

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
        'contentType': contentType,
      };
}

sealed class FilecloudFilePostResponse extends OpenApiResponse
    implements HasSuccessResponse<FilecloudFilePostResponseBody200> {
  FilecloudFilePostResponse();

  /// successful file creation.
  factory FilecloudFilePostResponse.response200(
          FilecloudFilePostResponseBody200 body) =>
      FilecloudFilePostResponse200.response200(body);

  R map<R>({
    required ResponseMap<FilecloudFilePostResponse200, R> on200,
    ResponseMap<FilecloudFilePostResponse, R>? onElse,
  }) {
    if (this is FilecloudFilePostResponse200) {
      return on200((this as FilecloudFilePostResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  successful file creation.
  @override
  FilecloudFilePostResponseBody200 requireSuccess() {
    if (this is FilecloudFilePostResponse200) {
      return (this as FilecloudFilePostResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

@JsonSerializable()
@ApiUuidJsonConverter()
class FilecloudAttachmentPostResponseBody200 implements OpenApiContent {
  FilecloudAttachmentPostResponseBody200({required this.attachmentToken});

  factory FilecloudAttachmentPostResponseBody200.fromJson(
          Map<String, dynamic> jsonMap) =>
      _$FilecloudAttachmentPostResponseBody200FromJson(jsonMap);

  /// Unique token to reference the newly created file.
  @JsonKey(
    name: 'attachmentToken',
    includeIfNull: false,
  )
  final String attachmentToken;

  Map<String, dynamic> toJson() =>
      _$FilecloudAttachmentPostResponseBody200ToJson(this);

  @override
  String toString() => toJson().toString();
}

class FilecloudAttachmentPostResponse200 extends FilecloudAttachmentPostResponse
    implements OpenApiResponseBodyJson {
  /// successfully created attachment.
  FilecloudAttachmentPostResponse200.response200(this.body)
      : status = 200,
        bodyJson = body.toJson();

  @override
  final int status;

  final FilecloudAttachmentPostResponseBody200 body;

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
        'contentType': contentType,
      };
}

sealed class FilecloudAttachmentPostResponse extends OpenApiResponse
    implements HasSuccessResponse<FilecloudAttachmentPostResponseBody200> {
  FilecloudAttachmentPostResponse();

  /// successfully created attachment.
  factory FilecloudAttachmentPostResponse.response200(
          FilecloudAttachmentPostResponseBody200 body) =>
      FilecloudAttachmentPostResponse200.response200(body);

  R map<R>({
    required ResponseMap<FilecloudAttachmentPostResponse200, R> on200,
    ResponseMap<FilecloudAttachmentPostResponse, R>? onElse,
  }) {
    if (this is FilecloudAttachmentPostResponse200) {
      return on200((this as FilecloudAttachmentPostResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  successfully created attachment.
  @override
  FilecloudAttachmentPostResponseBody200 requireSuccess() {
    if (this is FilecloudAttachmentPostResponse200) {
      return (this as FilecloudAttachmentPostResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class FilecloudAttachmentTouchPostResponse200
    extends FilecloudAttachmentTouchPostResponse {
  /// Successfully touched all attachments.
  FilecloudAttachmentTouchPostResponse200.response200() : status = 200;

  @override
  final int status;

  @override
  final OpenApiContentType? contentType = null;

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'contentType': contentType,
      };
}

sealed class FilecloudAttachmentTouchPostResponse extends OpenApiResponse
    implements HasSuccessResponse<void> {
  FilecloudAttachmentTouchPostResponse();

  /// Successfully touched all attachments.
  factory FilecloudAttachmentTouchPostResponse.response200() =>
      FilecloudAttachmentTouchPostResponse200.response200();

  R map<R>({
    required ResponseMap<FilecloudAttachmentTouchPostResponse200, R> on200,
    ResponseMap<FilecloudAttachmentTouchPostResponse, R>? onElse,
  }) {
    if (this is FilecloudAttachmentTouchPostResponse200) {
      return on200((this as FilecloudAttachmentTouchPostResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  Successfully touched all attachments.
  @override
  void requireSuccess() {
    if (this is FilecloudAttachmentTouchPostResponse200) {
      return;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class FilecloudAttachmentUnlinkPostResponse200
    extends FilecloudAttachmentUnlinkPostResponse {
  /// Successfully removed association.
  FilecloudAttachmentUnlinkPostResponse200.response200() : status = 200;

  @override
  final int status;

  @override
  final OpenApiContentType? contentType = null;

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'contentType': contentType,
      };
}

sealed class FilecloudAttachmentUnlinkPostResponse extends OpenApiResponse
    implements HasSuccessResponse<void> {
  FilecloudAttachmentUnlinkPostResponse();

  /// Successfully removed association.
  factory FilecloudAttachmentUnlinkPostResponse.response200() =>
      FilecloudAttachmentUnlinkPostResponse200.response200();

  R map<R>({
    required ResponseMap<FilecloudAttachmentUnlinkPostResponse200, R> on200,
    ResponseMap<FilecloudAttachmentUnlinkPostResponse, R>? onElse,
  }) {
    if (this is FilecloudAttachmentUnlinkPostResponse200) {
      return on200((this as FilecloudAttachmentUnlinkPostResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  Successfully removed association.
  @override
  void requireSuccess() {
    if (this is FilecloudAttachmentUnlinkPostResponse200) {
      return;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class FilecloudAttachmentRetrievePostResponse200
    extends FilecloudAttachmentRetrievePostResponse
    implements OpenApiResponseBodyBinary {
  /// The requested file
  FilecloudAttachmentRetrievePostResponse200.response200(this.body)
      : status = 200;

  @override
  final int status;

  @override
  final _i1.Uint8List body;

  @override
  final OpenApiContentType contentType =
      OpenApiContentType.parse('application/octet-set');

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'body': body,
        'contentType': contentType,
      };
}

sealed class FilecloudAttachmentRetrievePostResponse extends OpenApiResponse
    implements HasSuccessResponse<_i1.Uint8List> {
  FilecloudAttachmentRetrievePostResponse();

  /// The requested file
  factory FilecloudAttachmentRetrievePostResponse.response200(
          _i1.Uint8List body) =>
      FilecloudAttachmentRetrievePostResponse200.response200(body);

  R map<R>({
    required ResponseMap<FilecloudAttachmentRetrievePostResponse200, R> on200,
    ResponseMap<FilecloudAttachmentRetrievePostResponse, R>? onElse,
  }) {
    if (this is FilecloudAttachmentRetrievePostResponse200) {
      return on200((this as FilecloudAttachmentRetrievePostResponse200));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  The requested file
  @override
  _i1.Uint8List requireSuccess() {
    if (this is FilecloudAttachmentRetrievePostResponse200) {
      return (this as FilecloudAttachmentRetrievePostResponse200).body;
    } else {
      throw StateError('Expected success response, but got $this');
    }
  }
}

class WebsiteImageGetResponse200 extends WebsiteImageGetResponse
    implements OpenApiResponseBodyBinary {
  /// Image
  WebsiteImageGetResponse200.response200(
    this.contentType,
    this.body,
  ) : status = 200;

  @override
  final int status;

  @override
  final _i1.Uint8List body;

  @override
  final OpenApiContentType contentType;

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'body': body,
        'contentType': contentType,
      };
}

class WebsiteImageGetResponse404 extends WebsiteImageGetResponse {
  /// No image found for this url.
  WebsiteImageGetResponse404.response404() : status = 404;

  @override
  final int status;

  @override
  final OpenApiContentType? contentType = null;

  @override
  Map<String, Object?> propertiesToString() => {
        'status': status,
        'contentType': contentType,
      };
}

sealed class WebsiteImageGetResponse extends OpenApiResponse
    implements HasSuccessResponse<_i1.Uint8List> {
  WebsiteImageGetResponse();

  /// Image
  factory WebsiteImageGetResponse.response200(
    OpenApiContentType contentType,
    _i1.Uint8List body,
  ) =>
      WebsiteImageGetResponse200.response200(
        contentType,
        body,
      );

  /// No image found for this url.
  factory WebsiteImageGetResponse.response404() =>
      WebsiteImageGetResponse404.response404();

  R map<R>({
    required ResponseMap<WebsiteImageGetResponse200, R> on200,
    required ResponseMap<WebsiteImageGetResponse404, R> on404,
    ResponseMap<WebsiteImageGetResponse, R>? onElse,
  }) {
    if (this is WebsiteImageGetResponse200) {
      return on200((this as WebsiteImageGetResponse200));
    } else if (this is WebsiteImageGetResponse404) {
      return on404((this as WebsiteImageGetResponse404));
    } else if (onElse != null) {
      return onElse(this);
    } else {
      throw StateError('Invalid instance of type $this');
    }
  }

  /// status 200:  Image
  @override
  _i1.Uint8List requireSuccess() {
    if (this is WebsiteImageGetResponse200) {
      return (this as WebsiteImageGetResponse200).body;
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

  /// Shows a form to enter email address to start deletion process.
  /// get: /user/delete
  Future<UserDeleteGetResponse> userDeleteGet();

  /// Request user deletion.
  /// post: /user/delete
  Future<UserDeletePostResponse> userDeletePost(UserDeletePostSchema body);

  /// Confirm deleting of user/email address.
  /// get: /user/delete/confirm
  Future<UserDeleteConfirmGetResponse> userDeleteConfirmGet(
      {required String token});

  /// Confirm with recaptcha
  /// post: /user/delete/confirm
  Future<UserDeleteConfirmPostResponse> userDeleteConfirmPost(
      UserDeleteConfirmPostSchema body);

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
  Future<MailboxListGetResponse> mailboxListGet({
    String? pageToken,
    String? sinceToken,
  });

  /// Apply the given update to all matching mails.
  /// post: /mail/massupdate
  Future<MailMassupdatePostResponse> mailMassupdatePost(
      MailMassupdatePostSchema body);

  /// Update information about mailbox
  /// put: /mailbox/update/{mailboxAddress}
  Future<MailboxUpdateResponse> mailboxUpdate(
    MailboxUpdateSchema body, {
    required String mailboxAddress,
  });

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
    MailboxMessageForwardSchema body, {
    required ApiUuid messageId,
  });

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
  Future<EmailReceivePostResponse> emailReceivePost(
    String body, {
    required String xAuthpassToken,
  });

  /// Retrieve file meta data.
  /// post: /filecloud/file/metadata
  /// [body]: Object wrapping a [fileToken].
  Future<FilecloudFileMetadataPostResponse> filecloudFileMetadataPost(
      FileId body);

  /// Retrieve a previously created file.
  /// post: /filecloud/file/retrieve
  /// [body]: Object wrapping a [fileToken].
  Future<FilecloudFileRetrievePostResponse> filecloudFileRetrievePost(
      FileId body);

  /// Deletes a file with the given fileToken
  /// post: /filecloud/file/delete
  /// [body]: Object wrapping a [fileToken].
  Future<FilecloudFileDeletePostResponse> filecloudFileDeletePost(FileId body);

  /// Create file tokens which can be used to share the file.
  /// post: /filecloud/file/token/create
  Future<FilecloudFileTokenCreatePostResponse> filecloudFileTokenCreatePost(
      FilecloudFileTokenCreatePostSchema body);

  /// List all tokens for a given file. Only available for the owner of the file.
  /// post: /filecloud/file/token/list
  /// [body]: Object wrapping a [fileToken].
  Future<FilecloudFileTokenListPostResponse> filecloudFileTokenListPost(
      FileId body);

  /// List available files for user
  /// get: /filecloud/file
  Future<FilecloudFileGetResponse> filecloudFileGet();

  /// Update file
  /// put: /filecloud/file
  Future<FilecloudFilePutResponse> filecloudFilePut(
    _i1.Uint8List body, {
    required String fileToken,
    required String versionToken,
  });

  /// Create new file
  /// post: /filecloud/file
  Future<FilecloudFilePostResponse> filecloudFilePost(
    _i1.Uint8List body, {
    required String fileName,
  });

  /// Create attachment
  /// post: /filecloud/attachment
  Future<FilecloudAttachmentPostResponse> filecloudAttachmentPost(
    _i1.Uint8List body, {
    required String fileName,
    required String fileToken,
  });

  /// Touches an attachment that it is still in use for the given file.
  /// post: /filecloud/attachment/touch
  Future<FilecloudAttachmentTouchPostResponse> filecloudAttachmentTouchPost(
      AttachmentTouch body);

  /// Release a attachment - used when an attachment is removed from a file.
  /// post: /filecloud/attachment/unlink
  Future<FilecloudAttachmentUnlinkPostResponse> filecloudAttachmentUnlinkPost(
      AttachmentTouch body);

  /// Retrieve an attachment.
  /// post: /filecloud/attachment/retrieve
  /// [body]: Object wrapping a [attachmentToken].
  Future<FilecloudAttachmentRetrievePostResponse>
      filecloudAttachmentRetrievePost(AttachmentId body);

  /// Load the best image for the given website.
  /// get: /website/image
  Future<WebsiteImageGetResponse> websiteImageGet({required String url});
}

abstract class AuthPassCloudClient implements OpenApiClient {
  factory AuthPassCloudClient(
    Uri baseUri,
    OpenApiRequestSender requestSender,
  ) =>
      _AuthPassCloudClientImpl._(
        baseUri,
        requestSender,
      );

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

  /// Shows a form to enter email address to start deletion process.
  /// get: /user/delete
  ///
  Future<UserDeleteGetResponse> userDeleteGet();

  /// Request user deletion.
  /// post: /user/delete
  ///
  Future<UserDeletePostResponse> userDeletePost(UserDeletePostSchema body);

  /// Confirm deleting of user/email address.
  /// get: /user/delete/confirm
  ///
  /// * [token]: Unique token which was sent to email address.
  Future<UserDeleteConfirmGetResponse> userDeleteConfirmGet(
      {required String token});

  /// Confirm with recaptcha
  /// post: /user/delete/confirm
  ///
  Future<UserDeleteConfirmPostResponse> userDeleteConfirmPost(
      UserDeleteConfirmPostSchema body);

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
  Future<MailboxListGetResponse> mailboxListGet({
    String? pageToken,
    String? sinceToken,
  });

  /// Apply the given update to all matching mails.
  /// post: /mail/massupdate
  ///
  Future<MailMassupdatePostResponse> mailMassupdatePost(
      MailMassupdatePostSchema body);

  /// Update information about mailbox
  /// put: /mailbox/update/{mailboxAddress}
  ///
  Future<MailboxUpdateResponse> mailboxUpdate(
    MailboxUpdateSchema body, {
    required String mailboxAddress,
  });

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
    MailboxMessageForwardSchema body, {
    required ApiUuid messageId,
  });

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
  Future<EmailReceivePostResponse> emailReceivePost(
    String body, {
    required String xAuthpassToken,
  });

  /// Retrieve file meta data.
  /// post: /filecloud/file/metadata
  ///
  /// [body]: Object wrapping a [fileToken].
  Future<FilecloudFileMetadataPostResponse> filecloudFileMetadataPost(
      FileId body);

  /// Retrieve a previously created file.
  /// post: /filecloud/file/retrieve
  ///
  /// [body]: Object wrapping a [fileToken].
  Future<FilecloudFileRetrievePostResponse> filecloudFileRetrievePost(
      FileId body);

  /// Deletes a file with the given fileToken
  /// post: /filecloud/file/delete
  ///
  /// [body]: Object wrapping a [fileToken].
  Future<FilecloudFileDeletePostResponse> filecloudFileDeletePost(FileId body);

  /// Create file tokens which can be used to share the file.
  /// post: /filecloud/file/token/create
  ///
  Future<FilecloudFileTokenCreatePostResponse> filecloudFileTokenCreatePost(
      FilecloudFileTokenCreatePostSchema body);

  /// List all tokens for a given file. Only available for the owner of the file.
  /// post: /filecloud/file/token/list
  ///
  /// [body]: Object wrapping a [fileToken].
  Future<FilecloudFileTokenListPostResponse> filecloudFileTokenListPost(
      FileId body);

  /// List available files for user
  /// get: /filecloud/file
  ///
  Future<FilecloudFileGetResponse> filecloudFileGet();

  /// Update file
  /// put: /filecloud/file
  ///
  Future<FilecloudFilePutResponse> filecloudFilePut(
    _i1.Uint8List body, {
    required String fileToken,
    required String versionToken,
  });

  /// Create new file
  /// post: /filecloud/file
  ///
  Future<FilecloudFilePostResponse> filecloudFilePost(
    _i1.Uint8List body, {
    required String fileName,
  });

  /// Create attachment
  /// post: /filecloud/attachment
  ///
  Future<FilecloudAttachmentPostResponse> filecloudAttachmentPost(
    _i1.Uint8List body, {
    required String fileName,
    required String fileToken,
  });

  /// Touches an attachment that it is still in use for the given file.
  /// post: /filecloud/attachment/touch
  ///
  Future<FilecloudAttachmentTouchPostResponse> filecloudAttachmentTouchPost(
      AttachmentTouch body);

  /// Release a attachment - used when an attachment is removed from a file.
  /// post: /filecloud/attachment/unlink
  ///
  Future<FilecloudAttachmentUnlinkPostResponse> filecloudAttachmentUnlinkPost(
      AttachmentTouch body);

  /// Retrieve an attachment.
  /// post: /filecloud/attachment/retrieve
  ///
  /// [body]: Object wrapping a [attachmentToken].
  Future<FilecloudAttachmentRetrievePostResponse>
      filecloudAttachmentRetrievePost(AttachmentId body);

  /// Load the best image for the given website.
  /// get: /website/image
  ///
  Future<WebsiteImageGetResponse> websiteImageGet({required String url});
}

class _AuthPassCloudClientImpl extends OpenApiClientBase
    implements AuthPassCloudClient {
  _AuthPassCloudClientImpl._(
    this.baseUri,
    this.requestSender,
  );

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
    final request = OpenApiClientRequest(
      'get',
      '/check',
      [],
    );
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            CheckGetResponse200.response200()
      },
    );
  }

  /// Status Check.
  /// post: /check/status
  ///
  @override
  Future<CheckStatusPostResponse> checkStatusPost({String? xSecret}) async {
    final request = OpenApiClientRequest(
      'post',
      '/check/status',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.addHeaderParameter(
      'x-secret',
      encodeString(xSecret),
    );
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            CheckStatusPostResponse200.response200(
                SystemStatus.fromJson(await response.responseBodyJson()))
      },
    );
  }

  /// Retrieve info about the currently logged in user and about the token.
  /// get: /user
  ///
  @override
  Future<UserGetResponse> userGet() async {
    final request = OpenApiClientRequest(
      'get',
      '/user',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            UserGetResponse200.response200(
                UserInfo.fromJson(await response.responseBodyJson()))
      },
    );
  }

  /// Create new user, or login the user using confirmation email.
  /// post: /user/register
  ///
  @override
  Future<UserRegisterPostResponse> userRegisterPost(
      RegisterRequest body) async {
    final request = OpenApiClientRequest(
      'post',
      '/user/register',
      [],
    );
    request.setHeader(
      'content-type',
      'application/json',
    );
    request.setBody(OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            UserRegisterPostResponse200.response200(
                RegisterResponse.fromJson(await response.responseBodyJson()))
      },
    );
  }

  /// Get the status of the current auth token (whether it was confirmed or not).
  /// get: /email/status
  ///
  @override
  Future<EmailStatusGetResponse> emailStatusGet() async {
    final request = OpenApiClientRequest(
      'get',
      '/email/status',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            EmailStatusGetResponse200.response200(
                EmailStatusGetResponseBody200.fromJson(
                    await response.responseBodyJson()))
      },
    );
  }

  /// Confirm email address
  /// get: /email/confirm
  ///
  /// * [token]: Unique token which was sent to email address.
  @override
  Future<EmailConfirmGetResponse> emailConfirmGet(
      {required String token}) async {
    final request = OpenApiClientRequest(
      'get',
      '/email/confirm',
      [],
    );
    request.addQueryParameter(
      'token',
      encodeString(token),
    );
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            EmailConfirmGetResponse200.response200(
                await response.responseBodyString()),
        '400': (OpenApiClientResponse response) async =>
            EmailConfirmGetResponse400.response400(
                await response.responseBodyString()),
      },
    );
  }

  /// Confirm with recaptcha
  /// post: /email/confirm
  ///
  @override
  Future<EmailConfirmPostResponse> emailConfirmPost(
      EmailConfirmPostSchema body) async {
    final request = OpenApiClientRequest(
      'post',
      '/email/confirm',
      [],
    );
    request.setHeader(
      'content-type',
      'application/x-www-form-urlencoded',
    );
    request.setBody(OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            EmailConfirmPostResponse200.response200(
                await response.responseBodyString()),
        '400': (OpenApiClientResponse response) async =>
            EmailConfirmPostResponse400.response400(),
      },
    );
  }

  /// Shows a form to enter email address to start deletion process.
  /// get: /user/delete
  ///
  @override
  Future<UserDeleteGetResponse> userDeleteGet() async {
    final request = OpenApiClientRequest(
      'get',
      '/user/delete',
      [],
    );
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            UserDeleteGetResponse200.response200(
                await response.responseBodyString())
      },
    );
  }

  /// Request user deletion.
  /// post: /user/delete
  ///
  @override
  Future<UserDeletePostResponse> userDeletePost(
      UserDeletePostSchema body) async {
    final request = OpenApiClientRequest(
      'post',
      '/user/delete',
      [],
    );
    request.setHeader(
      'content-type',
      'application/x-www-form-urlencoded',
    );
    request.setBody(OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            UserDeletePostResponse200.response200(
                await response.responseBodyString()),
        '404': (OpenApiClientResponse response) async =>
            UserDeletePostResponse404.response404(),
      },
    );
  }

  /// Confirm deleting of user/email address.
  /// get: /user/delete/confirm
  ///
  /// * [token]: Unique token which was sent to email address.
  @override
  Future<UserDeleteConfirmGetResponse> userDeleteConfirmGet(
      {required String token}) async {
    final request = OpenApiClientRequest(
      'get',
      '/user/delete/confirm',
      [],
    );
    request.addQueryParameter(
      'token',
      encodeString(token),
    );
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            UserDeleteConfirmGetResponse200.response200(
                await response.responseBodyString()),
        '400': (OpenApiClientResponse response) async =>
            UserDeleteConfirmGetResponse400.response400(
                await response.responseBodyString()),
      },
    );
  }

  /// Confirm with recaptcha
  /// post: /user/delete/confirm
  ///
  @override
  Future<UserDeleteConfirmPostResponse> userDeleteConfirmPost(
      UserDeleteConfirmPostSchema body) async {
    final request = OpenApiClientRequest(
      'post',
      '/user/delete/confirm',
      [],
    );
    request.setHeader(
      'content-type',
      'application/x-www-form-urlencoded',
    );
    request.setBody(OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            UserDeleteConfirmPostResponse200.response200(
                await response.responseBodyString()),
        '400': (OpenApiClientResponse response) async =>
            UserDeleteConfirmPostResponse400.response400(),
      },
    );
  }

  /// Get status of the user account.
  /// get: /status
  ///
  @override
  Future<StatusGetResponse> statusGet() async {
    final request = OpenApiClientRequest(
      'get',
      '/status',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            StatusGetResponse200.response200(StatusGetResponseBody200.fromJson(
                await response.responseBodyJson()))
      },
    );
  }

  /// List of all mailboxes of the current user.
  /// get: /mailbox
  ///
  @override
  Future<MailboxGetResponse> mailboxGet() async {
    final request = OpenApiClientRequest(
      'get',
      '/mailbox',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            MailboxGetResponse200.response200(
                MailboxGetResponseBody200.fromJson(
                    await response.responseBodyJson()))
      },
    );
  }

  /// Creates a new (random) email address mailbox.
  /// post: /mailbox/create
  ///
  @override
  Future<MailboxCreatePostResponse> mailboxCreatePost(
      MailboxCreatePostSchema body) async {
    final request = OpenApiClientRequest(
      'post',
      '/mailbox/create',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.setHeader(
      'content-type',
      'application/json',
    );
    request.setBody(OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            MailboxCreatePostResponse200.response200(
                MailboxCreatePostResponseBody200.fromJson(
                    await response.responseBodyJson()))
      },
    );
  }

  /// List all emails in all mailboxes of the current user.
  ///
  /// get: /mailbox/list
  ///
  /// * [pageToken]: Page token as returned by Page
  /// * [sinceToken]: As returned from a previous page object for a finished sync.
  @override
  Future<MailboxListGetResponse> mailboxListGet({
    String? pageToken,
    String? sinceToken,
  }) async {
    final request = OpenApiClientRequest(
      'get',
      '/mailbox/list',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.addQueryParameter(
      'page_token',
      encodeString(pageToken),
    );
    request.addQueryParameter(
      'since_token',
      encodeString(sinceToken),
    );
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            MailboxListGetResponse200.response200(
                MailboxListGetResponseBody200.fromJson(
                    await response.responseBodyJson()))
      },
    );
  }

  /// Apply the given update to all matching mails.
  /// post: /mail/massupdate
  ///
  @override
  Future<MailMassupdatePostResponse> mailMassupdatePost(
      MailMassupdatePostSchema body) async {
    final request = OpenApiClientRequest(
      'post',
      '/mail/massupdate',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.setHeader(
      'content-type',
      'application/json',
    );
    request.setBody(OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            MailMassupdatePostResponse200.response200()
      },
    );
  }

  /// Update information about mailbox
  /// put: /mailbox/update/{mailboxAddress}
  ///
  @override
  Future<MailboxUpdateResponse> mailboxUpdate(
    MailboxUpdateSchema body, {
    required String mailboxAddress,
  }) async {
    final request = OpenApiClientRequest(
      'put',
      '/mailbox/update/{mailboxAddress}',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.addPathParameter(
      'mailboxAddress',
      encodeString(mailboxAddress),
    );
    request.setHeader(
      'content-type',
      'application/json',
    );
    request.setBody(OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            MailboxUpdateResponse200.response200()
      },
    );
  }

  /// Fetch raw email message.
  /// get: /mailbox/message/{messageId}
  ///
  @override
  Future<MailboxMessageGetResponse> mailboxMessageGet(
      {required ApiUuid messageId}) async {
    final request = OpenApiClientRequest(
      'get',
      '/mailbox/message/{messageId}',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.addPathParameter(
      'messageId',
      encodeString(messageId.encodeToString()),
    );
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            MailboxMessageGetResponse200.response200(
                await response.responseBodyString())
      },
    );
  }

  /// Delete the given message.
  /// delete: /mailbox/message/{messageId}
  ///
  @override
  Future<MailboxMessageDeleteResponse> mailboxMessageDelete(
      {required ApiUuid messageId}) async {
    final request = OpenApiClientRequest(
      'delete',
      '/mailbox/message/{messageId}',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.addPathParameter(
      'messageId',
      encodeString(messageId.encodeToString()),
    );
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            MailboxMessageDeleteResponse200.response200()
      },
    );
  }

  /// Forward email to users actual email address
  /// post: /mailbox/message/{messageId}/forward
  ///
  @override
  Future<MailboxMessageForwardResponse> mailboxMessageForward(
    MailboxMessageForwardSchema body, {
    required ApiUuid messageId,
  }) async {
    final request = OpenApiClientRequest(
      'post',
      '/mailbox/message/{messageId}/forward',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.addPathParameter(
      'messageId',
      encodeString(messageId.encodeToString()),
    );
    request.setHeader(
      'content-type',
      'application/json',
    );
    request.setBody(OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            MailboxMessageForwardResponse200.response200()
      },
    );
  }

  /// Mark message as read
  /// put: /mailbox/message/{messageId}/read
  ///
  @override
  Future<MailboxMessageMarkReadResponse> mailboxMessageMarkRead(
      {required ApiUuid messageId}) async {
    final request = OpenApiClientRequest(
      'put',
      '/mailbox/message/{messageId}/read',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.addPathParameter(
      'messageId',
      encodeString(messageId.encodeToString()),
    );
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            MailboxMessageMarkReadResponse200.response200()
      },
    );
  }

  /// Mark message as unread (again)
  /// delete: /mailbox/message/{messageId}/read
  ///
  @override
  Future<MailboxMessageMarkUnReadResponse> mailboxMessageMarkUnRead(
      {required ApiUuid messageId}) async {
    final request = OpenApiClientRequest(
      'delete',
      '/mailbox/message/{messageId}/read',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.addPathParameter(
      'messageId',
      encodeString(messageId.encodeToString()),
    );
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            MailboxMessageMarkUnReadResponse200.response200()
      },
    );
  }

  /// Receive emails throw smtp bridge.
  /// post: /email/receive
  ///
  /// * [xAuthpassToken]: Security token to validate origin from trusted server
  /// [body]: Email content (header and body)
  @override
  Future<EmailReceivePostResponse> emailReceivePost(
    String body, {
    required String xAuthpassToken,
  }) async {
    final request = OpenApiClientRequest(
      'post',
      '/email/receive',
      [],
    );
    request.addHeaderParameter(
      'x-authpass-token',
      encodeString(xAuthpassToken),
    );
    request.setHeader(
      'content-type',
      'text/plain',
    );
    request.setBody(OpenApiClientRequestBodyText(body));
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            EmailReceivePostResponse200.response200(),
        '403': (OpenApiClientResponse response) async =>
            EmailReceivePostResponse403.response403(
                await response.responseBodyString()),
      },
    );
  }

  /// Retrieve file meta data.
  /// post: /filecloud/file/metadata
  ///
  /// [body]: Object wrapping a [fileToken].
  @override
  Future<FilecloudFileMetadataPostResponse> filecloudFileMetadataPost(
      FileId body) async {
    final request = OpenApiClientRequest(
      'post',
      '/filecloud/file/metadata',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.setHeader(
      'content-type',
      'application/json',
    );
    request.setBody(OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            FilecloudFileMetadataPostResponse200.response200(
                FileInfo.fromJson(await response.responseBodyJson()))
      },
    );
  }

  /// Retrieve a previously created file.
  /// post: /filecloud/file/retrieve
  ///
  /// [body]: Object wrapping a [fileToken].
  @override
  Future<FilecloudFileRetrievePostResponse> filecloudFileRetrievePost(
      FileId body) async {
    final request = OpenApiClientRequest(
      'post',
      '/filecloud/file/retrieve',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.setHeader(
      'content-type',
      'application/json',
    );
    request.setBody(OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            FilecloudFileRetrievePostResponse200.response200(
                await response.responseBodyBytes())
      },
    );
  }

  /// Deletes a file with the given fileToken
  /// post: /filecloud/file/delete
  ///
  /// [body]: Object wrapping a [fileToken].
  @override
  Future<FilecloudFileDeletePostResponse> filecloudFileDeletePost(
      FileId body) async {
    final request = OpenApiClientRequest(
      'post',
      '/filecloud/file/delete',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.setHeader(
      'content-type',
      'application/json',
    );
    request.setBody(OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(
      request,
      {
        '204': (OpenApiClientResponse response) async =>
            FilecloudFileDeletePostResponse204.response204()
      },
    );
  }

  /// Create file tokens which can be used to share the file.
  /// post: /filecloud/file/token/create
  ///
  @override
  Future<FilecloudFileTokenCreatePostResponse> filecloudFileTokenCreatePost(
      FilecloudFileTokenCreatePostSchema body) async {
    final request = OpenApiClientRequest(
      'post',
      '/filecloud/file/token/create',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.setHeader(
      'content-type',
      'application/json',
    );
    request.setBody(OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            FilecloudFileTokenCreatePostResponse200.response200(
                FileId.fromJson(await response.responseBodyJson()))
      },
    );
  }

  /// List all tokens for a given file. Only available for the owner of the file.
  /// post: /filecloud/file/token/list
  ///
  /// [body]: Object wrapping a [fileToken].
  @override
  Future<FilecloudFileTokenListPostResponse> filecloudFileTokenListPost(
      FileId body) async {
    final request = OpenApiClientRequest(
      'post',
      '/filecloud/file/token/list',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.setHeader(
      'content-type',
      'application/json',
    );
    request.setBody(OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            FilecloudFileTokenListPostResponse200.response200(
                FilecloudFileTokenListPostResponseBody200.fromJson(
                    await response.responseBodyJson()))
      },
    );
  }

  /// List available files for user
  /// get: /filecloud/file
  ///
  @override
  Future<FilecloudFileGetResponse> filecloudFileGet() async {
    final request = OpenApiClientRequest(
      'get',
      '/filecloud/file',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            FilecloudFileGetResponse200.response200(
                FileListResponse.fromJson(await response.responseBodyJson()))
      },
    );
  }

  /// Update file
  /// put: /filecloud/file
  ///
  @override
  Future<FilecloudFilePutResponse> filecloudFilePut(
    _i1.Uint8List body, {
    required String fileToken,
    required String versionToken,
  }) async {
    final request = OpenApiClientRequest(
      'put',
      '/filecloud/file',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.addHeaderParameter(
      'fileToken',
      encodeString(fileToken),
    );
    request.addHeaderParameter(
      'versionToken',
      encodeString(versionToken),
    );
    request.setHeader(
      'content-type',
      'application/octet-stream',
    );
    request.setBody(OpenApiClientRequestBodyBinary(body));
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            FilecloudFilePutResponse200.response200(
                FilecloudFilePutResponseBody200.fromJson(
                    await response.responseBodyJson())),
        '409': (OpenApiClientResponse response) async =>
            FilecloudFilePutResponse409.response409(),
      },
    );
  }

  /// Create new file
  /// post: /filecloud/file
  ///
  @override
  Future<FilecloudFilePostResponse> filecloudFilePost(
    _i1.Uint8List body, {
    required String fileName,
  }) async {
    final request = OpenApiClientRequest(
      'post',
      '/filecloud/file',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.addHeaderParameter(
      'fileName',
      encodeString(fileName),
    );
    request.setHeader(
      'content-type',
      'application/octet-stream',
    );
    request.setBody(OpenApiClientRequestBodyBinary(body));
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            FilecloudFilePostResponse200.response200(
                FilecloudFilePostResponseBody200.fromJson(
                    await response.responseBodyJson()))
      },
    );
  }

  /// Create attachment
  /// post: /filecloud/attachment
  ///
  @override
  Future<FilecloudAttachmentPostResponse> filecloudAttachmentPost(
    _i1.Uint8List body, {
    required String fileName,
    required String fileToken,
  }) async {
    final request = OpenApiClientRequest(
      'post',
      '/filecloud/attachment',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.addHeaderParameter(
      'fileName',
      encodeString(fileName),
    );
    request.addHeaderParameter(
      'fileToken',
      encodeString(fileToken),
    );
    request.setHeader(
      'content-type',
      'application/octet-stream',
    );
    request.setBody(OpenApiClientRequestBodyBinary(body));
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            FilecloudAttachmentPostResponse200.response200(
                FilecloudAttachmentPostResponseBody200.fromJson(
                    await response.responseBodyJson()))
      },
    );
  }

  /// Touches an attachment that it is still in use for the given file.
  /// post: /filecloud/attachment/touch
  ///
  @override
  Future<FilecloudAttachmentTouchPostResponse> filecloudAttachmentTouchPost(
      AttachmentTouch body) async {
    final request = OpenApiClientRequest(
      'post',
      '/filecloud/attachment/touch',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.setHeader(
      'content-type',
      'application/json',
    );
    request.setBody(OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            FilecloudAttachmentTouchPostResponse200.response200()
      },
    );
  }

  /// Release a attachment - used when an attachment is removed from a file.
  /// post: /filecloud/attachment/unlink
  ///
  @override
  Future<FilecloudAttachmentUnlinkPostResponse> filecloudAttachmentUnlinkPost(
      AttachmentTouch body) async {
    final request = OpenApiClientRequest(
      'post',
      '/filecloud/attachment/unlink',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.setHeader(
      'content-type',
      'application/json',
    );
    request.setBody(OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            FilecloudAttachmentUnlinkPostResponse200.response200()
      },
    );
  }

  /// Retrieve an attachment.
  /// post: /filecloud/attachment/retrieve
  ///
  /// [body]: Object wrapping a [attachmentToken].
  @override
  Future<FilecloudAttachmentRetrievePostResponse>
      filecloudAttachmentRetrievePost(AttachmentId body) async {
    final request = OpenApiClientRequest(
      'post',
      '/filecloud/attachment/retrieve',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.setHeader(
      'content-type',
      'application/json',
    );
    request.setBody(OpenApiClientRequestBodyJson(body.toJson()));
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            FilecloudAttachmentRetrievePostResponse200.response200(
                await response.responseBodyBytes())
      },
    );
  }

  /// Load the best image for the given website.
  /// get: /website/image
  ///
  @override
  Future<WebsiteImageGetResponse> websiteImageGet({required String url}) async {
    final request = OpenApiClientRequest(
      'get',
      '/website/image',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.addQueryParameter(
      'url',
      encodeString(url),
    );
    return await sendRequest(
      request,
      {
        '200': (OpenApiClientResponse response) async =>
            WebsiteImageGetResponse200.response200(
              response.responseContentType()!,
              await response.responseBodyBytes(),
            ),
        '404': (OpenApiClientResponse response) async =>
            WebsiteImageGetResponse404.response404(),
      },
    );
  }
}

class AuthPassCloudUrlResolve with OpenApiUrlEncodeMixin {
  /// Health check.
  /// Health check of endpoint data
  /// get: /check
  ///
  OpenApiClientRequest checkGet() {
    final request = OpenApiClientRequest(
      'get',
      '/check',
      [],
    );
    return request;
  }

  /// Status Check.
  /// post: /check/status
  ///
  OpenApiClientRequest checkStatusPost({String? xSecret}) {
    final request = OpenApiClientRequest(
      'post',
      '/check/status',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.addHeaderParameter(
      'x-secret',
      encodeString(xSecret),
    );
    return request;
  }

  /// Retrieve info about the currently logged in user and about the token.
  /// get: /user
  ///
  OpenApiClientRequest userGet() {
    final request = OpenApiClientRequest(
      'get',
      '/user',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    return request;
  }

  /// Create new user, or login the user using confirmation email.
  /// post: /user/register
  ///
  OpenApiClientRequest userRegisterPost() {
    final request = OpenApiClientRequest(
      'post',
      '/user/register',
      [],
    );
    return request;
  }

  /// Get the status of the current auth token (whether it was confirmed or not).
  /// get: /email/status
  ///
  OpenApiClientRequest emailStatusGet() {
    final request = OpenApiClientRequest(
      'get',
      '/email/status',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    return request;
  }

  /// Confirm email address
  /// get: /email/confirm
  ///
  /// * [token]: Unique token which was sent to email address.
  OpenApiClientRequest emailConfirmGet({required String token}) {
    final request = OpenApiClientRequest(
      'get',
      '/email/confirm',
      [],
    );
    request.addQueryParameter(
      'token',
      encodeString(token),
    );
    return request;
  }

  /// Confirm with recaptcha
  /// post: /email/confirm
  ///
  OpenApiClientRequest emailConfirmPost() {
    final request = OpenApiClientRequest(
      'post',
      '/email/confirm',
      [],
    );
    return request;
  }

  /// Shows a form to enter email address to start deletion process.
  /// get: /user/delete
  ///
  OpenApiClientRequest userDeleteGet() {
    final request = OpenApiClientRequest(
      'get',
      '/user/delete',
      [],
    );
    return request;
  }

  /// Request user deletion.
  /// post: /user/delete
  ///
  OpenApiClientRequest userDeletePost() {
    final request = OpenApiClientRequest(
      'post',
      '/user/delete',
      [],
    );
    return request;
  }

  /// Confirm deleting of user/email address.
  /// get: /user/delete/confirm
  ///
  /// * [token]: Unique token which was sent to email address.
  OpenApiClientRequest userDeleteConfirmGet({required String token}) {
    final request = OpenApiClientRequest(
      'get',
      '/user/delete/confirm',
      [],
    );
    request.addQueryParameter(
      'token',
      encodeString(token),
    );
    return request;
  }

  /// Confirm with recaptcha
  /// post: /user/delete/confirm
  ///
  OpenApiClientRequest userDeleteConfirmPost() {
    final request = OpenApiClientRequest(
      'post',
      '/user/delete/confirm',
      [],
    );
    return request;
  }

  /// Get status of the user account.
  /// get: /status
  ///
  OpenApiClientRequest statusGet() {
    final request = OpenApiClientRequest(
      'get',
      '/status',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    return request;
  }

  /// List of all mailboxes of the current user.
  /// get: /mailbox
  ///
  OpenApiClientRequest mailboxGet() {
    final request = OpenApiClientRequest(
      'get',
      '/mailbox',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    return request;
  }

  /// Creates a new (random) email address mailbox.
  /// post: /mailbox/create
  ///
  OpenApiClientRequest mailboxCreatePost() {
    final request = OpenApiClientRequest(
      'post',
      '/mailbox/create',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    return request;
  }

  /// List all emails in all mailboxes of the current user.
  ///
  /// get: /mailbox/list
  ///
  /// * [pageToken]: Page token as returned by Page
  /// * [sinceToken]: As returned from a previous page object for a finished sync.
  OpenApiClientRequest mailboxListGet({
    String? pageToken,
    String? sinceToken,
  }) {
    final request = OpenApiClientRequest(
      'get',
      '/mailbox/list',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.addQueryParameter(
      'page_token',
      encodeString(pageToken),
    );
    request.addQueryParameter(
      'since_token',
      encodeString(sinceToken),
    );
    return request;
  }

  /// Apply the given update to all matching mails.
  /// post: /mail/massupdate
  ///
  OpenApiClientRequest mailMassupdatePost() {
    final request = OpenApiClientRequest(
      'post',
      '/mail/massupdate',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    return request;
  }

  /// Update information about mailbox
  /// put: /mailbox/update/{mailboxAddress}
  ///
  OpenApiClientRequest mailboxUpdate({required String mailboxAddress}) {
    final request = OpenApiClientRequest(
      'put',
      '/mailbox/update/{mailboxAddress}',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.addPathParameter(
      'mailboxAddress',
      encodeString(mailboxAddress),
    );
    return request;
  }

  /// Fetch raw email message.
  /// get: /mailbox/message/{messageId}
  ///
  OpenApiClientRequest mailboxMessageGet({required ApiUuid messageId}) {
    final request = OpenApiClientRequest(
      'get',
      '/mailbox/message/{messageId}',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.addPathParameter(
      'messageId',
      encodeString(messageId.encodeToString()),
    );
    return request;
  }

  /// Delete the given message.
  /// delete: /mailbox/message/{messageId}
  ///
  OpenApiClientRequest mailboxMessageDelete({required ApiUuid messageId}) {
    final request = OpenApiClientRequest(
      'delete',
      '/mailbox/message/{messageId}',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.addPathParameter(
      'messageId',
      encodeString(messageId.encodeToString()),
    );
    return request;
  }

  /// Forward email to users actual email address
  /// post: /mailbox/message/{messageId}/forward
  ///
  OpenApiClientRequest mailboxMessageForward({required ApiUuid messageId}) {
    final request = OpenApiClientRequest(
      'post',
      '/mailbox/message/{messageId}/forward',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.addPathParameter(
      'messageId',
      encodeString(messageId.encodeToString()),
    );
    return request;
  }

  /// Mark message as read
  /// put: /mailbox/message/{messageId}/read
  ///
  OpenApiClientRequest mailboxMessageMarkRead({required ApiUuid messageId}) {
    final request = OpenApiClientRequest(
      'put',
      '/mailbox/message/{messageId}/read',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.addPathParameter(
      'messageId',
      encodeString(messageId.encodeToString()),
    );
    return request;
  }

  /// Mark message as unread (again)
  /// delete: /mailbox/message/{messageId}/read
  ///
  OpenApiClientRequest mailboxMessageMarkUnRead({required ApiUuid messageId}) {
    final request = OpenApiClientRequest(
      'delete',
      '/mailbox/message/{messageId}/read',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.addPathParameter(
      'messageId',
      encodeString(messageId.encodeToString()),
    );
    return request;
  }

  /// Receive emails throw smtp bridge.
  /// post: /email/receive
  ///
  /// * [xAuthpassToken]: Security token to validate origin from trusted server
  OpenApiClientRequest emailReceivePost({required String xAuthpassToken}) {
    final request = OpenApiClientRequest(
      'post',
      '/email/receive',
      [],
    );
    request.addHeaderParameter(
      'x-authpass-token',
      encodeString(xAuthpassToken),
    );
    return request;
  }

  /// Retrieve file meta data.
  /// post: /filecloud/file/metadata
  ///
  OpenApiClientRequest filecloudFileMetadataPost() {
    final request = OpenApiClientRequest(
      'post',
      '/filecloud/file/metadata',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    return request;
  }

  /// Retrieve a previously created file.
  /// post: /filecloud/file/retrieve
  ///
  OpenApiClientRequest filecloudFileRetrievePost() {
    final request = OpenApiClientRequest(
      'post',
      '/filecloud/file/retrieve',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    return request;
  }

  /// Deletes a file with the given fileToken
  /// post: /filecloud/file/delete
  ///
  OpenApiClientRequest filecloudFileDeletePost() {
    final request = OpenApiClientRequest(
      'post',
      '/filecloud/file/delete',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    return request;
  }

  /// Create file tokens which can be used to share the file.
  /// post: /filecloud/file/token/create
  ///
  OpenApiClientRequest filecloudFileTokenCreatePost() {
    final request = OpenApiClientRequest(
      'post',
      '/filecloud/file/token/create',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    return request;
  }

  /// List all tokens for a given file. Only available for the owner of the file.
  /// post: /filecloud/file/token/list
  ///
  OpenApiClientRequest filecloudFileTokenListPost() {
    final request = OpenApiClientRequest(
      'post',
      '/filecloud/file/token/list',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    return request;
  }

  /// List available files for user
  /// get: /filecloud/file
  ///
  OpenApiClientRequest filecloudFileGet() {
    final request = OpenApiClientRequest(
      'get',
      '/filecloud/file',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    return request;
  }

  /// Update file
  /// put: /filecloud/file
  ///
  OpenApiClientRequest filecloudFilePut({
    required String fileToken,
    required String versionToken,
  }) {
    final request = OpenApiClientRequest(
      'put',
      '/filecloud/file',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.addHeaderParameter(
      'fileToken',
      encodeString(fileToken),
    );
    request.addHeaderParameter(
      'versionToken',
      encodeString(versionToken),
    );
    return request;
  }

  /// Create new file
  /// post: /filecloud/file
  ///
  OpenApiClientRequest filecloudFilePost({required String fileName}) {
    final request = OpenApiClientRequest(
      'post',
      '/filecloud/file',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.addHeaderParameter(
      'fileName',
      encodeString(fileName),
    );
    return request;
  }

  /// Create attachment
  /// post: /filecloud/attachment
  ///
  OpenApiClientRequest filecloudAttachmentPost({
    required String fileName,
    required String fileToken,
  }) {
    final request = OpenApiClientRequest(
      'post',
      '/filecloud/attachment',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.addHeaderParameter(
      'fileName',
      encodeString(fileName),
    );
    request.addHeaderParameter(
      'fileToken',
      encodeString(fileToken),
    );
    return request;
  }

  /// Touches an attachment that it is still in use for the given file.
  /// post: /filecloud/attachment/touch
  ///
  OpenApiClientRequest filecloudAttachmentTouchPost() {
    final request = OpenApiClientRequest(
      'post',
      '/filecloud/attachment/touch',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    return request;
  }

  /// Release a attachment - used when an attachment is removed from a file.
  /// post: /filecloud/attachment/unlink
  ///
  OpenApiClientRequest filecloudAttachmentUnlinkPost() {
    final request = OpenApiClientRequest(
      'post',
      '/filecloud/attachment/unlink',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    return request;
  }

  /// Retrieve an attachment.
  /// post: /filecloud/attachment/retrieve
  ///
  OpenApiClientRequest filecloudAttachmentRetrievePost() {
    final request = OpenApiClientRequest(
      'post',
      '/filecloud/attachment/retrieve',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    return request;
  }

  /// Load the best image for the given website.
  /// get: /website/image
  ///
  OpenApiClientRequest websiteImageGet({required String url}) {
    final request = OpenApiClientRequest(
      'get',
      '/website/image',
      [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    request.addQueryParameter(
      'url',
      encodeString(url),
    );
    return request;
  }
}

class AuthPassCloudRouter extends OpenApiServerRouterBase {
  AuthPassCloudRouter(this.impl);

  final ApiEndpointProvider<AuthPassCloud> impl;

  @override
  void configure() {
    addRoute(
      '/check',
      'get',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.checkGet(),
        );
      },
      security: [],
    );
    addRoute(
      '/check/status',
      'post',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.checkStatusPost(
              xSecret: paramOpt(
            name: 'x-secret',
            value: request.headerParameter('x-secret'),
            decode: (value) => paramToString(value),
          )),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    addRoute(
      '/user',
      'get',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.userGet(),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    addRoute(
      '/user/register',
      'post',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.userRegisterPost(
              RegisterRequest.fromJson(await request.readJsonBody())),
        );
      },
      security: [],
    );
    addRoute(
      '/email/status',
      'get',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.emailStatusGet(),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    addRoute(
      '/email/confirm',
      'get',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.emailConfirmGet(
              token: paramRequired(
            name: 'token',
            value: request.queryParameter('token'),
            decode: (value) => paramToString(value),
          )),
        );
      },
      security: [],
    );
    addRoute(
      '/email/confirm',
      'post',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.emailConfirmPost(
              EmailConfirmPostSchema.fromJson(
                  await request.readUrlEncodedBodyFlat())),
        );
      },
      security: [],
    );
    addRoute(
      '/user/delete',
      'get',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.userDeleteGet(),
        );
      },
      security: [],
    );
    addRoute(
      '/user/delete',
      'post',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.userDeletePost(
              UserDeletePostSchema.fromJson(
                  await request.readUrlEncodedBodyFlat())),
        );
      },
      security: [],
    );
    addRoute(
      '/user/delete/confirm',
      'get',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.userDeleteConfirmGet(
              token: paramRequired(
            name: 'token',
            value: request.queryParameter('token'),
            decode: (value) => paramToString(value),
          )),
        );
      },
      security: [],
    );
    addRoute(
      '/user/delete/confirm',
      'post',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.userDeleteConfirmPost(
              UserDeleteConfirmPostSchema.fromJson(
                  await request.readUrlEncodedBodyFlat())),
        );
      },
      security: [],
    );
    addRoute(
      '/status',
      'get',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.statusGet(),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    addRoute(
      '/mailbox',
      'get',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailboxGet(),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    addRoute(
      '/mailbox/create',
      'post',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailboxCreatePost(
              MailboxCreatePostSchema.fromJson(await request.readJsonBody())),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    addRoute(
      '/mailbox/list',
      'get',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailboxListGet(
            pageToken: paramOpt(
              name: 'page_token',
              value: request.queryParameter('page_token'),
              decode: (value) => paramToString(value),
            ),
            sinceToken: paramOpt(
              name: 'since_token',
              value: request.queryParameter('since_token'),
              decode: (value) => paramToString(value),
            ),
          ),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    addRoute(
      '/mail/massupdate',
      'post',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailMassupdatePost(
              MailMassupdatePostSchema.fromJson(await request.readJsonBody())),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    addRoute(
      '/mailbox/update/{mailboxAddress}',
      'put',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailboxUpdate(
            MailboxUpdateSchema.fromJson(await request.readJsonBody()),
            mailboxAddress: paramRequired(
              name: 'mailboxAddress',
              value: request.pathParameter('mailboxAddress'),
              decode: (value) => paramToString(value),
            ),
          ),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    addRoute(
      '/mailbox/message/{messageId}',
      'get',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailboxMessageGet(
              messageId: paramRequired(
            name: 'messageId',
            value: request.pathParameter('messageId'),
            decode: (value) => ApiUuid.parse(paramToString(value)),
          )),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    addRoute(
      '/mailbox/message/{messageId}',
      'delete',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailboxMessageDelete(
              messageId: paramRequired(
            name: 'messageId',
            value: request.pathParameter('messageId'),
            decode: (value) => ApiUuid.parse(paramToString(value)),
          )),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    addRoute(
      '/mailbox/message/{messageId}/forward',
      'post',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailboxMessageForward(
            MailboxMessageForwardSchema.fromJson(await request.readJsonBody()),
            messageId: paramRequired(
              name: 'messageId',
              value: request.pathParameter('messageId'),
              decode: (value) => ApiUuid.parse(paramToString(value)),
            ),
          ),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    addRoute(
      '/mailbox/message/{messageId}/read',
      'put',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailboxMessageMarkRead(
              messageId: paramRequired(
            name: 'messageId',
            value: request.pathParameter('messageId'),
            decode: (value) => ApiUuid.parse(paramToString(value)),
          )),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    addRoute(
      '/mailbox/message/{messageId}/read',
      'delete',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.mailboxMessageMarkUnRead(
              messageId: paramRequired(
            name: 'messageId',
            value: request.pathParameter('messageId'),
            decode: (value) => ApiUuid.parse(paramToString(value)),
          )),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    addRoute(
      '/email/receive',
      'post',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.emailReceivePost(
            await request.readBodyString(),
            xAuthpassToken: paramRequired(
              name: 'x-authpass-token',
              value: request.headerParameter('x-authpass-token'),
              decode: (value) => paramToString(value),
            ),
          ),
        );
      },
      security: [],
    );
    addRoute(
      '/filecloud/file/metadata',
      'post',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.filecloudFileMetadataPost(
              FileId.fromJson(await request.readJsonBody())),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    addRoute(
      '/filecloud/file/retrieve',
      'post',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.filecloudFileRetrievePost(
              FileId.fromJson(await request.readJsonBody())),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    addRoute(
      '/filecloud/file/delete',
      'post',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.filecloudFileDeletePost(
              FileId.fromJson(await request.readJsonBody())),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    addRoute(
      '/filecloud/file/token/create',
      'post',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.filecloudFileTokenCreatePost(
              FilecloudFileTokenCreatePostSchema.fromJson(
                  await request.readJsonBody())),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    addRoute(
      '/filecloud/file/token/list',
      'post',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.filecloudFileTokenListPost(
              FileId.fromJson(await request.readJsonBody())),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    addRoute(
      '/filecloud/file',
      'get',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.filecloudFileGet(),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    addRoute(
      '/filecloud/file',
      'put',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.filecloudFilePut(
            await request.readBodyBytes(),
            fileToken: paramRequired(
              name: 'fileToken',
              value: request.headerParameter('fileToken'),
              decode: (value) => paramToString(value),
            ),
            versionToken: paramRequired(
              name: 'versionToken',
              value: request.headerParameter('versionToken'),
              decode: (value) => paramToString(value),
            ),
          ),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    addRoute(
      '/filecloud/file',
      'post',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.filecloudFilePost(
            await request.readBodyBytes(),
            fileName: paramRequired(
              name: 'fileName',
              value: request.headerParameter('fileName'),
              decode: (value) => paramToString(value),
            ),
          ),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    addRoute(
      '/filecloud/attachment',
      'post',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.filecloudAttachmentPost(
            await request.readBodyBytes(),
            fileName: paramRequired(
              name: 'fileName',
              value: request.headerParameter('fileName'),
              decode: (value) => paramToString(value),
            ),
            fileToken: paramRequired(
              name: 'fileToken',
              value: request.headerParameter('fileToken'),
              decode: (value) => paramToString(value),
            ),
          ),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    addRoute(
      '/filecloud/attachment/touch',
      'post',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.filecloudAttachmentTouchPost(
              AttachmentTouch.fromJson(await request.readJsonBody())),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    addRoute(
      '/filecloud/attachment/unlink',
      'post',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.filecloudAttachmentUnlinkPost(
              AttachmentTouch.fromJson(await request.readJsonBody())),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    addRoute(
      '/filecloud/attachment/retrieve',
      'post',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.filecloudAttachmentRetrievePost(
              AttachmentId.fromJson(await request.readJsonBody())),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
    addRoute(
      '/website/image',
      'get',
      (OpenApiRequest request) async {
        return await impl.invoke(
          request,
          (AuthPassCloud impl) async => impl.websiteImageGet(
              url: paramRequired(
            name: 'url',
            value: request.queryParameter('url'),
            decode: (value) => paramToString(value),
          )),
        );
      },
      security: [
        SecurityRequirement(schemes: [
          SecurityRequirementScheme(
            scheme: SecuritySchemes.authToken,
            scopes: [],
          )
        ])
      ],
    );
  }
}

class SecuritySchemes {
  static final authToken =
      SecuritySchemeHttp(scheme: SecuritySchemeHttpScheme.bearer);
}

T _throwStateError<T>(String message) => throw StateError(message);
