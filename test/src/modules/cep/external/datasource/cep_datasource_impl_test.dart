import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_konsi/src/modules/cep/external/datasource/cep_datasource_impl.dart';
import 'package:desafio_konsi/src/modules/cep/infra/models/cep_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cep_datasource_impl_test.mocks.dart';

@GenerateMocks([Dio, FirebaseFirestore])
void main() {
  late MockDio dio;

  late MockFirebaseFirestore firestore;

  late CepDatasourceImpl datasource;

  setUp(() {
    dio = MockDio();
    firestore = MockFirebaseFirestore();
    datasource = CepDatasourceImpl(dio, firestore);
  });

  test('deve retornar um CepModel', () async {
    when(dio.get(any)).thenAnswer(
      (_) async => Response(
        data: jsonDecode(jsonResponse),
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    var result = await datasource.getCep("jacob");
    expect(result, isA<CepModel>());
  });
}

var jsonResponse = r'''{
  "cep": "69313-348",
  "logradouro": "Rua Heráclito Cavalcante",
  "complemento": "",
  "bairro": "Cambará",
  "localidade": "Boa Vista",
  "uf": "RR",
  "ibge": "1400100",
  "gia": "",
  "ddd": "95",
  "siafi": "0301"
}''';
