import 'dart:async';

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
  Completer<GoogleMapController> controllerMaps = Completer();

  final _cepController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var controller = Modular.get<CepController>();

  @override
  @override
  void initState() {
    super.initState();
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 12,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.favorite_border),
        title: const Text('Localização'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _cepController,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(
                    color: Colors.green,
                  ),
                  labelText: 'Digite o Cep ',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.green, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (text) {
                  if (text!.isEmpty) {
                    return 'Digite um cep';
                  } else if (text.length < 8) {
                    return 'Cep Icompleto';
                  }
                  return null;
                },
              ),
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
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  controllerMaps.complete(controller);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => searchCep(),
      ),
    );
  }

  void searchCep() {
    controller.showCep(_cepController.text);

    final form = _formKey.currentState;
    if (form!.validate()) {}

    setState(() {});
  }
}
