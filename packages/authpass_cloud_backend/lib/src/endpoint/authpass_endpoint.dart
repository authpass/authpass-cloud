import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/dao/email_repository.dart';
import 'package:authpass_cloud_backend/src/dao/filecloud_repository.dart';
import 'package:authpass_cloud_backend/src/dao/system_dao.dart';
import 'package:authpass_cloud_backend/src/dao/tables/user_tables.dart';
import 'package:authpass_cloud_backend/src/dao/user_repository.dart';
import 'package:authpass_cloud_backend/src/dao/website_repository.dart';
import 'package:authpass_cloud_backend/src/endpoint/email_confirmation.dart';
import 'package:authpass_cloud_backend/src/env/env.dart';
import 'package:authpass_cloud_backend/src/service/service_provider.dart';
import 'package:authpass_cloud_backend/src/util/extension_methods.dart';
import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:openapi_base/openapi_base.dart';
import 'package:smtpd/smtpd.dart';

final _logger = Logger('authpass_service');

abstract class RepositoryProvider {
  UserRepository get user;
  EmailRepository get email;
  WebsiteRepository get website;
  FileCloudRepository get fileCloud;
}

class AuthPassCloudImpl extends AuthPassCloud {
  AuthPassCloudImpl(
    this.serviceProvider,
    this.request,
    this.db,
    this.repository,
  );

  final ServiceProvider serviceProvider;
  final OpenApiRequest request;
  final DatabaseTransaction db;
  @visibleForTesting
  final RepositoryProvider repository;

  Env get _env => serviceProvider.env;

  @override
  Future<CheckGetResponse> checkGet() async {
    // just make sure we still have a DB connection.
    await db.tables.migration.queryLastVersion(db);
    return CheckGetResponse.response200();
  }

  @override
  Future<UserGetResponse> userGet() async {
    final authToken = await _requireAuthToken();
    return UserGetResponse.response200(
        await repository.user.findUserInfo(authToken: authToken));
  }

  @override
  Future<UserRegisterPostResponse> userRegisterPost(
      RegisterRequest body) async {
    final emailConfirm = await repository.user.createUserOrConfirmEmail(
      body.email,
      request.headerParameter(HttpHeaders.userAgentHeader).single,
    );
    final authToken = ArgumentError.checkNotNull(emailConfirm.authToken);
    final urlResolve = AuthPassCloudUrlResolve();
    final url = urlResolve
        .emailConfirmGet(token: emailConfirm.token)
        .resolveUri(serviceProvider.env.baseUri);
    await serviceProvider.emailService.sendEmailConfirmationToken(
        emailConfirm.email.emailAddress, url.toString());
    _logger.fine('Creating new user. ${body.email}');
    return UserRegisterPostResponse.response200(RegisterResponse(
      userUuid: emailConfirm.email.user.id,
      authToken: authToken.token,
      status: RegisterResponseStatus.created,
    ));
  }

  @override
  Future<EmailConfirmGetResponse> emailConfirmGet(
      {required String token}) async {
    if (!await repository.user.isValidEmailConfirmToken(token)) {
      return EmailConfirmGetResponse.response400(
          emailConfirmationTokenError(serviceProvider.env));
    }
    return EmailConfirmGetResponse.response200(
        emailConfirmationPage(serviceProvider.env, token));
//    throw UnimplementedError();
  }

  @override
  Future<EmailConfirmPostResponse> emailConfirmPost(
      EmailConfirmPostSchema body) async {
    final success =
        await serviceProvider.recaptchaService.verify(body.gRecaptchaResponse);
    if (success) {
      await repository.user.confirmEmailAddress(body.token);
      return EmailConfirmPostResponse.response200(
          emailConfirmationSuccess(serviceProvider.env));
    }
    return EmailConfirmPostResponse.response400();
  }

  @override
  Future<EmailStatusGetResponse> emailStatusGet() async {
    final token = await _requireAuthToken(acceptUnconfirmed: true);

    final status = token.status == AuthTokenStatus.created
        ? EmailStatusGetResponseBody200Status.created
        : EmailStatusGetResponseBody200Status.confirmed;
    return EmailStatusGetResponse.response200(
        EmailStatusGetResponseBody200(status: status));
  }

