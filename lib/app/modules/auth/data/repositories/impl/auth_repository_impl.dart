import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/logged_user_model.dart';
import '../../services/i_auth_service.dart';
import '../i_auth_repository.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final IAuthService iAuthService;
  final SharedPreferences sharedPreferences;

  AuthRepositoryImpl({
    required this.iAuthService,
    required this.sharedPreferences,
  });

  @override
  AsyncResult<String> getUserToken({
    required String username,
    required String password,
  }) async {
    try {
      var result = await iAuthService.getUserToken(
        username: username,
        password: password,
      );

      return Success(result);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<LoggedUserModel> getUserDataByToken(String userToken) async {
    try {
      var loggedUser = await iAuthService.getUserData(userToken);
      await saveUserData(loggedUser);
      return Success(loggedUser);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<void> saveUserData(LoggedUserModel loggedUser) async {
    try {
      await sharedPreferences.setString('logged_user', loggedUser.toJson());
    } on Exception catch (e) {
      throw Exception('Erro ao salvar dados do usuário: ${e.toString()}');
    }
  }

  @override
  AsyncResult<LoggedUserModel> getLoggedUser() async {
    LoggedUserModel loggedUser;

    try {
      String? userDataJson = sharedPreferences.getString('logged_user');
      if (userDataJson != null) {
        loggedUser = LoggedUserModel.fromJson(userDataJson);
        return Success(loggedUser);
      } else {
        return Failure(Exception('Usuário não encontrado'));
      }
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<bool> logout() async {
    try {
      await sharedPreferences.remove('logged_user');
      return Success(true);
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
