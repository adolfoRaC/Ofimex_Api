import 'package:ofimex/models/usuario/usuario.dart';

class ResponseAuth {
  int codigo;
  String mensaje;
  Usuario? usuario;
  ResponseAuth({required this.codigo, required this.mensaje, this.usuario});
}