import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../controller/cep_controller.dart';

class CepPage extends StatefulWidget {
  const CepPage({Key? key}) : super(key: key);

  @override
  State<CepPage> createState() => _CepPageState();
}

class _CepPageState extends State<CepPage> {
  final _cepController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var controller = Modular.get<CepController>();

  @override
  void initState() {
    controller.getPermission();
    setState(() {});
    super.initState();
  }

  static const _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 12,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: const Text('Drogas'),
        ),
        body: ValueListenableBuilder(
          builder: (context, value, child) {
            return controller.value.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              success: () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 50,
                            decoration:
                                const BoxDecoration(color: Colors.transparent),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _cepController,
                                decoration: InputDecoration(
                                  suffix: InkWell(
                                    child: const Icon(
                                      Icons.close,
                                      size: 17,
                                      color: Colors.grey,
                                    ),
                                    onTap: () => _cepController.clear(),
                                  ),
                                  filled: true,
                                  alignLabelWithHint: true,
                                  hintText: 'Digite seu cep ou endereço...',
                                  hintStyle: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  labelStyle: const TextStyle(
                                    color: Colors.green,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.5),
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                ),
                                textInputAction: TextInputAction.search,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (text) {
                                  if (text!.isEmpty) {
                                    return 'Digite um Cep';
                                  } else if (text.length < 8) {
                                    return 'Cep icompleto';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          controller.getLatLgn(address: _cepController.text);
                        },
                        icon: const Icon(Icons.search),
                        splashRadius: 25.0,
                      ),
                      IconButton(
                        onPressed: () {
                          Modular.to.pushNamed('/history');
                        },
                        icon: const Icon(Icons.history),
                        splashRadius: 25.0,
                      ),
                    ],
                  ),
                  RxBuilder(
                    builder: (_) {
                      if (controller.isLoading.value == false) {
                        return Container();
                      }

                      return Text(
                          'Cidade: ${controller.cepEntity?.value.localidade}');
                    },
                  ),
                  Expanded(
                    child: GoogleMap(
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      initialCameraPosition:
                          CameraPosition(target: controller.latLng, zoom: 19.0),
                      onMapCreated: (GoogleMapController googleMapController) {
                        controller.controllerMaps.complete(googleMapController);
                      },
                      gestureRecognizers: {
                        Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer(),
                        ),
                      },
                    ),
                  ),
                ],
              ),
              error: () => Container(),
            );
          },
          valueListenable: controller,
        ),
      ),
    );
  }

  void searchCep() {
    controller.showCep(_cepController.text);
    controller.getLatLgn(address: _cepController.text);

    final form = _formKey.currentState;
    if (form!.validate()) {}

    setState(() {});
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<CameraPosition>('_kGooglePlex', _kGooglePlex));
  }
}
