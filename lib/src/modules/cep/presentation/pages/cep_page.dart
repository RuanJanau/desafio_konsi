import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: const Text('Pesquisar Endereços'),
        ),
        body: ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, value, child) {
            return controller.value.when(
              loading: () => loading(),
              success: () => success(context),
              error: () => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Permisão de Localização negada!'),
                    ElevatedButton(
                      onPressed: () => controller.getPermission(),
                      child: const Text('Tentar novamente'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Column success(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16.0),
        Row(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _cepController,
                  decoration: InputDecoration(
                    suffix: InkWell(
                      child: const Icon(
                        Icons.close,
                        size: 18.0,
                        color: Colors.grey,
                      ),
                      onTap: () => _cepController.clear(),
                    ),
                    filled: true,
                    alignLabelWithHint: true,
                    hintText: 'Digite seu cep ou endereço...',
                    hintStyle: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12.00,
                    ),
                    labelStyle: const TextStyle(
                      color: Colors.green,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
                  textInputAction: TextInputAction.search,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return 'Digite o Cep';
                    } else if (text.length < 8) {
                      return 'Cep icompleto';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                controller.getLatLgn(address: _cepController.text);
              },
              icon: const Icon(Icons.search),
              splashRadius: 25.0,
              tooltip: 'Pesquisar',
            ),
            IconButton(
              onPressed: () => Modular.to.pushNamed('/history'),
              icon: const Icon(Icons.history),
              splashRadius: 26.0,
              tooltip: 'Historico',
            ),
          ],
        ),
        Expanded(
          child: GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: CameraPosition(
              target: controller.latLng,
              zoom: 19.0,
            ),
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
    );
  }

  Center loading() => const Center(child: CircularProgressIndicator());

  void searchCep() {
    controller.showCep(_cepController.text);
    controller.getLatLgn(address: _cepController.text);

    final form = _formKey.currentState;
    if (form!.validate()) {}
  }
}
