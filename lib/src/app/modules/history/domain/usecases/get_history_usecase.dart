import 'package:dartz/dartz.dart';

import '../../../cep/domain/erros/error.dart';
import '../../infra/models/hisotry_model.dart';
import '../repositories/history_repository.dart';

abstract class GetHistoryUsecase {
  Future<Either<Failure, List<HistoryModel>>> call();
}

class GetHistoryUsecaseImpl implements GetHistoryUsecase {
  final HistoryRepository _repository;

  GetHistoryUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, List<HistoryModel>>> call() {
    return _repository.history();
  }
}
