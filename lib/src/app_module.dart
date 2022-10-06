import 'package:flutter_modular/flutter_modular.dart';

import 'modules/cep/cep_module.dart';
import 'modules/history/history_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Modular.initialRoute, module: CepModule()),
        ModuleRoute('/history', module: HistoryModule())
      ];
}
