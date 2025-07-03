import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/app_module.dart';
import 'ui/pages/news_home_page.dart';
import 'ui/viewmodels/news_viewmodel.dart';

class NewsModule extends Module {
  @override
  List<Module> get imports => [
    AppModule(sharedPreferences: Modular.get<SharedPreferences>()),
  ];

  @override
  void binds(Injector i) {
    super.binds(i);

    i.addLazySingleton<NewsViewmodel>(() => NewsViewmodel());
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);

    r.child("/", child: (_) => NewsHomePage());
  }
}
