import 'dart:io';

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
  });
  factory Usuario.getJson(Map json){
    return Usuario(id: json["id"],nombre: json["nombre"], apePat: json["apePat"], apeMat: json["apeMat"], sexo: json["sexo"], correo: json["correo"], usuario: json["usuario"], pwd: json["pwd"], idRol: json["idRol"]);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,  // Incluimos el campo "id" si es necesario
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
