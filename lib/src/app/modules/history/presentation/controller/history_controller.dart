import 'dart:developer';

import 'package:desafio_konsi/src/app/modules/history/domain/usecases/get_history_usecase.dart';
import 'package:desafio_konsi/src/app/modules/history/infra/models/hisotry_model.dart';
import 'package:desafio_konsi/src/app/modules/history/presentation/state/history_state.dart';
import 'package:flutter/foundation.dart';

class HistoryController extends ValueNotifier<HistoryState> {
  List<HistoryModel> listHistory = <HistoryModel>[];
  final GetHistoryUsecase _usecase;

  HistoryController(this._usecase) : super(const HistoryState.loading());

  Future<void> getHistory() async {
    try {
      final response = await _usecase();
      final decodedResponse = response.fold((error) => error, (val) => val);
      if (decodedResponse is List<HistoryModel>) {
        listHistory = decodedResponse;
        value = const HistoryState.success();
      } else {
        log("error getHistory 1 -> ");
        value = const HistoryState.error();
      }
    } catch (e) {
      log("error getHistory 2 -> $e");
      value = const HistoryState.error();
    }
  }

  Future<void> onRefresh() async {
    value = const HistoryState.loading();
    getHistory();
  }
}
