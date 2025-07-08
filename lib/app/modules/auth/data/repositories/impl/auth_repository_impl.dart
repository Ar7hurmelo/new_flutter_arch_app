import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../shared/result.dart';
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
  Future<Result<String, String>> getUserToken({
    required String username,
    required String password,
  }) async {
    try {
      var result = await iAuthService.getUserToken(
        username: username,
        password: password,
      );

      return result;
    } catch (e) {
      return Failure<String, String>(
        'Erro ao obter token do usuário: ${e.toString()}',
      );
    }
  }

  @override
  Future<Result<LoggedUserModel, String>> getUserDataByToken(
    String userToken,
  ) async {
    try {
      var result = await iAuthService.getUserData(userToken);
      var loggedUser = result.getOrNull();

      if (loggedUser == null) {
        return Failure<LoggedUserModel, String>(
          result.getErrorOrNull() ?? 'Erro ao obter Token',
        );
      } else {
        await saveUserData(loggedUser);
        return Success(loggedUser);
      }
    } catch (e) {
      return Failure<LoggedUserModel, String>(
        'Erro ao obter dados do usuário: ${e.toString()}',
      );
    }
  }

  Future<void> saveUserData(LoggedUserModel loggedUser) async {
    try {
      await sharedPreferences.setString('logged_user', loggedUser.toJson());
    } catch (e) {
      throw Exception('Erro ao salvar dados do usuário: ${e.toString()}');
    }
  }

  @override
  Future<LoggedUserModel?> getLoggedUser() async {
    LoggedUserModel? loggedUser;

    try {
      String? userDataJson = sharedPreferences.getString('logged_user');
      if (userDataJson != null) {
        loggedUser = LoggedUserModel.fromJson(userDataJson);
      }
    } catch (e) {
      print(e.toString());
    }

    return loggedUser;
  }

  @override
  Future<Result<bool, String>> logout() async {
    try {
      await sharedPreferences.remove('logged_user');
      return Success(true);
    } catch (e) {
      return Failure('Erro ao fazer logout: ${e.toString()}');
    }
  }
}
