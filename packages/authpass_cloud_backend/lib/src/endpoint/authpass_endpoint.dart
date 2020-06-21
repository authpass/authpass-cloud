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
    final user = await userRepository.createUserOrConfirmEmail(body.email);
    _logger.fine('Creating new user. ${body.email}');
    return UserRegisterPostResponse.response200(
        RegisterResponse(userUuid: '123'));
  }

  @override
  Future<EmailConfirmPutResponse> emailConfirmPut(String token) async {
    return EmailConfirmPutResponse.response200();
  }
}
