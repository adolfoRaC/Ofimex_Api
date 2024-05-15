class OficioTrabajo {
  int? id;
  int idOficio;
  int idUsuario;

  OficioTrabajo({this.id, required this.idOficio, required this.idUsuario});

  factory OficioTrabajo.getJson(Map json) {
    return OficioTrabajo(
      id: json['id'],
      idOficio: json['idOficio'],
      idUsuario: json['idUsuario'],
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
