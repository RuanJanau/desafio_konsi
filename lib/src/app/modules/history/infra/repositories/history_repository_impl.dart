import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:desafio_konsi/src/app/modules/cep/domain/erros/error.dart';
import 'package:desafio_konsi/src/app/modules/history/infra/datasource/history_datasource.dart';
import 'package:desafio_konsi/src/app/modules/history/infra/models/hisotry_model.dart';

import '../../domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryDatasource _datasource;

  HistoryRepositoryImpl(this._datasource);
  @override
  Future<Either<Failure, List<HistoryModel>>> history() async {
    try {
      var result = await _datasource.getHistory();

      return Right(result);
    } catch (e) {
      log(e.toString());

      return left(Failure());
    }
  }
}