  String? _authTokenString() {
    final data = SecuritySchemes.authToken.fromRequest(request);
    final bearerToken = data?.bearerToken;
    if (data == null || bearerToken == null || bearerToken.isEmpty) {
      return null;
    }
    return bearerToken;
  }

  Future<AuthTokenEntity?> _optionalAuthToken(
      {bool acceptUnconfirmed = false}) async {
    return _authTokenString()
        ?.let((bearerToken) => repository.user.findValidAuthToken(
              bearerToken,
              acceptUnconfirmed: acceptUnconfirmed,
            ));
  }

  Future<AuthTokenEntity> _requireAuthToken(
      {bool acceptUnconfirmed = false}) async {
    final bearerToken = _authTokenString();
    if (bearerToken == null) {
      throw UnauthorizedException('Missing auth token.');
    }
    final validToken = await repository.user.findValidAuthToken(
      bearerToken,
      acceptUnconfirmed: acceptUnconfirmed,
    );

    if (validToken == null) {
      throw UnauthorizedException('No valid auth token.');
    }

    return validToken;
  }

  @override
  Future<EmailReceivePostResponse> emailReceivePost(String body,
      {String? xAuthpassToken}) async {
    if (xAuthpassToken != _env.config.secrets.emailReceiveToken) {
      return EmailReceivePostResponse.response403(MailSystemStatusCodes
          .errorNotAcceptingNetworkMessages
          .toString(message: 'Permission denied.'));
    }
    final status =
        await serviceProvider.emailDeliveryService.deliverEmail(db, body);
    if (status.isSuccess) {
      return EmailReceivePostResponse.response200();
    } else {
      return EmailReceivePostResponse.response403(status.toString());
    }
  }

  @override
  Future<MailboxCreatePostResponse> mailboxCreatePost(
      MailboxCreatePostSchema body) async {
    final token = await _requireAuthToken();
    final address = await repository.email.createAddress(
      token.user,
      label: body.label,
      clientEntryUuid: body.entryUuid,
    );
    return MailboxCreatePostResponse.response200(
        MailboxCreatePostResponseBody200(address: address));
  }

  @override
  Future<MailboxListGetResponse> mailboxListGet({
    String? pageToken,
    String? sinceToken,
  }) async {
    final token = await _requireAuthToken();
    final page = pageToken != null
        ? PageToken.decode(pageToken)
        : PageToken(
            0,
            clock.now().toUtc(),
            sinceToken != null
                ? DateTime.parse(sinceToken).toUtc()
                : DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
          );

    const limit = 50;

    final emails = await repository.email.findEmailsForUser(
      token.user,
      offset: page.offset,
      limit: limit,
      until: page.until,
      since: page.since,
    );
    return MailboxListGetResponse.response200(
      MailboxListGetResponseBody200(
        page: Page(
          nextPageToken:
              emails.length < limit ? null : page.nextPage(limit).encode(),
          sinceToken: page.until.toIso8601String(),
        ),
        data: emails.map((e) => e.toEmailMessage()).toList(),
      ),
    );
  }

  @override
  Future<MailboxMessageGetResponse> mailboxMessageGet(
      {required ApiUuid messageId}) async {
    final token = await _requireAuthToken();
    final body = await repository.email.findEmailMessageBody(token.user,
        messageId: messageId.encodeToString());
    if (body == null) {
      throw NotFoundException('Message not found.');
    }
    return MailboxMessageGetResponse.response200(body);
  }

  @override
  Future<MailboxGetResponse> mailboxGet() async {
    final token = await _requireAuthToken();
    final mailboxList = await repository.email.findMailboxAll(token.user);
    return MailboxGetResponse.response200(
        MailboxGetResponseBody200(data: mailboxList));
  }

