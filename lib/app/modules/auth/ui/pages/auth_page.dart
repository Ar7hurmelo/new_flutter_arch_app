import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_flutter_arch_app/app/modules/auth/stores/auth_store.dart';
import 'package:result_command/result_command.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthStore authStore = Modular.get<AuthStore>();

  @override
  void initState() {
    super.initState();
  }

  void _buildError(BuildContext context) {
    SnackBar snackBar = SnackBar(
      content: Text(authStore.error, style: TextStyle(fontSize: 18.0)),
      backgroundColor: Colors.red,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListenableBuilder(
          listenable: authStore.loginCommand,
          builder: (context, child) {
            final status = authStore.loginCommand.value;

            if (status is FailureCommand && authStore.loggedUser == null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _buildError(context);
              });
            } else if (status is SuccessCommand &&
                authStore.loggedUser != null) {
              Modular.to.navigate('/news/');
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 32),
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  AuthTextField(
                    label: 'Usuário',
                    controller: _userController,
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 16),
                  AuthTextField(
                    label: 'Senha',
                    controller: _passwordController,
                    obscureText: true,
                    icon: Icons.lock_outline,
                  ),
                  const SizedBox(height: 32),
                  AuthButton(
                    text: status is RunningCommand ? 'Carregando...' : 'Entrar',
                    backgroundColor: status is RunningCommand
                        ? Colors.grey
                        : null,
                    onPressed: () {
                      if (status is! RunningCommand) {
                        authStore.loginCommand.execute(
                          _userController.text,
                          _passwordController.text,
                        );
                      } else {
                        null;
                      }
                    },
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
