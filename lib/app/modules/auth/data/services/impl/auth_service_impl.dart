import '../../../../../shared/result.dart';
import '../../../models/logged_user_model.dart';
import '../i_auth_service.dart';

class AuthServiceImpl extends IAuthService {
  @override
  Future<Result<String, String>> getUserToken({
    required String username,
    required String password,
  }) async {
    // Simulação de autenticação.
    await Future.delayed(const Duration(seconds: 1));
    if (username == 'admin' && password == 'admin') {
      return Success<String, String>('123.123.123');
    } else {
      return Failure<String, String>('Usuário ou senha inválidos');
    }
  }

  @override
  Future<Result<LoggedUserModel, String>> getUserData(String userToken) async {
    // Simulação de obtenção de dados do usuário.
    if (userToken == '123.123.123') {
      return Success<LoggedUserModel, String>(
        LoggedUserModel(
          id: '1',
          name: 'Admin',
          email: 'admin@email.com',
          token: userToken,
        ),
      );
    } else {
      return Failure<LoggedUserModel, String>('Token inválido');
    }
  }
}
