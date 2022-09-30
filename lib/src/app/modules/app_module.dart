import 'package:desafio_konsi/src/app/modules/presentation/pages/history_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../cep_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Modular.initialRoute, module: CepModule()),
        ChildRoute(
          '/history',
          child: ((context, args) => const HistoryPage()),
        )
      ];
}
