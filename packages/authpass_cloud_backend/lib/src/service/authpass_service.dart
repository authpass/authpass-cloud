import 'package:authpass_cloud_backend/src/dao/database_access.dart';
import 'package:authpass_cloud_shared/authpass_cloud_shared.dart';
import 'package:logging/logging.dart';
import 'package:openapi_base/openapi_base.dart';

final _logger = Logger('authpass_service');

class AuthPassCloudImpl extends AuthPassCloud {
  AuthPassCloudImpl(this.db);

  final DatabaseTransaction db;

  @override
  Future<UserRegisterPostResponse> userRegisterPost(
      OpenApiRequest request, RegisterRequest body) async {
    _logger.fine('Creating new user. ${body.email}');
    return UserRegisterPostResponse.response200(
        RegisterResponse(userUuid: '123'));
  }

  @override
  Future<EmailConfirmPutResponse> emailConfirmPut(
      OpenApiRequest request, String token) async {
    return EmailConfirmPutResponse.response200();
  }
}
