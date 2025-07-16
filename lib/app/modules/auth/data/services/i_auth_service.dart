import '../../models/logged_user_model.dart';

abstract class IAuthService {
  Future<String> getUserToken({
    required String username,
    required String password,
  });

  Future<LoggedUserModel> getUserData(String userToken);
}