  @override
  Future<MailboxMessageMarkReadResponse> mailboxMessageMarkRead(
      {required ApiUuid messageId}) async {
    final token = await _requireAuthToken();
    if (!await repository.email.markAsRead(token.user,
        messageId: messageId.encodeToString(), isRead: true)) {
      throw NotFoundException('Message not found.');
    }
    return MailboxMessageMarkReadResponse.response200();
  }

  @override
  Future<MailMassupdatePostResponse> mailMassupdatePost(
      MailMassupdatePostSchema body) async {
    final token = await _requireAuthToken();
    final updated = await repository.email.messageMassUpdate(
        token.user, body.filter,
        messageIds: body.messageIds, isRead: body.isRead);
    _logger.fine('Updated $updated messages for $body');
    return MailMassupdatePostResponse.response200();
  }

  @override
  Future<MailboxMessageMarkUnReadResponse> mailboxMessageMarkUnRead(
      {required ApiUuid messageId}) async {
    final token = await _requireAuthToken();
    if (!await repository.email.markAsRead(token.user,
        messageId: messageId.encodeToString(), isRead: false)) {
      throw NotFoundException('Message not found.');
    }
    return MailboxMessageMarkUnReadResponse.response200();
  }

  @override
  Future<MailboxMessageForwardResponse> mailboxMessageForward(
      MailboxMessageForwardSchema body,
      {required ApiUuid messageId}) async {
    final token = await _requireAuthToken();
    final body = await repository.email.findEmailMessageBody(token.user,
        messageId: messageId.encodeToString());
    final userInfo = await repository.user.findUserInfo(authToken: token);

    if (body == null) {
      throw NotFoundException('Message not found.');
    }

    await serviceProvider.emailService
        .forwardMimeMessage(body, userInfo.emails.first.address);
    return MailboxMessageForwardResponse.response200();
  }

  @override
  Future<MailboxMessageDeleteResponse> mailboxMessageDelete(
      {required ApiUuid messageId}) async {
    final token = await _requireAuthToken();
    if (!await repository.email
        .deleteMessage(token.user, messageId: messageId.encodeToString())) {
      throw NotFoundException('Message not found.');
    }
    return MailboxMessageDeleteResponse.response200();
  }

  @override
  Future<MailboxUpdateResponse> mailboxUpdate(MailboxUpdateSchema body,
      {required String mailboxAddress}) async {
    final token = await _requireAuthToken();
    if (await repository.email.updateMailbox(
      token.user,
      mailboxAddress: mailboxAddress,
      label: body.label,
      entryUuid: body.entryUuid,
      isDeleted: body.isDeleted,
      isDisabled: body.isDisabled,
    )) {
      return MailboxUpdateResponse.response200();
    }
    throw NotFoundException('Invalid mailboxAddress $mailboxAddress.');
  }

  @override
  Future<StatusGetResponse> statusGet() async {
    final token = await _requireAuthToken();
    final status = await repository.email.generateUserStatus(token.user);
    return StatusGetResponse.response200(StatusGetResponseBody200(
        mail: StatusGetResponseBody200Mail(
            messagesUnread: status.messagesUnread)));
  }

  @override
  Future<WebsiteImageGetResponse> websiteImageGet({required String url}) async {
    final uri = Uri.parse(url);
    final image = await repository.website.findBestImage(uri);
    const maxAge = Duration(days: 7);
    if (image == null) {
      return WebsiteImageGetResponse.response404()
        ..headers.addAll({
          'cache-control': ['public, max-age=${maxAge.inSeconds}']
        });
      // throw NotFoundException('Unable to find image for $uri ($url)');
    }
    return WebsiteImageGetResponse.response200(
        OpenApiContentType.parse(image.mimeType), image.bytes)
      ..headers.addAll({
        'x-brightness': [image.brightness.toString()],
        'x-size': ['${image.width}x${image.height}'],
        'x-original-url': [image.uri],
        'cache-control': ['public, max-age=${maxAge.inSeconds}']
      });
  }

  @override
  Future<CheckStatusPostResponse> checkStatusPost({String? xSecret}) async {
    if (xSecret != _env.config.secrets.systemStatusSecret) {
      _logger.severe('Invalid secret. $xSecret');
      throw NotFoundException('Invalid.');
    }
    return CheckStatusPostResponse.response200(await SystemDao(db).getStats());
  }

