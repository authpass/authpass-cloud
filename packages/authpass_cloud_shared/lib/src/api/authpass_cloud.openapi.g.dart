// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authpass_cloud.openapi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemStatusUser _$SystemStatusUserFromJson(Map<String, dynamic> json) =>
    SystemStatusUser(
      emailConfirmed: (json['emailConfirmed'] as num).toInt(),
      userConfirmed: (json['userConfirmed'] as num).toInt(),
      emailUnconfirmed: (json['emailUnconfirmed'] as num).toInt(),
    );

Map<String, dynamic> _$SystemStatusUserToJson(SystemStatusUser instance) =>
    <String, dynamic>{
      'emailConfirmed': instance.emailConfirmed,
      'userConfirmed': instance.userConfirmed,
      'emailUnconfirmed': instance.emailUnconfirmed,
    };

SystemStatusWebsite _$SystemStatusWebsiteFromJson(Map<String, dynamic> json) =>
    SystemStatusWebsite(
      websiteCount: (json['websiteCount'] as num).toInt(),
      urlCanonicalCount: (json['urlCanonicalCount'] as num).toInt(),
    );

Map<String, dynamic> _$SystemStatusWebsiteToJson(
        SystemStatusWebsite instance) =>
    <String, dynamic>{
      'websiteCount': instance.websiteCount,
      'urlCanonicalCount': instance.urlCanonicalCount,
    };

SystemStatusMailbox _$SystemStatusMailboxFromJson(Map<String, dynamic> json) =>
    SystemStatusMailbox(
      mailboxCount: (json['mailboxCount'] as num).toInt(),
      messageCount: (json['messageCount'] as num).toInt(),
      messageReadCount: (json['messageReadCount'] as num).toInt(),
    );

Map<String, dynamic> _$SystemStatusMailboxToJson(
        SystemStatusMailbox instance) =>
    <String, dynamic>{
      'mailboxCount': instance.mailboxCount,
      'messageCount': instance.messageCount,
      'messageReadCount': instance.messageReadCount,
    };

SystemStatusFileCloud _$SystemStatusFileCloudFromJson(
        Map<String, dynamic> json) =>
    SystemStatusFileCloud(
      fileCount: (json['fileCount'] as num).toInt(),
      fileTotalLength: (json['fileTotalLength'] as num).toInt(),
      fileContentCount: (json['fileContentCount'] as num).toInt(),
      attachmentLength: (json['attachmentLength'] as num).toInt(),
      attachmentCount: (json['attachmentCount'] as num).toInt(),
      attachmentUntouchedMonth:
          (json['attachmentUntouchedMonth'] as num).toInt(),
      countRecentlyAccessed: (json['countRecentlyAccessed'] as num).toInt(),
      countWeekAccessed: (json['countWeekAccessed'] as num).toInt(),
    );

Map<String, dynamic> _$SystemStatusFileCloudToJson(
        SystemStatusFileCloud instance) =>
    <String, dynamic>{
      'fileCount': instance.fileCount,
      'fileTotalLength': instance.fileTotalLength,
      'fileContentCount': instance.fileContentCount,
      'attachmentLength': instance.attachmentLength,
      'attachmentCount': instance.attachmentCount,
      'attachmentUntouchedMonth': instance.attachmentUntouchedMonth,
      'countRecentlyAccessed': instance.countRecentlyAccessed,
      'countWeekAccessed': instance.countWeekAccessed,
    };

SystemStatus _$SystemStatusFromJson(Map<String, dynamic> json) => SystemStatus(
      user: SystemStatusUser.fromJson(json['user'] as Map<String, dynamic>),
      website:
          SystemStatusWebsite.fromJson(json['website'] as Map<String, dynamic>),
      mailbox:
          SystemStatusMailbox.fromJson(json['mailbox'] as Map<String, dynamic>),
      fileCloud: SystemStatusFileCloud.fromJson(
          json['fileCloud'] as Map<String, dynamic>),
      queryTime: (json['queryTime'] as num).toInt(),
    );

Map<String, dynamic> _$SystemStatusToJson(SystemStatus instance) =>
    <String, dynamic>{
      'user': instance.user,
      'website': instance.website,
      'mailbox': instance.mailbox,
      'fileCloud': instance.fileCloud,
      'queryTime': instance.queryTime,
    };

UserEmail _$UserEmailFromJson(Map<String, dynamic> json) => UserEmail(
      address: json['address'] as String,
      confirmedAt: DateTime.parse(json['confirmedAt'] as String),
    );

