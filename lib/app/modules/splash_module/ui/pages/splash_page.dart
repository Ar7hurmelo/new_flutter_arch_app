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

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Fluo.init('QCj_u0p0ah0kvzXyR2DkyEmiQr_mvUcZyPEIqBPWRg4='),
        builder: (context, snapshot) {
          if (!Fluo.isInitialized) {
            return const Scaffold();
          }

          if (!Fluo.instance.isUserReady()) {
            return FluoOnboarding(
              fluoTheme: FluoTheme.native(),
              onUserReady: () async {
                // 1. Initialize the Supabase client somewhere in your code
                // 2. Use 'recoverSession' as below:
                final session = Fluo.instance.session!;
                await Supabase.instance.client.auth.recoverSession(
                  session.supabaseSession!,
                );
                if (mounted) {
                  Modular.to.pushNamed('/connected');
                }
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
