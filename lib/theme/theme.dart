import 'package:flutter/material.dart';

const List<Color> _colorThemes = [
  Color.fromRGBO(25, 118, 210, 1), // Primer color para temas
  Colors.orange,
  Colors.green,
];

class AppTheme {
  ThemeData theme() {
    final Color primaryColor = getColor(0); // Obten el color principal a partir del índice
    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryColor, // Color principal
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor, // Semilla para otros colores en el esquema
        brightness: Brightness.light, // O Brightness.dark para temas oscuros
      ),
    );
  }

  Color getColor(int index) {
    if (index >= 0 && index < _colorThemes.length) {
      return _colorThemes[index];
    } else {
      return Colors.grey;
    }
  }
}
