import 'package:dartz/dartz.dart';

import '../../../../core/errors/error.dart';
import '../entities/cep_entity.dart';

abstract class CepRepository {
  Future<Either<Failure, CepEntity>> search(String cep);
  Future<Either<Failure, void>> addHistory(String cep, String endereco);
}
