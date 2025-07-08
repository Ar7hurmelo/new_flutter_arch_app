import '../../../../shared/result.dart';
import '../../models/logged_user_model.dart';

abstract class IAuthRepository {
  Future<Result<String, String>> getUserToken({
    required String username,
    required String password,
  });

  Future<Result<LoggedUserModel, String>> getUserDataByToken(String userToken);

  Future<LoggedUserModel?> getLoggedUser();

  Future<Result<bool, String>> logout();
}
