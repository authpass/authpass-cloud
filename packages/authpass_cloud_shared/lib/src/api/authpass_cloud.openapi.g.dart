// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authpass_cloud.openapi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemStatusUser _$SystemStatusUserFromJson(Map<String, dynamic> json) {
  return SystemStatusUser(
    emailConfirmed: json['emailConfirmed'] as int,
    userConfirmed: json['userConfirmed'] as int,
    emailUnconfirmed: json['emailUnconfirmed'] as int,
  );
}

Map<String, dynamic> _$SystemStatusUserToJson(SystemStatusUser instance) =>
    <String, dynamic>{
      'emailConfirmed': instance.emailConfirmed,
      'userConfirmed': instance.userConfirmed,
      'emailUnconfirmed': instance.emailUnconfirmed,
    };

SystemStatusWebsite _$SystemStatusWebsiteFromJson(Map<String, dynamic> json) {
  return SystemStatusWebsite(
    websiteCount: json['websiteCount'] as int,
    urlCanonicalCount: json['urlCanonicalCount'] as int,
  );
}

Map<String, dynamic> _$SystemStatusWebsiteToJson(
        SystemStatusWebsite instance) =>
    <String, dynamic>{
      'websiteCount': instance.websiteCount,
      'urlCanonicalCount': instance.urlCanonicalCount,
    };

SystemStatusMailbox _$SystemStatusMailboxFromJson(Map<String, dynamic> json) {
  return SystemStatusMailbox(
    mailboxCount: json['mailboxCount'] as int,
    messageCount: json['messageCount'] as int,
    messageReadCount: json['messageReadCount'] as int,
  );
}

Map<String, dynamic> _$SystemStatusMailboxToJson(
        SystemStatusMailbox instance) =>
    <String, dynamic>{
      'mailboxCount': instance.mailboxCount,
      'messageCount': instance.messageCount,
      'messageReadCount': instance.messageReadCount,
    };

SystemStatus _$SystemStatusFromJson(Map<String, dynamic> json) {
  return SystemStatus(
    user: SystemStatusUser.fromJson(json['user'] as Map<String, dynamic>),
    website:
        SystemStatusWebsite.fromJson(json['website'] as Map<String, dynamic>),
    mailbox:
        SystemStatusMailbox.fromJson(json['mailbox'] as Map<String, dynamic>),
    queryTime: json['queryTime'] as int,
  );
}

Map<String, dynamic> _$SystemStatusToJson(SystemStatus instance) =>
    <String, dynamic>{
      'user': instance.user,
      'website': instance.website,
      'mailbox': instance.mailbox,
      'queryTime': instance.queryTime,
    };

UserEmail _$UserEmailFromJson(Map<String, dynamic> json) {
  return UserEmail(
    address: json['address'] as String,
    confirmedAt: DateTime.parse(json['confirmedAt'] as String),
  );
}

