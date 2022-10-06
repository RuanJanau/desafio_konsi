import 'package:dartz/dartz.dart';

import '../../../../core/errors/error.dart';
import '../repositories/cep_repository.dart';

abstract class GetHistoryUsecase {
  Future<Either<Failure, void>> call(String cep, String endereco);
}

class GetHistoryUsecaseImpl implements GetHistoryUsecase {
  final CepRepository _repository;

  GetHistoryUsecaseImpl(this._repository);

  @override
  Future<Either<Failure, void>> call(String cep, String endereco) async {
    if (cep.length < 6 || endereco.isEmpty) {
      return Left(Failure());
    }
    return _repository.addHistory(cep, endereco);
  }
}
