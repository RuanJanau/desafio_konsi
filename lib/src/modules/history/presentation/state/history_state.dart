import 'package:freezed_annotation/freezed_annotation.dart';

import '../../infra/models/hisotry_model.dart';

part 'history_state.freezed.dart';

@freezed
class HistoryState with _$HistoryState {
  const factory HistoryState.loading() = _Loading;

  const factory HistoryState.success( List<HistoryModel> histories) = _Success;

  const factory HistoryState.error() = _Error;
}