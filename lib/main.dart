import 'package:fluo/fluo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/modules/app/app_module.dart';
import 'app/modules/app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Initialize the FLUO SDK
  // await Fluo.init('QCj_u0p0ah0kvzXyR2DkyEmiQr_mvUcZyPEIqBPWRg4=');

  runApp(
    ModularApp(
      module: AppModule(sharedPreferences: prefs),
      child: AppWidget(),
    ),
  );
}
