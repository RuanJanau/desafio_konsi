import 'package:dartz/dartz.dart';
import 'package:desafio_konsi/src/core/errors/error.dart';
import 'package:desafio_konsi/src/modules/cep/infra/datasource/cep_datasource.dart';
import 'package:desafio_konsi/src/modules/cep/infra/models/cep_model.dart';
import 'package:desafio_konsi/src/modules/cep/infra/repositories/cep_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cep_repository_impl_test.mocks.dart';

@GenerateMocks([CepDatasource, CepModel])
void main() {
  late MockCepDatasource datasource;

  late CepRepositoryImpl repository;

  setUp(() {
    datasource = MockCepDatasource();
    repository = CepRepositoryImpl(datasource);
  });

  group('CepRepositoryImpl /', () {
    test('deve retornar um CepEntity', () async {
      //arrange
      when(datasource.getCep(any)).thenAnswer(
        (_) async => MockCepModel(),
      );
      //act
      var result = await repository.search('69313348');
      //assert
      expect(result.isRight(), true);
      expect(result.fold((id), (id)), isA<MockCepModel>());
    });
    test('deve retornar um Failure', () async {
      //arrange
      when(datasource.getCep(any)).thenAnswer(
        (_) async => throw Failure(),
      );
      //act
      var result = await repository.search('6931334');
      //assert
      expect(result.isLeft(), true);
      expect(result.fold((id), (id)), isA<Failure>());
    });
  });
}
