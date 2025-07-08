import '../../../../shared/result.dart';
import '../../models/logged_user_model.dart';

abstract class IAuthService {
  Future<Result<String, String>> getUserToken({
    required String username,
    required String password,
  });

  Future<Result<LoggedUserModel, String>> getUserData(String userToken);
}
