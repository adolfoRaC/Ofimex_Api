import 'package:flutter/material.dart';
import 'package:ofimex/pages/contrataciones/historialCliente.dart';
import 'package:ofimex/pages/contrataciones/historialTrabajador.dart';
import 'package:ofimex/pages/contrataciones/selectHistorial.dart';

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
          "Trabajos",
        ),
        centerTitle: true,
      ),
      body: const SelectHistorial(historialCliente: HistorialCliente(), historialTrabajador: HistorialTrabajador(),)
    );
  }
}
