import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/history_entity.dart';

class HistoryModel extends HistoryEntity {
  const HistoryModel({
    required String cep,
    required String endereco,
    required String timestamp,
  }) : super(
          cep: cep,
          
          endereco: endereco,
          timestamp: timestamp,
        );

  Map<String, dynamic> toMap() {
    return {
      'cep': cep,
      'endereco': endereco,
      'timestamp': timestamp,
    };
  }

  factory HistoryModel.fromDocumentsSnapshot(QueryDocumentSnapshot doc) {
    return HistoryModel(
      cep: doc['cep'],
      endereco: doc['endereco'],
      timestamp: doc['timestamp'],
    );
  }
  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      cep: map['cep'] as String,
      endereco: map['endereco'] as String,
      timestamp: map['bairro'] as String,
    );
  }
}
