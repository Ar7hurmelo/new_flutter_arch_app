import 'package:fluo/fluo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConnectedPage extends StatelessWidget {
  const ConnectedPage({super.key});

  void onSignOut() async {
    // Clear the session and navigate back to the splash page
    await Fluo.instance.clearSession();
    Modular.to.pushNamedAndRemoveUntil('/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You are connected, ${Fluo.instance.session?.user.firstName ?? 'User'}!',
            ),

            Text(' ${Fluo.instance.session?.user.email ?? 'user@email.com'}!'),
            const SizedBox(height: 20),
            FilledButton(onPressed: onSignOut, child: const Text('Sign out')),
          ],
        ),
      ),
    );
  }
}
