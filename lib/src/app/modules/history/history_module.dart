import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_konsi/src/app/modules/history/presentation/controller/history_controller.dart';
import 'package:desafio_konsi/src/app/modules/history/presentation/page/history_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecases/get_history_usecase.dart';
import 'external/datasource/history_datasource_impl.dart';
import 'infra/repositories/history_repository_impl.dart';

class HistoryModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => HistoryDatasourceImpl(FirebaseFirestore.instance)),
        Bind((i) => HistoryRepositoryImpl(i())),
        Bind((i) => GetHistoryUsecaseImpl(i())),
        Bind((i) => HistoryController(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: ((context, args) => const HistoryPage()),
        )
      ];
}
