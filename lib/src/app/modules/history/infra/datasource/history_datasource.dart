import '../models/hisotry_model.dart';

abstract class HistoryDatasource {
  Future<List<HistoryModel>> getHistory();
}
//.
