import 'package:flutter/material.dart';
import 'package:ofimex/provider/globales.dart';
import 'package:provider/provider.dart';

class SelectHistorial extends StatelessWidget {
  final Widget historialCliente;
  final Widget historialTrabajador;
  const SelectHistorial(
      {super.key, required this.historialCliente, required this.historialTrabajador, });

  @override
  Widget build(BuildContext context) {
        final globales = context.watch<Globales>();

    return LayoutBuilder(
      builder: (context, constraints) {
        if (globales.usuario.idRol == 2) {
          return historialCliente;
        } else if (globales.usuario.idRol == 3) {
          return historialTrabajador;
        }
        return historialCliente;
      },
    );
  }
}
