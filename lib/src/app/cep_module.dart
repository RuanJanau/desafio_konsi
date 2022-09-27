import 'package:desafio_konsi/src/app/modules/presentation/pages/cep_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/domain/usecases/get_cep_usecase.dart';
import 'modules/external/datasource/cep_datasource_impl.dart';
import 'modules/infra/repositories/cecp_repository_impl.dart';
import 'modules/presentation/controller/cep_controller.dart';

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
