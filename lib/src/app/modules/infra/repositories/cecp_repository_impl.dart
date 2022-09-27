import 'dart:developer';

import 'package:dartz/dartz.dart';
import '../datasource/cep_datasource.dart';


import '../../domain/entities/cep_entity.dart';
import '../../domain/erros/error.dart';
import '../../domain/repositories/cep_repository.dart';

class CepRepositoryImpl implements CepRepository {
  final CepDatasource _datasource;

  CepRepositoryImpl(this._datasource);
  @override
  Future<Either<Failure, CepEntity>> search(String cep) async {
    try {
      var result = await _datasource.getCep(cep);

      return Right(result);
    } catch (e) {
      log(e.toString());

      return left(Failure());
    }
  }
}
