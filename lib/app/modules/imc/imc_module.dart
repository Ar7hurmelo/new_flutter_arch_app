import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/app_module.dart';
import 'repositories/imc_repository.dart';
import 'repositories/impl/local_imc_repository_impl.dart';
import 'ui/pages/imc_home_page.dart';
import 'ui/viewmodels/imc_viewmodel.dart';

class ImcModule extends Module {
  @override
  List<Module> get imports => [
    AppModule(sharedPreferences: Modular.get<SharedPreferences>()),
  ];

  @override
  void binds(Injector i) {
    super.binds(i);

    i.addLazySingleton<ImcRepository>(() => LocalImcRepositoryImpl());
    i.addLazySingleton<ImcViewmodel>(
      () => ImcViewmodel(imcRepository: i.get<ImcRepository>()),
    );
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);

    r.child("/", child: (_) => ImcHomePage());
  }
}
