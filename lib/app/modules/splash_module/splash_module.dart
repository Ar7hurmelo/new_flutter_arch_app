import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_flutter_arch_app/app/modules/app/app_module.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/pages/connected_page.dart';
import 'ui/pages/splash_page.dart';

class SplashModule extends Module {
  @override
  List<Module> get imports => [
    AppModule(sharedPreferences: Modular.get<SharedPreferences>()),
  ];

  @override
  void binds(Injector i) {
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);

    r.child("/", child: (_) => SplashPage());
    r.child("/connected", child: (_) => ConnectedPage());
  }
}
