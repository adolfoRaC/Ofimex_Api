import 'package:ofimex/models/usuario/direccion.dart';
import 'package:ofimex/models/usuario/trabajador.dart';
import 'package:ofimex/models/usuario/usuario.dart';

class Trabajo {
  int? id;
  String descripcion;
  int costoTotal;
  int? idEstado;
  int idUsuario;
  int idTrabajador;
  int idOficio;
  Trabajador? trabajador;
  List<Direccion>? direccion;
  Usuario? usuario;

  Trabajo({
    this.id,
    required this.descripcion,
    required this.costoTotal,
    required this.idUsuario,
    required this.idTrabajador,
    required this.idOficio,
    this.idEstado,
    this.trabajador,
    this.direccion,
    this.usuario,
  });

  factory Trabajo.getJson(Map<String, dynamic> json) {
    Trabajador? trabajadorData;
    if (json['trabajador'] is Map<String, dynamic>) {
      trabajadorData = Trabajador.getJson(json['trabajador']);
    }
    final list = json['direcciones'] as List;
    List<Direccion> direccionList =
        list.map((e) => Direccion.getJson(e)).toList();

    Usuario? usuarioData;
    if (json['usuario'] is Map<String, dynamic>) {
      usuarioData = Usuario.getJson(json['usuario']);
    }

    return Trabajo(
      id: json['id'],
      descripcion: json['descripcion'],
      costoTotal: json['costoTotal'],
      idEstado: json['idEstado'],
      idUsuario: json['idUsuario'],
      idTrabajador: json['idTrabajador'],
      idOficio: json['idOficio'],
      trabajador: trabajadorData,
      direccion: direccionList,
      usuario: usuarioData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descripcion': descripcion,
      'costoTotal': costoTotal,
      'idUsuario': idUsuario,
      'idTrabajador': idTrabajador,
      'idOficio': idOficio,
      'idEstado': idEstado,
      // 'trabajador':trabajador
    };
  }
}
