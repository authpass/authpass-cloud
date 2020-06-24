import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_backend/src/dao/user_repository.dart';
import 'package:authpass_cloud_backend/src/service/service_provider.dart';
import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:logging/logging.dart';

final _logger = Logger('authpass_service');

class AuthPassCloudImpl extends AuthPassCloud {
  AuthPassCloudImpl(
    this.serviceProvider,
    this.db,
    this.userRepository,
  )   : assert(serviceProvider != null),
        assert(db != null),
        assert(userRepository != null);

  final ServiceProvider serviceProvider;
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
    // TODO we should probably let the user confirm using a button
    return EmailConfirmGetResponse.response200('lorem ipsum');
//    throw UnimplementedError();
  }

  @override
  Future<EmailConfirmPostResponse> emailConfirmPost() {
    throw UnimplementedError();
  }
}
