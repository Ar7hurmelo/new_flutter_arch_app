import 'package:fluo/fluo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/modules/app/app_module.dart';
import 'app/modules/app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Initialize SUPABASE
  await Supabase.initialize(
    url: 'https://lkwyslfahfmgkrhiqmtl.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imxrd3lzbGZhaGZtZ2tyaGlxbXRsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTI3ODY4NzMsImV4cCI6MjA2ODM2Mjg3M30.aoezom9DCplJybQ1Z4e4HWhr2ZqINPdTBChWHfaEvPw',
  );

  // Initialize the FLUO SDK
  await Fluo.init('QCj_u0p0ah0kvzXyR2DkyEmiQr_mvUcZyPEIqBPWRg4=');

  runApp(
    ModularApp(
      module: AppModule(sharedPreferences: prefs),
      child: AppWidget(),
    ),
  );
}
