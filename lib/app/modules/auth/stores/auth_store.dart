import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_flutter_arch_app/app/shared/command.dart';

import '../../../shared/result.dart';
import '../data/repositories/i_auth_repository.dart';
import '../models/logged_user_model.dart';

class AuthStore extends ChangeNotifier {
  final IAuthRepository iAuthRepository;
  late final Command1<LoggedUserModel, String, Map<String, String>>
  loginCommand;

  AuthStore({required this.iAuthRepository}) {
    loginCommand = Command1<LoggedUserModel, String, Map<String, String>>((
      params,
    ) async {
      final username = params['usuario'] ?? '';
      final password = params['senha'] ?? '';
      return _login(username, password);
    });

    _redirectLoggedUser();
  }

  LoggedUserModel? loggedUser;
  bool get _isUserLogged => loggedUser != null && loggedUser!.token.isNotEmpty;
  var error = '';

  Future<Result<LoggedUserModel, String>> _login(
    String username,
    String password,
  ) async {
    // Get user token
    final getUserTokenResult = await iAuthRepository.getUserToken(
      username: username,
      password: password,
    );

    var userToken = getUserTokenResult.getOrNull();
    if (userToken == null || userToken.isEmpty) {
      error = getUserTokenResult.getErrorOrNull() ?? 'Erro desconhecido';
    } else {
      // Get user data
      var getUserDataResult = await iAuthRepository.getUserDataByToken(
        userToken,
      );

      var userData = getUserDataResult.getOrNull();
      if (userData == null) {
        error = getUserDataResult.getErrorOrNull() ?? 'Erro desconhecido';
      } else {
        loggedUser = userData;
        notifyListeners();
        return Success(loggedUser!);
      }
    }

    notifyListeners();
    return Failure('Erro ao fazer login: $error');
  }

  Future<void> _getLoggedUser() async {
    loggedUser = await iAuthRepository.getLoggedUser();
  }

  Future<void> _redirectLoggedUser() async {
    // Verify if user is already logged
    await _getLoggedUser();

    if (_isUserLogged) {
      Modular.to.pushNamedAndRemoveUntil('/news/', (_) => false);
    }
  }

  Future<bool> checkUserLogged() async {
    return _isUserLogged;
  }

  Future<void> logout() async {
    var result = await iAuthRepository.logout();

    result.fold(
      (success) {
        loggedUser = null;
        error = '';
        Modular.to.pushNamedAndRemoveUntil('/', (_) => false);
      },
      (failure) {
        error = failure;
        notifyListeners();
      },
    );
  }
}
