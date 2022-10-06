// Mocks generated by Mockito 5.3.2 from annotations
// in desafio_konsi/test/src/modules/cep/infra/repositories/cep_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:desafio_konsi/src/modules/cep/infra/datasource/cep_datasource.dart'
    as _i3;
import 'package:desafio_konsi/src/modules/cep/infra/models/cep_model.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeCepModel_0 extends _i1.SmartFake implements _i2.CepModel {
  _FakeCepModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CepDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockCepDatasource extends _i1.Mock implements _i3.CepDatasource {
  MockCepDatasource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.CepModel> getCep(String? cep) => (super.noSuchMethod(
        Invocation.method(
          #getCep,
          [cep],
        ),
        returnValue: _i4.Future<_i2.CepModel>.value(_FakeCepModel_0(
          this,
          Invocation.method(
            #getCep,
            [cep],
          ),
        )),
      ) as _i4.Future<_i2.CepModel>);
  @override
  _i4.Future<void> saveAddress(
    String? cep,
    String? endereco,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveAddress,
          [
            cep,
            endereco,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [CepModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockCepModel extends _i1.Mock implements _i2.CepModel {
  MockCepModel() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get cep => (super.noSuchMethod(
        Invocation.getter(#cep),
        returnValue: '',
      ) as String);
  @override
  String get logradouro => (super.noSuchMethod(
        Invocation.getter(#logradouro),
        returnValue: '',
      ) as String);
  @override
  String get complemento => (super.noSuchMethod(
        Invocation.getter(#complemento),
        returnValue: '',
      ) as String);
  @override
  String get bairro => (super.noSuchMethod(
        Invocation.getter(#bairro),
        returnValue: '',
      ) as String);
  @override
  String get localidade => (super.noSuchMethod(
        Invocation.getter(#localidade),
        returnValue: '',
      ) as String);
  @override
  String get uf => (super.noSuchMethod(
        Invocation.getter(#uf),
        returnValue: '',
      ) as String);
  @override
  String get ibge => (super.noSuchMethod(
        Invocation.getter(#ibge),
        returnValue: '',
      ) as String);
  @override
  String get gia => (super.noSuchMethod(
        Invocation.getter(#gia),
        returnValue: '',
      ) as String);
  @override
  String get ddd => (super.noSuchMethod(
        Invocation.getter(#ddd),
        returnValue: '',
      ) as String);
  @override
  String get siafi => (super.noSuchMethod(
        Invocation.getter(#siafi),
        returnValue: '',
      ) as String);
  @override
  List<Object> get props => (super.noSuchMethod(
        Invocation.getter(#props),
        returnValue: <Object>[],
      ) as List<Object>);
}