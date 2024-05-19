
import 'package:ofimex/models/usuario/oficoTrabajo.dart';
import 'package:ofimex/models/usuario/rol.dart';

class TrabajoT {
  int id;
  String descripcion;
  int costoTotal;
  int idEstado;
  int idUsuario;
  int idTrabajador;
  int idOficio;
  TrabajadorT? trabajador;
  List<DireccionT>? direcciones;
  UsuarioT? usuario;

  TrabajoT({
    required this.id,
    required this.descripcion,
    required this.costoTotal,
    required this.idEstado,
    required this.idUsuario,
    required this.idTrabajador,
    required this.idOficio,
    this.trabajador,
    this.direcciones,
    this.usuario,
  });

  factory TrabajoT.getJson(Map<String, dynamic> json) {
    return TrabajoT(
      id: json['id'],
      descripcion: json['descripcion'],
      costoTotal: json['costoTotal'],
      idEstado: json['idEstado'],
      idUsuario: json['idUsuario'],
      idTrabajador: json['idTrabajador'],
      idOficio: json['idOficio'],
      trabajador: TrabajadorT.fromJson(json['trabajador']),
      direcciones: List<DireccionT>.from(json['direcciones'].map((x) => DireccionT.fromJson(x))),
      usuario: UsuarioT.fromJson(json['usuario']),
    );
  }
}

class TrabajadorT {
  int id;
  int edad;
  int experiencia;
  int trabajos;
  bool disponible;
  String membresia;
  int idUsuario;
  UsuarioT usuario;

  TrabajadorT({
    required this.id,
    required this.edad,
    required this.experiencia,
    required this.trabajos,
    required this.disponible,
    required this.membresia,
    required this.idUsuario,
    required this.usuario,
  });

  factory TrabajadorT.fromJson(Map<String, dynamic> json) {
    return TrabajadorT(
      id: json['id'],
      edad: json['edad'],
      experiencia: json['experiencia'],
      trabajos: json['trabajos'],
      disponible: json['disponible'],
      membresia: json['membresia'],
      idUsuario: json['idUsuario'],
      usuario: UsuarioT.fromJson(json['usuario']),
    );
  }
}

class DireccionT {
  int id;
  String latitud;
  String longitud;
  String municipio;
  String colonia;
  String calle;
  int cp;
  int numeroExt;
  String descripcion;
  int idTrabajo;

  DireccionT({
    required this.id,
    required this.latitud,
    required this.longitud,
    required this.municipio,
    required this.colonia,
    required this.calle,
    required this.cp,
    required this.numeroExt,
    required this.descripcion,
    required this.idTrabajo,
  });

  factory DireccionT.fromJson(Map<String, dynamic> json) {
    return DireccionT(
      id: json['id'],
      latitud: json['latitud'],
      longitud: json['longitud'],
      municipio: json['municipio'],
      colonia: json['colonia'],
      calle: json['calle'],
      cp: json['cp'],
      numeroExt: json['numeroExt'],
      descripcion: json['descripcion'],
      idTrabajo: json['idTrabajo'],
    );
  }
}

class UsuarioT {
  int id;
  String nombre;
  String apePat;
  String apeMat;
  String sexo;
  String correo;
  String usuario;
  String pwd;
  int idRol;
  Rol? rol;
  List<OficioTrabajo>? oficioTrabajo;
  UsuarioT({
    required this.id,
    required this.nombre,
    required this.apePat,
    required this.apeMat,
    required this.sexo,
    required this.correo,
    required this.usuario,
    required this.pwd,
    required this.idRol,
    this.rol,
    this.oficioTrabajo,
  });

  factory UsuarioT.fromJson(Map<String, dynamic> json) {
    var list = json['oficio'] as List;
    List<OficioTrabajo> oficiosList =
        list.map((e) => OficioTrabajo.getJson(e)).toList();
    return UsuarioT(
      id: json['id'],
      nombre: json['nombre'],
      apePat: json['apePat'],
      apeMat: json['apeMat'],
      sexo: json['sexo'],
      correo: json['correo'],
      usuario: json['usuario'],
      pwd: json['pwd'],
      idRol: json['idRol'],
      rol: Rol.getJson(json['rol']),
      oficioTrabajo: oficiosList,
    );
  }
}
