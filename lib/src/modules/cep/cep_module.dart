import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../history/domain/usecases/get_history_usecase.dart';
import '../history/external/datasource/history_datasource_impl.dart';
import '../history/infra/repositories/history_repository_impl.dart';
import 'domain/usecases/get_cep_usecase.dart';
import 'external/datasource/cep_datasource_impl.dart';
import 'infra/repositories/cep_repository_impl.dart';
import 'presentation/controller/cep_controller.dart';
import 'presentation/pages/cep_page.dart';

class CepModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => CepDatasourceImpl(i(), FirebaseFirestore.instance)),
        Bind((i) => CepRepositoryImpl(i())),
        Bind((i) => GetCepUsecaseImpl(i())),
        Bind((i) => HistoryDatasourceImpl(FirebaseFirestore.instance)),
        Bind((i) => HistoryRepositoryImpl(i())),
        Bind((i) => GetHistoryUsecaseImpl(i())),
        Bind((i) => CepController(i(), i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: ((context, args) => const CepPage()))
      ];
}
