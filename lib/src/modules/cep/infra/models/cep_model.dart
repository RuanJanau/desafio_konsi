import '../../domain/entities/cep_entity.dart';

class CepModel extends CepEntity {
  const CepModel({
    required super.cep,
    required super.logradouro,
    required super.complemento,
    required super.bairro,
    required super.localidade,
    required super.uf,
    required super.ibge,
    required super.gia,
    required super.ddd,
    required super.siafi,
  });

  factory CepModel.fromMap(Map<String, dynamic> map) {
    return CepModel(
      cep: map['cep'] as String,
      logradouro: map['logradouro'] as String,
      complemento: map['complemento'] as String,
      bairro: map['bairro'] as String,
      localidade: map['localidade'] as String,
      uf: map['uf'] as String,
      ibge: map['ibge'] as String,
      gia: map['gia'] as String,
      ddd: map['ddd'] as String,
      siafi: map['siafi'] as String,
    );
  }
}

//implementacao da API.