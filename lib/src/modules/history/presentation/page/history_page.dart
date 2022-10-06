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
    controller.showHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Pesquisa'),
      ),
      body: ValueListenableBuilder(
        builder: (context, value, child) {
          return controller.value.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (histories) => RefreshIndicator(
              onRefresh: () => controller.showHistory(),
              child: ListView.separated(
                padding: const EdgeInsets.all(16.0),
                itemCount: histories.length,
                itemBuilder: (context, index) {
                  var item = histories[index];
                  return ListTile(
                    title: Text("${item.cep}"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    tileColor: Colors.grey.withOpacity(0.4),
                    subtitle: Text(item.endereco),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10.0),
              ),
            ),
            error: () => const Center(child: Text('Error')),
          );
        },
        valueListenable: controller,
      ),
    );
  }
}//