Map<String, dynamic> _$UserEmailToJson(UserEmail instance) => <String, dynamic>{
      'address': instance.address,
      'confirmedAt': instance.confirmedAt.toIso8601String(),
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
    emails: (json['emails'] as List<dynamic>?)
        ?.map((e) => UserEmail.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'emails': instance.emails,
    };

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) {
  return RegisterRequest(
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) {
  return RegisterResponse(
    userUuid: json['userUuid'] as String,
    authToken: json['authToken'] as String,
    status: _$enumDecode(_$RegisterResponseStatusEnumMap, json['status']),
  );
}

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'userUuid': instance.userUuid,
      'authToken': instance.authToken,
      'status': _$RegisterResponseStatusEnumMap[instance.status],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$RegisterResponseStatusEnumMap = {
  RegisterResponseStatus.created: 'created',
  RegisterResponseStatus.confirmed: 'confirmed',
};

Page _$PageFromJson(Map<String, dynamic> json) {
  return Page(
    nextPageToken: json['nextPageToken'] as String?,
    sinceToken: json['sinceToken'] as String?,
  );
}

Map<String, dynamic> _$PageToJson(Page instance) => <String, dynamic>{
      'nextPageToken': instance.nextPageToken,
      'sinceToken': instance.sinceToken,
    };

EmailMessage _$EmailMessageFromJson(Map<String, dynamic> json) {
  return EmailMessage(
    id: const ApiUuidJsonConverter().fromJson(json['id'] as String),
    subject: json['subject'] as String,
    sender: json['sender'] as String,
    mailboxEntryUuid: const ApiUuidJsonConverter()
        .fromJson(json['mailboxEntryUuid'] as String),
    createdAt: DateTime.parse(json['createdAt'] as String),
    size: json['size'] as int,
    isRead: json['isRead'] as bool,
  );
}

Map<String, dynamic> _$EmailMessageToJson(EmailMessage instance) =>
    <String, dynamic>{
      'id': const ApiUuidJsonConverter().toJson(instance.id),
      'subject': instance.subject,
      'sender': instance.sender,
      'mailboxEntryUuid':
          const ApiUuidJsonConverter().toJson(instance.mailboxEntryUuid),
      'createdAt': instance.createdAt.toIso8601String(),
      'size': instance.size,
      'isRead': instance.isRead,
    };

Mailbox _$MailboxFromJson(Map<String, dynamic> json) {
  return Mailbox(
    id: const ApiUuidJsonConverter().fromJson(json['id'] as String),
    address: json['address'] as String,
    label: json['label'] as String,
    entryUuid: json['entryUuid'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    isDisabled: json['isDisabled'] as bool,
  );
}

Map<String, dynamic> _$MailboxToJson(Mailbox instance) => <String, dynamic>{
      'id': const ApiUuidJsonConverter().toJson(instance.id),
      'address': instance.address,
      'label': instance.label,
      'entryUuid': instance.entryUuid,
      'createdAt': instance.createdAt.toIso8601String(),
      'isDisabled': instance.isDisabled,
    };

EmailStatusGetResponseBody200 _$EmailStatusGetResponseBody200FromJson(
    Map<String, dynamic> json) {
  return EmailStatusGetResponseBody200(
    status: _$enumDecodeNullable(
        _$EmailStatusGetResponseBody200StatusEnumMap, json['status']),
  );
}

Map<String, dynamic> _$EmailStatusGetResponseBody200ToJson(
        EmailStatusGetResponseBody200 instance) =>
    <String, dynamic>{
      'status': _$EmailStatusGetResponseBody200StatusEnumMap[instance.status],
    };

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$EmailStatusGetResponseBody200StatusEnumMap = {
  EmailStatusGetResponseBody200Status.created: 'created',
  EmailStatusGetResponseBody200Status.confirmed: 'confirmed',
};

EmailConfirmPostSchema _$EmailConfirmPostSchemaFromJson(
    Map<String, dynamic> json) {
  return EmailConfirmPostSchema(
    token: json['token'] as String,
    gRecaptchaResponse: json['g-recaptcha-response'] as String,
  );
}

Map<String, dynamic> _$EmailConfirmPostSchemaToJson(
        EmailConfirmPostSchema instance) =>
    <String, dynamic>{
      'token': instance.token,
      'g-recaptcha-response': instance.gRecaptchaResponse,
    };

StatusGetResponseBody200Mail _$StatusGetResponseBody200MailFromJson(
    Map<String, dynamic> json) {
  return StatusGetResponseBody200Mail(
    messagesUnread: json['messagesUnread'] as int,
  );
}

Map<String, dynamic> _$StatusGetResponseBody200MailToJson(
        StatusGetResponseBody200Mail instance) =>
    <String, dynamic>{
      'messagesUnread': instance.messagesUnread,
    };

StatusGetResponseBody200 _$StatusGetResponseBody200FromJson(
    Map<String, dynamic> json) {
  return StatusGetResponseBody200(
    mail: StatusGetResponseBody200Mail.fromJson(
        json['mail'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$StatusGetResponseBody200ToJson(
        StatusGetResponseBody200 instance) =>
    <String, dynamic>{
      'mail': instance.mail,
    };

MailboxGetResponseBody200 _$MailboxGetResponseBody200FromJson(
    Map<String, dynamic> json) {
  return MailboxGetResponseBody200(
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => Mailbox.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MailboxGetResponseBody200ToJson(
        MailboxGetResponseBody200 instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

MailboxCreatePostResponseBody200 _$MailboxCreatePostResponseBody200FromJson(
    Map<String, dynamic> json) {
  return MailboxCreatePostResponseBody200(
    address: json['address'] as String?,
  );
}

Map<String, dynamic> _$MailboxCreatePostResponseBody200ToJson(
        MailboxCreatePostResponseBody200 instance) =>
    <String, dynamic>{
      'address': instance.address,
    };

MailboxCreatePostSchema _$MailboxCreatePostSchemaFromJson(
    Map<String, dynamic> json) {
  return MailboxCreatePostSchema(
    label: json['label'] as String,
    entryUuid: json['entryUuid'] as String,
  );
}

Map<String, dynamic> _$MailboxCreatePostSchemaToJson(
        MailboxCreatePostSchema instance) =>
    <String, dynamic>{
      'label': instance.label,
      'entryUuid': instance.entryUuid,
    };

MailboxListGetResponseBody200 _$MailboxListGetResponseBody200FromJson(
    Map<String, dynamic> json) {
  return MailboxListGetResponseBody200(
    page: Page.fromJson(json['page'] as Map<String, dynamic>),
    data: (json['data'] as List<dynamic>)
        .map((e) => EmailMessage.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MailboxListGetResponseBody200ToJson(
        MailboxListGetResponseBody200 instance) =>
    <String, dynamic>{
      'page': instance.page,
      'data': instance.data,
    };

MailMassupdatePostSchema _$MailMassupdatePostSchemaFromJson(
    Map<String, dynamic> json) {
  return MailMassupdatePostSchema(
    filter:
        _$enumDecode(_$MailMassupdatePostSchemaFilterEnumMap, json['filter']),
    messageIds: (json['messageIds'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    isRead: json['isRead'] as bool?,
  );
}

Map<String, dynamic> _$MailMassupdatePostSchemaToJson(
        MailMassupdatePostSchema instance) =>
    <String, dynamic>{
      'filter': _$MailMassupdatePostSchemaFilterEnumMap[instance.filter],
      'messageIds': instance.messageIds,
      'isRead': instance.isRead,
    };

const _$MailMassupdatePostSchemaFilterEnumMap = {
  MailMassupdatePostSchemaFilter.messageIds: 'messageIds',
  MailMassupdatePostSchemaFilter.all: 'all',
};

MailboxUpdateSchema _$MailboxUpdateSchemaFromJson(Map<String, dynamic> json) {
  return MailboxUpdateSchema(
    label: json['label'] as String?,
    entryUuid: json['entryUuid'] as String?,
    isDeleted: json['isDeleted'] as bool?,
    isDisabled: json['isDisabled'] as bool?,
    isHidden: json['isHidden'] as bool?,
  );
}

Map<String, dynamic> _$MailboxUpdateSchemaToJson(
        MailboxUpdateSchema instance) =>
    <String, dynamic>{
      'label': instance.label,
      'entryUuid': instance.entryUuid,
      'isDeleted': instance.isDeleted,
      'isDisabled': instance.isDisabled,
      'isHidden': instance.isHidden,
    };

MailboxMessageForwardSchema _$MailboxMessageForwardSchemaFromJson(
    Map<String, dynamic> json) {
  return MailboxMessageForwardSchema(
    email: json['email'] as String?,
  );
}

Map<String, dynamic> _$MailboxMessageForwardSchemaToJson(
        MailboxMessageForwardSchema instance) =>
    <String, dynamic>{
      'email': instance.email,
    };
