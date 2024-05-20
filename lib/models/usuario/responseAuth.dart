import 'package:ofimex/models/usuario/comentario.dart';
import 'package:ofimex/models/usuario/trabajo.dart';
import 'package:ofimex/models/usuario/usuario.dart';

class ResponseAuth {
  int codigo;
  String mensaje;
  Usuario? usuario;
  Trabajo?  trabajo;
  Comentario? comentario;
  ResponseAuth({required this.codigo, required this.mensaje, this.usuario,this.trabajo, this.comentario});
}
