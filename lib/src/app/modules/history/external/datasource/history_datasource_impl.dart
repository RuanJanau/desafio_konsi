import 'package:cloud_firestore/cloud_firestore.dart';

import '../../infra/datasource/history_datasource.dart';
import '../../infra/models/hisotry_model.dart';

class HistoryDatasourceImpl implements HistoryDatasource {
  final FirebaseFirestore _firestore;

  HistoryDatasourceImpl(this._firestore);
  @override
  Future<List<HistoryModel>> getHistory() async {
    try {
      List<HistoryModel> listHistory = <HistoryModel>[];
      await _firestore
          .collection('cep')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          listHistory.add(
            HistoryModel.fromDocumentsSnapshot(doc),
          );
        }
      });
      return listHistory;
    } catch (e) {
      rethrow;
    }
  }
}

//implementacao do CEP usando o "DIO"