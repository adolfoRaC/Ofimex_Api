
import 'package:ofimex/models/usuario/oficio.dart';

class OficioTrabajo {
  int? id;
  int idOficio;
  int idUsuario;
  Oficio? oficio;

  OficioTrabajo({
    this.id,
    required this.idOficio,
    required this.idUsuario,
    this.oficio,
  });

  factory OficioTrabajo.getJson(Map<String, dynamic> json) {
    Oficio? oficioData;
    if (json['oficio'] is Map<String, dynamic>) {
      oficioData = Oficio.getJson(json['oficio']);
    }
    return OficioTrabajo(
      id: json['id'],
      idOficio: json['idOficio'],
      idUsuario: json['idUsuario'],
      oficio: oficioData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idOficio': idOficio,
      'idUsuario': idUsuario,
    };
  }
}
