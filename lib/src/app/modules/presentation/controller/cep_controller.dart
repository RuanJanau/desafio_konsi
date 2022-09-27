import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../../domain/entities/cep_entity.dart';
import '../../domain/usecases/get_cep_usecase.dart';

class CepController {
  final GetCepUsecase _usecase;

  CepController(this._usecase);
  RxNotifier<CepEntity>? cepEntity;

  RxNotifier<bool> isLoading = RxNotifier<bool>(false);

  Future showCep(String cep) async {
    isLoading.value = true;
    var result = await _usecase(cep);

    result.fold((l) {}, (r) {
      cepEntity = RxNotifier<CepEntity>(r);
      isLoading = RxNotifier<bool>(false);
    });

    log('${cepEntity?.value.cep}');
  }

  Future<LatLng> getLatLgn({required String address}) async {
    List<Location> locations = await locationFromAddress(address);
    return LatLng(locations.first.latitude, locations.first.longitude);
  }
}
