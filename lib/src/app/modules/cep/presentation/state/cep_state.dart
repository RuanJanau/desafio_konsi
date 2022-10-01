import 'package:freezed_annotation/freezed_annotation.dart';

part 'cep_state.freezed.dart';

@freezed
class CepState with _$CepState {
  const factory CepState.loading() = _Loading;

  const factory CepState.success() = _Success;

  const factory CepState.error() = _Error;
}
