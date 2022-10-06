import 'package:dartz/dartz.dart';
import 'package:desafio_konsi/src/core/errors/error.dart';
import 'package:desafio_konsi/src/modules/cep/domain/usecases/save_history_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'get_cep_usecase_test.mocks.dart';

void main() {
  late MockCepRepository repository;

  late GetHistoryUsecaseImpl historyUsecase;

  setUp(() {
    repository = MockCepRepository();
    historyUsecase = GetHistoryUsecaseImpl(repository);
  });
  group('GetHistoryUsecaseImpl / ', () {
    test('deve retornar um CepEntity', () async {
      //arrange
      when(repository.addHistory(any, any)).thenAnswer(
        (_) async => Right(MockCepEntity()),
      );
      //act
      var result = await historyUsecase('69313348', 'Rua Baruru');
      //assert
      expect(result.isRight(), true);
    });
    test('deve retornar um Failure', () async {
      //arrange
      when(repository.addHistory(any, any)).thenAnswer(
        (_) async => Left(Failure()),
      );
      //act
      var result = await historyUsecase('69313348', 'Rua Baruru');
      //assert
      expect(result.isLeft(), true);
    });
    test(
        'deve retornar um Failure quando o endereco for vazio ou o cep for invalido',
        () async {
      //arrange
      when(repository.addHistory(any, any)).thenAnswer(
        (_) async => Left(Failure()),
      );
      //act
      var result = await historyUsecase('', '');
      //assert
      expect(result.isLeft(), true);
    });
  });
}
