import 'package:ofimex/models/usuario/usuario.dart';

class Trabajador {
  int? id;
  int edad;
  int experiencia;
  int? trabajos;
  bool? disponible;
  String? membresia;
  int idUsuario;
  Usuario? usuario;
  Trabajador(
      {this.id,
      required this.edad,
      required this.experiencia,
      this.trabajos,
      this.disponible,
      this.membresia,
      required this.idUsuario,
      this.usuario});

  factory Trabajador.getJson(Map<String, dynamic> json) {

    Usuario? usuarioData;
    if (json['usuario'] is Map<String, dynamic>) {
      usuarioData = Usuario.getJson(json['usuario']);
    }

    return Trabajador(
      id: json['id'],
      edad: json['edad'],
      experiencia: json['experiencia'],
      trabajos: json['trabajos'],
      disponible: json['disponible'],
      membresia: json['membresia'],
      idUsuario: json['idUsuario'],
      usuario: usuarioData,

    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'edad': edad,
      'experiencia': experiencia,
      'trabajos': trabajos,
      'disponible': disponible,
      'membresia': membresia,
      'idUsuario': idUsuario
    };
  }
}
