import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecases/get_cep_usecase.dart';
import 'external/datasource/cep_datasource_impl.dart';
import 'infra/repositories/cep_repository_impl.dart';
import 'presentation/controller/cep_controller.dart';
import 'presentation/pages/cep_page.dart';

class CepModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => CepDatasourceImpl(i())),
        Bind((i) => CepRepositoryImpl(i())),
        Bind((i) => GetCepUsecaseImpl(i())),
        Bind((i) => CepController(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: ((context, args) => const CepPage()))
      ];
}
