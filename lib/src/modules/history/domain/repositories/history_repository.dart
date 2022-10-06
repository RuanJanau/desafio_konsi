import 'package:dartz/dartz.dart';

import '../../../../core/errors/error.dart';
import '../../infra/models/hisotry_model.dart';

abstract class HistoryRepository  {
  Future<Either<Failure, List<HistoryModel>>> history();
} 