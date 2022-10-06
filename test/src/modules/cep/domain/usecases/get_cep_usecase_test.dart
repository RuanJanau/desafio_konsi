import 'package:dartz/dartz.dart';
import 'package:desafio_konsi/src/core/errors/error.dart';
import 'package:desafio_konsi/src/modules/cep/domain/entities/cep_entity.dart';
import 'package:desafio_konsi/src/modules/cep/domain/repositories/cep_repository.dart';
import 'package:desafio_konsi/src/modules/cep/domain/usecases/get_cep_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_cep_usecase_test.mocks.dart';

@GenerateMocks([CepRepository, CepEntity])
void main() {
  late MockCepRepository repository;

  late GetCepUsecaseImpl cepUsecase;

  setUp(() {
    repository = MockCepRepository();
    cepUsecase = GetCepUsecaseImpl(repository);
  });
  group('GetCepUsecaseImpl /', () {
    test('deve retornar um CepEntity', () async {
      //arrange
      when(repository.search(any)).thenAnswer(
        (_) async => Right(MockCepEntity()),
      );
      //act
      var result = await cepUsecase('69313348');
      //assert
      expect(result.isRight(), true);
      expect(result.fold((id), (id)), isA<MockCepEntity>());
    });
    test('deve retornar um Failure', () async {
      //arrange
      when(repository.search(any)).thenAnswer(
        (_) async => Left(Failure()),
      );
      //act
      var result = await cepUsecase('69313348');
      //assert
      expect(result.isLeft(), true);
      expect(result.fold((id), (id)), isA<Failure>());
    });
    test('deve retornar um Failure quando o cep for invalido', () async {
      //arrange
      when(repository.search(any)).thenAnswer(
        (_) async => Left(Failure()),
      );
      //act
      var result = await cepUsecase('6931334');
      //assert
      expect(result.isLeft(), true);
      expect(result.fold((id), (id)), isA<Failure>());
    });
  });
}
