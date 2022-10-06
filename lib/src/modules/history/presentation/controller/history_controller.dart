import 'package:flutter/foundation.dart';

import '../../domain/usecases/get_history_usecase.dart';
import '../state/history_state.dart';

class HistoryController extends ValueNotifier<HistoryState> {
  final GetHistoryUsecase _historyUsecase;

  HistoryController(this._historyUsecase) : super(const HistoryState.loading());

  Future<void> showHistory() async {
    value = const HistoryState.loading();

    final response = await _historyUsecase();
    value = response.fold(
      (error) => const HistoryState.error(),
      (success) => HistoryState.success(success),
    );
  }
}