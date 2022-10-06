import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../history/domain/usecases/get_history_usecase.dart';
import '../../domain/entities/cep_entity.dart';
import '../../domain/usecases/get_cep_usecase.dart';
import '../state/cep_state.dart';

class CepController extends ValueNotifier<CepState> {
  Completer<GoogleMapController> controllerMaps = Completer();
  final GetCepUsecase _usecase;
  final GetHistoryUsecase _historyUsecase;
  late LatLng latLng;
  String? title;
  bool isLoadingMap = true;
  CepEntity? cepEntity;
  CepController(this._usecase, this._historyUsecase)
      : super(const CepState.loading());

  Future showCep(String cep) async {
    final result = await _usecase(cep);
    result.fold((l) {}, (r) {
      cepEntity = r;
    });
  }

  void getLatLgn({required String address}) async {
    final GoogleMapController googleMapController = await controllerMaps.future;
    List<Location> locations = await locationFromAddress(address);
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(locations.first.latitude, locations.first.longitude),
          zoom: 19,
        ),
      ),
    );
    await showCep(address);
    addHistory(cepEntity!.cep.replaceAll('-', ''),
        '${cepEntity!.logradouro}, ${cepEntity!.localidade}, ${cepEntity!.uf}');
  }

  Future<void> getPermission() async {
    value = const CepState.loading();
    if (await Permission.location.request().isGranted) {
      getCurrentLocation();
    } else {
      value = const CepState.error();
    }
  }

  Future<void> getCurrentLocation() async {
    Position position = await geo.Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high);
    latLng = LatLng(position.latitude, position.longitude);
    value = const CepState.success();
  }

  Future<void> addHistory(String cep, String endereco) async =>
      _historyUsecase();
}
