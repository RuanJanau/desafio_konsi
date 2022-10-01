import 'package:dartz/dartz.dart';
import 'package:desafio_konsi/src/app/modules/cep/domain/erros/error.dart';

import '../../infra/models/hisotry_model.dart';

abstract class HistoryRepository  {
  Future<Either<Failure, List<HistoryModel>>> history();
} 