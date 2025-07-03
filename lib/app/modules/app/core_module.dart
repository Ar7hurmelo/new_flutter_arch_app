import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/api_service.dart';

class CoreModule extends Module {
  final SharedPreferences sharedPreferences;

  CoreModule({required this.sharedPreferences});

  @override
  void exportedBinds(i) {
    i.addLazySingleton<ApiService>(() => ApiService());
    i.addLazySingleton<SharedPreferences>(() => sharedPreferences);
  }
}
