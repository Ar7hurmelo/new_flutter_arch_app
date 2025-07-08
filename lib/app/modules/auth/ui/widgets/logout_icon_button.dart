import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../stores/auth_store.dart';

class LogoutIconButton extends StatefulWidget {
  const LogoutIconButton({super.key});

  @override
  State<LogoutIconButton> createState() => _LogoutIconButtonState();
}

class _LogoutIconButtonState extends State<LogoutIconButton> {
  final AuthStore authStore = Modular.get<AuthStore>();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.exit_to_app),
      onPressed: () {
        authStore.logout();
      },
    );
  }
}
