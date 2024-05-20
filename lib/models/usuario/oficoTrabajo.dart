
import 'package:ofimex/models/usuario/oficio.dart';

class OficioTrabajo {
  int? id;
  int idOficio;
  int idTrabajador;
  Oficio? oficio;

  OficioTrabajo({
    this.id,
    required this.idOficio,
    required this.idTrabajador,
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
      idTrabajador: json['idTrabajador'],
      oficio: oficioData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idOficio': idOficio,
      'idTrabajador': idTrabajador,
    };
  }
}
