import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/dao/tables/user_tables.dart';
import 'package:authpass_cloud_backend/src/dao/user_repository.dart';
import 'package:authpass_cloud_backend/src/endpoint/email_confirmation.dart';
import 'package:authpass_cloud_backend/src/service/service_provider.dart';
import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:logging/logging.dart';
import 'package:openapi_base/openapi_base.dart';

final _logger = Logger('authpass_service');

class AuthPassCloudImpl extends AuthPassCloud {
  AuthPassCloudImpl(
    this.serviceProvider,
    this.request,
    this.db,
    this.userRepository,
  )   : assert(serviceProvider != null),
        assert(db != null),
        assert(userRepository != null);

  final ServiceProvider serviceProvider;
  final OpenApiRequest request;
  final DatabaseTransaction db;
  final UserRepository userRepository;

  @override
  Future<UserRegisterPostResponse> userRegisterPost(
      RegisterRequest body) async {
    final emailConfirm =
        await userRepository.createUserOrConfirmEmail(body.email);
    final urlResolve = AuthPassCloudUrlResolve();
    final url = urlResolve
        .emailConfirmGet(token: emailConfirm.token)
        .resolveUri(serviceProvider.env.baseUri);
    await serviceProvider.emailService.sendEmailConfirmationToken(
        emailConfirm.email.emailAddress, url.toString());
    _logger.fine('Creating new user. ${body.email}');
    return UserRegisterPostResponse.response200(RegisterResponse(
      userUuid: emailConfirm.email.user.id,
      authToken: emailConfirm.authToken.token,
      status: RegisterResponseStatus.created,
    ));
  }

  @override
  Future<EmailConfirmGetResponse> emailConfirmGet({String token}) async {
    if (!await userRepository.isValidEmailConfirmToken(token)) {
      return EmailConfirmGetResponse.response400();
    }
    return EmailConfirmGetResponse.response200(
        emailConfirmationPage(serviceProvider.env, token));
//    throw UnimplementedError();
  }

  @override
  Future<EmailConfirmPostResponse> emailConfirmPost(
      EmailConfirmSchema body) async {
    final success =
        await serviceProvider.recaptchaService.verify(body.gRecaptchaResponse);
    if (success) {
      await userRepository.confirmEmailAddress(body.token);
      return EmailConfirmPostResponse.response200('Success.');
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

  Future<AuthTokenEntity> _requireAuthToken(
      {bool acceptUnconfirmed = false}) async {
    final data = SecuritySchemes.authToken.fromRequest(request);
    if (data == null || data.bearerToken == null || data.bearerToken.isEmpty) {
      throw UnauthorizedException('Missing auth token.');
    }
    final validToken = await userRepository.findValidAuthToken(
      data.bearerToken,
      acceptUnconfirmed: acceptUnconfirmed,
    );

    if (validToken == null) {
      throw UnauthorizedException('No valid auth token.');
    }

    return validToken;
  }
}
