import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../controller/history_controller.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoricPageState();
}

class _HistoricPageState extends State<HistoryPage> {
  HistoryController controller = Modular.get<HistoryController>();

  @override
  void initState() {
    controller.getHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historico de Pesquisa'),
      ),
      body: ValueListenableBuilder(
        builder: (context, value, child) {
          return controller.value.when(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            success: () => RefreshIndicator(
              onRefresh: () => controller.onRefresh(),
              child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  itemCount: controller.listHistory.length,
                  itemBuilder: (context, index) => ListTile(
                        title: Text("${controller.listHistory[index].cep}"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        tileColor: Colors.accents[index],
                        subtitle: Text(controller.listHistory[index].endereco),
                      ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10)),
            ),
            error: () => const Center(
              child: Text('Error'),
            ),
          );
        },
        valueListenable: controller,
      ),
    );
  }
}
