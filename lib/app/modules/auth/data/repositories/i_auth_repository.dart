import 'package:result_dart/result_dart.dart';

import '../../models/logged_user_model.dart';

abstract class IAuthRepository {
  AsyncResult<String> getUserToken({
    required String username,
    required String password,
  });

  AsyncResult<LoggedUserModel> getUserDataByToken(String userToken);

  AsyncResult<LoggedUserModel> getLoggedUser();

  AsyncResult<bool> logout();
}
