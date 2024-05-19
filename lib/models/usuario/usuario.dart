
import 'package:ofimex/models/usuario/oficoTrabajo.dart';
import 'package:ofimex/models/usuario/rol.dart';
import 'package:ofimex/models/usuario/trabajador.dart';

class Usuario {
  int? id;
  String nombre;
  String apePat;
  String apeMat;
  String sexo;
  String correo;
  String usuario;
  String pwd;
  int idRol;
  Rol? rol;
  List<OficioTrabajo>? oficio;
  Trabajador? trabajador;

  Usuario({
    this.id,
    required this.nombre,
    required this.apePat,
    required this.apeMat,
    required this.sexo,
    required this.correo,
    required this.usuario,
    required this.pwd,
    required this.idRol,
    this.rol,
    this.oficio,
    this.trabajador,
  });
  factory Usuario.getJson(Map<String, dynamic> json) {
    
    var list = json['oficio'] as List;
    List<OficioTrabajo> oficiosList =
        list.map((e) => OficioTrabajo.getJson(e)).toList();

    Trabajador? trabajadorData;
    if (json['trabajador'] is Map<String, dynamic>) {
      trabajadorData = Trabajador.getJson(json['trabajador']);
    }
    return Usuario(
      id: json["id"],
      nombre: json["nombre"],
      apePat: json["apePat"],
      apeMat: json["apeMat"],
      sexo: json["sexo"],
      correo: json["correo"],
      usuario: json["usuario"],
      pwd: json["pwd"],
      idRol: json["idRol"],
      rol: Rol.getJson(json['rol']),
      oficio: oficiosList,
      trabajador: trabajadorData,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id, 
      'nombre': nombre,
      'apePat': apePat,
      'apeMat': apeMat,
      'sexo': sexo,
      'correo': correo,
      'usuario': usuario,
      'pwd': pwd,
      'idRol': idRol,
    };
  }
}
