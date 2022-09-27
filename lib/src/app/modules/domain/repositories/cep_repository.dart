import 'package:dartz/dartz.dart';
import '../entities/cep_entity.dart';

import '../erros/error.dart';

abstract class CepRepository {
  Future<Either<Failure, CepEntity>> search(String cep);
}
