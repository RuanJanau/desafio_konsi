import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/error.dart';
import '../../domain/repositories/history_repository.dart';
import '../datasource/history_datasource.dart';
import '../models/hisotry_model.dart';

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