  @override
  Future<FilecloudFilePostResponse> filecloudFilePost(Uint8List body,
      {required String fileName}) async {
    final token = await _requireAuthToken();
    final response =
        await repository.fileCloud.createFile(token.user, fileName, body);
    return FilecloudFilePostResponse.response200(
        FilecloudFilePostResponseBody200(
      fileToken: response.fileToken,
      versionToken: response.versionToken,
    ));
  }

  @override
  Future<FilecloudFilePutResponse> filecloudFilePut(Uint8List body,
      {required String fileToken, required String versionToken}) async {
    final token = await _requireAuthToken();
    final version = await repository.fileCloud.updateFile(
      token.user,
      fileToken: fileToken,
      versionToken: versionToken,
      bytes: body,
    );
    return FilecloudFilePutResponse.response200(FilecloudFilePutResponseBody200(
      versionToken: version.versionToken,
    ));
  }

  @override
  Future<FilecloudFileRetrievePostResponse> filecloudFileRetrievePost(
      FileId body) async {
    final token = await _optionalAuthToken();
    final fc = await repository.fileCloud.retrieveFileContent(
      user: token?.user,
      fileToken: body.fileToken,
    );
    return FilecloudFileRetrievePostResponse.response200(fc.body)
      ..headers.addAll({
        'etag': [fc.versionToken],
      });
    // throw UnimplementedError();
  }

  @override
  Future<FilecloudFileGetResponse> filecloudFileGet() async {
    final token = await _requireAuthToken();
    final list = await repository.fileCloud.listAllFiles(token.user);
    return FilecloudFileGetResponse.response200(FileListResponse(files: list));
  }

  @override
  Future<FilecloudFileDeletePostResponse> filecloudFileDeletePost(
      FileId body) async {
    final token = await _requireAuthToken();
    if (await repository.fileCloud
        .deleteFile(token.user, fileToken: body.fileToken)) {
      return FilecloudFileDeletePostResponse.response204();
    } else {
      throw NotFoundException('File not found.');
    }
  }

  @override
  Future<FilecloudFileTokenCreatePostResponse> filecloudFileTokenCreatePost(
      FilecloudFileTokenCreatePostSchema body) async {
    final token = await _requireAuthToken();
    if (body.userEmail != null) {
      throw UnimplementedError();
    }
    final newFileToken = await repository.fileCloud.createToken(
      token.user,
      fileToken: body.fileToken,
      readOnly: body.readOnly,
      label: body.label,
    );
    return FilecloudFileTokenCreatePostResponse.response200(
        FileId(fileToken: newFileToken));
  }

  @override
  Future<FilecloudFileTokenListPostResponse> filecloudFileTokenListPost(
      FileId body) async {
    final token = await _requireAuthToken();
    final tokens = await repository.fileCloud
        .listFileTokens(token.user, fileToken: body.fileToken);
    return FilecloudFileTokenListPostResponse.response200(
        FilecloudFileTokenListPostResponseBody200(tokens: tokens));
  }

  @override
  Future<FilecloudFileMetadataPostResponse> filecloudFileMetadataPost(
      FileId body) async {
    final token = await _optionalAuthToken();
    final details = await repository.fileCloud
        .getFileDetails(token?.user, fileToken: body.fileToken);
    return FilecloudFileMetadataPostResponse.response200(details);
  }

  @override
  Future<FilecloudAttachmentPostResponse> filecloudAttachmentPost(
    Uint8List body, {
    required String fileName,
    required String fileToken,
  }) async {
    final token = await _requireAuthToken();
    final attachment = await repository.fileCloud.createAttachment(
      token.user,
      bytes: body,
      fileName: fileName,
      fileToken: fileToken,
    );
    return FilecloudAttachmentPostResponse.response200(
        FilecloudAttachmentPostResponseBody200(attachmentToken: attachment));
  }

