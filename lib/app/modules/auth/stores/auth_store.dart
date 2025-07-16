import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

import '../data/repositories/i_auth_repository.dart';
import '../models/logged_user_model.dart';

class AuthStore extends ChangeNotifier {
  final IAuthRepository iAuthRepository;
  late final loginCommand = Command2(_login);

  AuthStore({required this.iAuthRepository}) {
    _redirectLoggedUser();
  }

  LoggedUserModel? loggedUser;
  bool get _isUserLogged => loggedUser != null && loggedUser!.token.isNotEmpty;
  var error = '';

  AsyncResult<LoggedUserModel> _login(String username, String password) async {
    // Get user token
    final getUserTokenResult = await iAuthRepository.getUserToken(
      username: username,
      password: password,
    );

    var userToken = getUserTokenResult.getOrNull();
    if (userToken == null || userToken.isEmpty) {
      error =
          getUserTokenResult.exceptionOrNull()?.toString() ??
          'Erro desconhecido';
    } else {
      // Get user data
      var getUserDataResult = await iAuthRepository.getUserDataByToken(
        userToken,
      );

      var userData = getUserDataResult.getOrNull();
      if (userData == null) {
        error =
            getUserDataResult.exceptionOrNull()?.toString() ??
            'Erro desconhecido';
      } else {
        loggedUser = userData;
        notifyListeners();
        return Success(loggedUser!);
      }
    }

    notifyListeners();
    return Failure(Exception('Erro ao fazer login: $error'));
  }

  Future<bool> checkUserLogged() async {
    return _isUserLogged;
  }

  Future<void> _getLoggedUserFromRepository() async {
    var result = await iAuthRepository.getLoggedUser();
    loggedUser = result.getOrNull();
  }

  Future<void> _redirectLoggedUser() async {
    await _getLoggedUserFromRepository();

    if (_isUserLogged) {
      Modular.to.pushNamedAndRemoveUntil('/news/', (_) => false);
    }
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
        error = 'Erro ao fazer logout: ${failure.toString()}';
        notifyListeners();
      },
    );
  }
}
