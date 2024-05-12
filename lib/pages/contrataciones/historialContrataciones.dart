import 'package:flutter/material.dart';
import 'package:ofimex/widgets/cardHistorial.dart';

class HistorialContratacionesPage extends StatefulWidget {
  const HistorialContratacionesPage({super.key});

  @override
  State<HistorialContratacionesPage> createState() =>
      _HistorialContratacionesPageState();
}

class _HistorialContratacionesPageState
    extends State<HistorialContratacionesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Historial",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(children: [
            WorkerServiceCard(
              workerName: "Roberto Carlos",
              serviceName: "Electricista",
              cost: 100.0,
              date: DateTime.now().subtract(const Duration(days: 1)),
              status: "En espera",
            ),
            
            WorkerServiceCard(
              workerName: "Juan Pérez",
              serviceName: "Plomero",
              cost: 700.0,
              date: DateTime.now(),
              status: "En proceso",
            ),
            WorkerServiceCard(
              workerName: "Carlos López",
              serviceName: "Albañil",
              cost: 2075.0,
              date: DateTime.now().subtract(const Duration(days: 2)),
              status: "Realizado",
            ),
            WorkerServiceCard(
              workerName: "Eduardo Hernández",
              serviceName: "Herrero",
              cost: 200.0,
              date: DateTime.now().subtract(const Duration(days: 3)),
              status: "Cancelado",
            ),
          ]),
        ),
      )),
    );
  }
}