  @override
  Future<FilecloudAttachmentRetrievePostResponse>
      filecloudAttachmentRetrievePost(AttachmentId body) async {
    // ignore: unused_local_variable
    final token = await _requireAuthToken();
    final bytes = await repository.fileCloud
        .retrieveAttachmentContent(body.attachmentToken);
    return FilecloudAttachmentRetrievePostResponse.response200(bytes);
  }

  @override
  Future<FilecloudAttachmentTouchPostResponse> filecloudAttachmentTouchPost(
      AttachmentTouch body) async {
    final token = await _requireAuthToken();
    await repository.fileCloud.touchAttachment(
      token.user,
      fileToken: body.file.fileToken,
      attachmentIds: body.attachmentTokens,
    );
    return FilecloudAttachmentTouchPostResponse.response200();
  }

  @override
  Future<FilecloudAttachmentUnlinkPostResponse> filecloudAttachmentUnlinkPost(
      AttachmentTouch body) async {
    final token = await _requireAuthToken();
    await repository.fileCloud.unlinkAttachment(
      token.user,
      fileToken: body.file.fileToken,
      attachmentIds: body.attachmentTokens,
    );
    return FilecloudAttachmentUnlinkPostResponse.response200();
  }

  @override
  Future<UserDeleteGetResponse> userDeleteGet() async {
    return UserDeleteGetResponse.response200(
        deleteUserByEmailFormInput(serviceProvider.env));
  }

  @override
  Future<UserDeleteConfirmGetResponse> userDeleteConfirmGet(
      {required String token}) async {
    if (!await repository.user.isValidEmailConfirmToken(token)) {
      return UserDeleteConfirmGetResponse.response400('');
    }
    return UserDeleteConfirmGetResponse.response200(
        deleteUserEmailConfirmationPage(serviceProvider.env, token));
  }

  @override
  Future<UserDeleteConfirmPostResponse> userDeleteConfirmPost(
      UserDeleteConfirmPostSchema body) async {
    final success =
        await serviceProvider.recaptchaService.verify(body.gRecaptchaResponse);
    if (!success) {
      return UserDeleteConfirmPostResponse.response400();
    }
    final token = await repository.user.deleteAccountForEmailToken(body.token);
    if (token == null) {
      return UserDeleteConfirmPostResponse.response400();
    }
    return UserDeleteConfirmPostResponse.response200(
        deleteUserSuccessPage(serviceProvider.env, token.email));
  }

  @override
  Future<UserDeletePostResponse> userDeletePost(
      UserDeletePostSchema body) async {
    final emailConfirm = await repository.user.createUserOrConfirmEmail(
      body.email,
      request.headerParameter(HttpHeaders.userAgentHeader).single,
      requireExistingUser: true,
    );
    final urlResolve = AuthPassCloudUrlResolve();
    final url = urlResolve
        .userDeleteConfirmGet(token: emailConfirm.token)
        .resolveUri(serviceProvider.env.baseUri);
    await serviceProvider.emailService.sendEmailConfirmationForUserDeleteToken(
        emailConfirm.email.emailAddress, url.toString());
    _logger.fine('Deleting user. ${body.email}');
    return UserDeletePostResponse.response200(
        deleteUserEmailVerificationSent(serviceProvider.env));
  }
}

class PageToken {
  PageToken(this.offset, this.until, this.since);
  factory PageToken.decode(String pageToken) {
    final split = utf8.decode(base64.decode(pageToken)).split(';');
    return PageToken(
      int.parse(split[0]),
      _dec(split[1]),
      _dec(split[2]),
    );
  }

  final int offset;
  final DateTime until;
  final DateTime since;

  static int _enc(DateTime dateTime) => dateTime.toUtc().millisecondsSinceEpoch;
  static DateTime _dec(String value) =>
      DateTime.fromMillisecondsSinceEpoch(int.parse(value), isUtc: true);

  String encode() =>
      base64.encode(utf8.encode('$offset;${_enc(until)};${_enc(since)}'));

  PageToken nextPage(int skip) => PageToken(offset + skip, until, since);
}
