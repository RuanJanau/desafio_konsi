import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/error.dart';
import '../../infra/datasource/cep_datasource.dart';
import '../../infra/models/cep_model.dart';

class CepDatasourceImpl implements CepDatasource {
  final Dio _dio;
  final FirebaseFirestore _firestore;

  CepDatasourceImpl(this._dio, this._firestore);
  
  @override
  Future<CepModel> getCep(String cep) async {
    var response = await _dio.get('https://viacep.com.br/ws/$cep/json/');

    if (response.statusCode == 200) {
      return CepModel.fromMap(response.data);
    }
    throw Failure();
  }

  @override
  Future<void> saveAddress(String cep, String endereco) async {
    await _firestore.collection('cep').add({
      'cep': cep,
      'endereco': endereco,
      'timestamp': DateTime.now().toIso8601String(),
    });
    return;
  }
}

//implementacao do CEP usando o "DIO"