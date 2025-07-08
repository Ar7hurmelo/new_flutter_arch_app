import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';

import '../stores/auth_store.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    final authStore = Modular.get<AuthStore>();

    return await authStore.checkUserLogged();
  }
}
