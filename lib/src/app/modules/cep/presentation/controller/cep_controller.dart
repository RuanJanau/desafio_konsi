// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../../domain/entities/cep_entity.dart';
import '../../domain/usecases/get_cep_usecase.dart';
import '../state/cep_state.dart';

class CepController extends ValueNotifier<CepState> {
  Completer<GoogleMapController> controllerMaps = Completer();
  final GetCepUsecase _usecase;

  CepController(this._usecase) : super(const CepState.loading());
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

  late LatLng latLng;
  String? title;
  bool isLoadingMap = true;

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
  }

  Future<void> getPermission() async {
    getCurrentLocation();
    if (await Permission.location.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      print("Location Permission is granted");
    } else {
      print("Location Permission is denied.");
    }
  }

  Future<void> getCurrentLocation() async {
    Position position = await geo.Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high);
    latLng = LatLng(position.latitude, position.longitude);
    value = const CepState.success();
  }
}
