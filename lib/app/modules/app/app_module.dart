import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_flutter_arch_app/app/modules/auth/guard/auth_guard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/auth_module.dart';
import '../auth/data/repositories/i_auth_repository.dart';
import '../auth/data/repositories/impl/auth_repository_impl.dart';
import '../auth/data/services/i_auth_service.dart';
import '../auth/data/services/impl/auth_service_impl.dart';
import '../auth/stores/auth_store.dart';
import '../news/news_module.dart';
import '../splash_module/splash_module.dart';
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

    r.module("/", module: SplashModule());
    r.module("/auth", module: AuthModule());
    r.module("/news", module: NewsModule(), guards: [AuthGuard()]);
  }

  @override
  void exportedBinds(i) {
    i.addSingleton<IAuthService>(() => AuthServiceImpl(authApiService: i()));
    i.addSingleton<IAuthRepository>(
      () => AuthRepositoryImpl(iAuthService: i(), sharedPreferences: i()),
    );
    i.addSingleton(() => AuthStore(iAuthRepository: i()));
  }
}
