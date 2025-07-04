import 'package:flutter_modular/flutter_modular.dart';

import '../imc/imc_module.dart';
import '../news/news_module.dart';
import 'ui/pages/init_home_page.dart';

class InitModule extends Module {
  @override
  List<Module> get imports => [];

  @override
  void binds(Injector i) {
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);

    r.child("/", child: (_) => InitHomePage());

    r.module("/imc", module: ImcModule());
    r.module("/news", module: NewsModule());
  }
}
