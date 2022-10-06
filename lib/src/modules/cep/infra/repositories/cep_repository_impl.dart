import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/error.dart';
import '../../domain/entities/cep_entity.dart';
import '../../domain/repositories/cep_repository.dart';
import '../datasource/cep_datasource.dart';

class CepRepositoryImpl implements CepRepository {
  final CepDatasource _datasource;

  CepRepositoryImpl(this._datasource);
  @override
  Future<Either<Failure, CepEntity>> search(String cep) async {
    try {
      final result = await _datasource.getCep(cep);
      return Right(result);
    } catch (e) {
      log(e.toString());
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, void>> addHistory(String cep, String endereco) async {
    try {
      final result = await _datasource.saveAddress(cep, endereco);
      return Right(result);
    } catch (e) {
      log(e.toString());
      return Left(Failure());
    }
  }
}
