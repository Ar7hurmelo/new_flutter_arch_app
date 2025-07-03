import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../init/init_module.dart';
import 'core_module.dart';

class AppModule extends Module {
  final SharedPreferences sharedPreferences;

  AppModule({required this.sharedPreferences});

  @override
  List<Module> get imports => [
    CoreModule(sharedPreferences: sharedPreferences),
  ];

  @override
  void routes(RouteManager r) {
    super.routes(r);

    r.module("/", module: InitModule());
  }

  @override
  void exportedBinds(i) {}
}
