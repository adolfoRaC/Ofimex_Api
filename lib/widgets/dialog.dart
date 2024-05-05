import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class CustomDialog extends StatelessWidget {
  final String mensaje;
  final VoidCallback onPressed;

  CustomDialog({Key? key, required this.mensaje, required this.onPressed})
      : super(key: key);

  void show(BuildContext context) {
    SmartDialog.show(builder: (_) {
      return Container(
        height: 200,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              mensaje,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                onPressed;
                SmartDialog.dismiss();
              },
              child: const Text("Reintentar"),
            ),
            ElevatedButton(
              onPressed: () {
                SmartDialog.dismiss();
                onPressed(); // Llama a la función onPressed cuando se presiona el botón Cerrar
              },
              child: const Text('Cerrar'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // Esto es solo un marcador de posición, ya que el widget no se utiliza directamente en el árbol de widgets
  }
}
