import 'package:fluo/fluo.dart';
import 'package:fluo/fluo_onboarding.dart';
import 'package:fluo/fluo_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

void redirectToConnectedPage() {
  Modular.to.pushReplacementNamed('/connected');
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          // Check if Fluo is initialized
          if (!Fluo.isInitialized) {
            return Center(child: CircularProgressIndicator());
          }

          if (!Fluo.instance.isUserReady()) {
            return FluoOnboarding(
              fluoTheme: FluoTheme.native(),
              onUserReady: () async {
                // 1. Initialize the Supabase client somewhere in your code
                // 2. Use 'recoverSession' as below:
                final session = Fluo.instance.session!;
                var authResponse = await Supabase.instance.client.auth
                    .recoverSession(session.supabaseSession!);
                if (mounted && authResponse.user?.id != null) {
                  redirectToConnectedPage();
                }
              },
            );
          } else {
            redirectToConnectedPage();
          }

          return Center(child: Text('Splash Page'));
        },
      ),
    );
  }
}
