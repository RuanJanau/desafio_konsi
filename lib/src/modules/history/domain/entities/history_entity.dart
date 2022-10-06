import 'package:equatable/equatable.dart';

class HistoryEntity extends Equatable {
  final String cep;
  final String endereco;

  final String timestamp;

  const HistoryEntity({
    required this.cep,
    required this.endereco,
    required this.timestamp,
  });

  @override
  List<Object> get props {
    return [
      cep,
      endereco,
      timestamp,
    ];
  }
}