Map<String, dynamic> _$UserEmailToJson(UserEmail instance) => <String, dynamic>{
      'address': instance.address,
      'confirmedAt': instance.confirmedAt.toIso8601String(),
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      emails: (json['emails'] as List<dynamic>)
          .map((e) => UserEmail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'emails': instance.emails,
    };

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      email: json['email'] as String,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(
      userUuid: json['userUuid'] as String,
      authToken: json['authToken'] as String,
      status: $enumDecode(_$RegisterResponseStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'userUuid': instance.userUuid,
      'authToken': instance.authToken,
      'status': _$RegisterResponseStatusEnumMap[instance.status]!,
    };

const _$RegisterResponseStatusEnumMap = {
  RegisterResponseStatus.created: 'created',
  RegisterResponseStatus.confirmed: 'confirmed',
};

Page _$PageFromJson(Map<String, dynamic> json) => Page(
      nextPageToken: json['nextPageToken'] as String?,
      sinceToken: json['sinceToken'] as String?,
    );

Map<String, dynamic> _$PageToJson(Page instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('nextPageToken', instance.nextPageToken);
  writeNotNull('sinceToken', instance.sinceToken);
  return val;
}

EmailMessage _$EmailMessageFromJson(Map<String, dynamic> json) => EmailMessage(
      id: const ApiUuidJsonConverter().fromJson(json['id'] as String),
      subject: json['subject'] as String,
      sender: json['sender'] as String,
      mailboxEntryUuid: const ApiUuidJsonConverter()
          .fromJson(json['mailboxEntryUuid'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      size: (json['size'] as num).toInt(),
      isRead: json['isRead'] as bool,
    );

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

Mailbox _$MailboxFromJson(Map<String, dynamic> json) => Mailbox(
      id: const ApiUuidJsonConverter().fromJson(json['id'] as String),
      address: json['address'] as String,
      label: json['label'] as String,
      entryUuid: json['entryUuid'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isDisabled: json['isDisabled'] as bool,
    );

Map<String, dynamic> _$MailboxToJson(Mailbox instance) => <String, dynamic>{
      'id': const ApiUuidJsonConverter().toJson(instance.id),
      'address': instance.address,
      'label': instance.label,
      'entryUuid': instance.entryUuid,
      'createdAt': instance.createdAt.toIso8601String(),
      'isDisabled': instance.isDisabled,
    };

FileInfo _$FileInfoFromJson(Map<String, dynamic> json) => FileInfo(
      fileToken: json['fileToken'] as String,
      versionToken: json['versionToken'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      readOnly: json['readOnly'] as bool,
      size: (json['size'] as num).toInt(),
    );

Map<String, dynamic> _$FileInfoToJson(FileInfo instance) => <String, dynamic>{
      'fileToken': instance.fileToken,
      'versionToken': instance.versionToken,
      'name': instance.name,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'readOnly': instance.readOnly,
      'size': instance.size,
    };

FileListResponse _$FileListResponseFromJson(Map<String, dynamic> json) =>
    FileListResponse(
      files: (json['files'] as List<dynamic>)
          .map((e) => FileInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FileListResponseToJson(FileListResponse instance) =>
    <String, dynamic>{
      'files': instance.files,
    };

AttachmentId _$AttachmentIdFromJson(Map<String, dynamic> json) => AttachmentId(
      attachmentToken: json['attachmentToken'] as String,
    );

Map<String, dynamic> _$AttachmentIdToJson(AttachmentId instance) =>
    <String, dynamic>{
      'attachmentToken': instance.attachmentToken,
    };

FileId _$FileIdFromJson(Map<String, dynamic> json) => FileId(
      fileToken: json['fileToken'] as String,
    );

Map<String, dynamic> _$FileIdToJson(FileId instance) => <String, dynamic>{
      'fileToken': instance.fileToken,
    };

AttachmentTouch _$AttachmentTouchFromJson(Map<String, dynamic> json) =>
    AttachmentTouch(
      file: FileId.fromJson(json['file'] as Map<String, dynamic>),
      attachmentTokens: (json['attachmentTokens'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AttachmentTouchToJson(AttachmentTouch instance) =>
    <String, dynamic>{
      'file': instance.file,
      'attachmentTokens': instance.attachmentTokens,
    };

FileTokenInfo _$FileTokenInfoFromJson(Map<String, dynamic> json) =>
    FileTokenInfo(
      fileToken: json['fileToken'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      label: json['label'] as String,
      readOnly: json['readOnly'] as bool,
    );

Map<String, dynamic> _$FileTokenInfoToJson(FileTokenInfo instance) =>
    <String, dynamic>{
      'fileToken': instance.fileToken,
      'createdAt': instance.createdAt.toIso8601String(),
      'label': instance.label,
      'readOnly': instance.readOnly,
    };

EmailStatusGetResponseBody200 _$EmailStatusGetResponseBody200FromJson(
        Map<String, dynamic> json) =>
    EmailStatusGetResponseBody200(
      status: $enumDecodeNullable(
          _$EmailStatusGetResponseBody200StatusEnumMap, json['status']),
    );

Map<String, dynamic> _$EmailStatusGetResponseBody200ToJson(
    EmailStatusGetResponseBody200 instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'status', _$EmailStatusGetResponseBody200StatusEnumMap[instance.status]);
  return val;
}

const _$EmailStatusGetResponseBody200StatusEnumMap = {
  EmailStatusGetResponseBody200Status.created: 'created',
  EmailStatusGetResponseBody200Status.confirmed: 'confirmed',
};

EmailConfirmPostSchema _$EmailConfirmPostSchemaFromJson(
        Map<String, dynamic> json) =>
    EmailConfirmPostSchema(
      token: json['token'] as String,
      gRecaptchaResponse: json['g-recaptcha-response'] as String,
    );

Map<String, dynamic> _$EmailConfirmPostSchemaToJson(
        EmailConfirmPostSchema instance) =>
    <String, dynamic>{
      'token': instance.token,
      'g-recaptcha-response': instance.gRecaptchaResponse,
    };

UserDeletePostSchema _$UserDeletePostSchemaFromJson(
        Map<String, dynamic> json) =>
    UserDeletePostSchema(
      email: json['email'] as String,
    );

Map<String, dynamic> _$UserDeletePostSchemaToJson(
        UserDeletePostSchema instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

UserDeleteConfirmPostSchema _$UserDeleteConfirmPostSchemaFromJson(
        Map<String, dynamic> json) =>
    UserDeleteConfirmPostSchema(
      token: json['token'] as String,
      gRecaptchaResponse: json['g-recaptcha-response'] as String,
    );

Map<String, dynamic> _$UserDeleteConfirmPostSchemaToJson(
        UserDeleteConfirmPostSchema instance) =>
    <String, dynamic>{
      'token': instance.token,
      'g-recaptcha-response': instance.gRecaptchaResponse,
    };

StatusGetResponseBody200Mail _$StatusGetResponseBody200MailFromJson(
        Map<String, dynamic> json) =>
    StatusGetResponseBody200Mail(
      messagesUnread: (json['messagesUnread'] as num).toInt(),
    );

Map<String, dynamic> _$StatusGetResponseBody200MailToJson(
        StatusGetResponseBody200Mail instance) =>
    <String, dynamic>{
      'messagesUnread': instance.messagesUnread,
    };

StatusGetResponseBody200 _$StatusGetResponseBody200FromJson(
        Map<String, dynamic> json) =>
    StatusGetResponseBody200(
      mail: StatusGetResponseBody200Mail.fromJson(
          json['mail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StatusGetResponseBody200ToJson(
        StatusGetResponseBody200 instance) =>
    <String, dynamic>{
      'mail': instance.mail,
    };

MailboxGetResponseBody200 _$MailboxGetResponseBody200FromJson(
        Map<String, dynamic> json) =>
    MailboxGetResponseBody200(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Mailbox.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MailboxGetResponseBody200ToJson(
    MailboxGetResponseBody200 instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data);
  return val;
}

MailboxCreatePostResponseBody200 _$MailboxCreatePostResponseBody200FromJson(
        Map<String, dynamic> json) =>
    MailboxCreatePostResponseBody200(
      address: json['address'] as String?,
    );

Map<String, dynamic> _$MailboxCreatePostResponseBody200ToJson(
    MailboxCreatePostResponseBody200 instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('address', instance.address);
  return val;
}

MailboxCreatePostSchema _$MailboxCreatePostSchemaFromJson(
        Map<String, dynamic> json) =>
    MailboxCreatePostSchema(
      label: json['label'] as String,
      entryUuid: json['entryUuid'] as String,
    );

Map<String, dynamic> _$MailboxCreatePostSchemaToJson(
        MailboxCreatePostSchema instance) =>
    <String, dynamic>{
      'label': instance.label,
      'entryUuid': instance.entryUuid,
    };

MailboxListGetResponseBody200 _$MailboxListGetResponseBody200FromJson(
        Map<String, dynamic> json) =>
    MailboxListGetResponseBody200(
      page: Page.fromJson(json['page'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>)
          .map((e) => EmailMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MailboxListGetResponseBody200ToJson(
        MailboxListGetResponseBody200 instance) =>
    <String, dynamic>{
      'page': instance.page,
      'data': instance.data,
    };

MailMassupdatePostSchema _$MailMassupdatePostSchemaFromJson(
        Map<String, dynamic> json) =>
    MailMassupdatePostSchema(
      filter:
          $enumDecode(_$MailMassupdatePostSchemaFilterEnumMap, json['filter']),
      messageIds: (json['messageIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isRead: json['isRead'] as bool?,
    );

Map<String, dynamic> _$MailMassupdatePostSchemaToJson(
    MailMassupdatePostSchema instance) {
  final val = <String, dynamic>{
    'filter': _$MailMassupdatePostSchemaFilterEnumMap[instance.filter]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('messageIds', instance.messageIds);
  writeNotNull('isRead', instance.isRead);
  return val;
}

const _$MailMassupdatePostSchemaFilterEnumMap = {
  MailMassupdatePostSchemaFilter.messageIds: 'messageIds',
  MailMassupdatePostSchemaFilter.all: 'all',
};

MailboxUpdateSchema _$MailboxUpdateSchemaFromJson(Map<String, dynamic> json) =>
    MailboxUpdateSchema(
      label: json['label'] as String?,
      entryUuid: json['entryUuid'] as String?,
      isDeleted: json['isDeleted'] as bool?,
      isDisabled: json['isDisabled'] as bool?,
      isHidden: json['isHidden'] as bool?,
    );

Map<String, dynamic> _$MailboxUpdateSchemaToJson(MailboxUpdateSchema instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('label', instance.label);
  writeNotNull('entryUuid', instance.entryUuid);
  writeNotNull('isDeleted', instance.isDeleted);
  writeNotNull('isDisabled', instance.isDisabled);
  writeNotNull('isHidden', instance.isHidden);
  return val;
}

MailboxMessageForwardSchema _$MailboxMessageForwardSchemaFromJson(
        Map<String, dynamic> json) =>
    MailboxMessageForwardSchema(
      email: json['email'] as String?,
    );

Map<String, dynamic> _$MailboxMessageForwardSchemaToJson(
    MailboxMessageForwardSchema instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('email', instance.email);
  return val;
}

FilecloudFileTokenCreatePostSchema _$FilecloudFileTokenCreatePostSchemaFromJson(
        Map<String, dynamic> json) =>
    FilecloudFileTokenCreatePostSchema(
      fileToken: json['fileToken'] as String,
      label: json['label'] as String,
      userEmail: json['userEmail'] as String?,
      readOnly: json['readOnly'] as bool? ?? false,
    );

Map<String, dynamic> _$FilecloudFileTokenCreatePostSchemaToJson(
    FilecloudFileTokenCreatePostSchema instance) {
  final val = <String, dynamic>{
    'fileToken': instance.fileToken,
    'label': instance.label,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('userEmail', instance.userEmail);
  val['readOnly'] = instance.readOnly;
  return val;
}

FilecloudFileTokenListPostResponseBody200
    _$FilecloudFileTokenListPostResponseBody200FromJson(
            Map<String, dynamic> json) =>
        FilecloudFileTokenListPostResponseBody200(
          tokens: (json['tokens'] as List<dynamic>)
              .map((e) => FileTokenInfo.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$FilecloudFileTokenListPostResponseBody200ToJson(
        FilecloudFileTokenListPostResponseBody200 instance) =>
    <String, dynamic>{
      'tokens': instance.tokens,
    };

FilecloudFilePutResponseBody200 _$FilecloudFilePutResponseBody200FromJson(
        Map<String, dynamic> json) =>
    FilecloudFilePutResponseBody200(
      versionToken: json['versionToken'] as String,
    );

Map<String, dynamic> _$FilecloudFilePutResponseBody200ToJson(
        FilecloudFilePutResponseBody200 instance) =>
    <String, dynamic>{
      'versionToken': instance.versionToken,
    };

FilecloudFilePostResponseBody200 _$FilecloudFilePostResponseBody200FromJson(
        Map<String, dynamic> json) =>
    FilecloudFilePostResponseBody200(
      fileToken: json['fileToken'] as String,
      versionToken: json['versionToken'] as String,
    );

Map<String, dynamic> _$FilecloudFilePostResponseBody200ToJson(
        FilecloudFilePostResponseBody200 instance) =>
    <String, dynamic>{
      'fileToken': instance.fileToken,
      'versionToken': instance.versionToken,
    };

FilecloudAttachmentPostResponseBody200
    _$FilecloudAttachmentPostResponseBody200FromJson(
            Map<String, dynamic> json) =>
        FilecloudAttachmentPostResponseBody200(
          attachmentToken: json['attachmentToken'] as String,
        );

Map<String, dynamic> _$FilecloudAttachmentPostResponseBody200ToJson(
        FilecloudAttachmentPostResponseBody200 instance) =>
    <String, dynamic>{
      'attachmentToken': instance.attachmentToken,
    };
