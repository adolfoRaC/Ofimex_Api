class EvidenciaTrabajo {
  int? id;
  String imagen;
  int idTrabajo;

  EvidenciaTrabajo({this.id, required this.imagen, required this.idTrabajo});

  factory EvidenciaTrabajo.getJson(Map<String, dynamic> json) {
    return EvidenciaTrabajo(
        id: json['id'], imagen: json['idImagen'], idTrabajo: json['idTrabajo']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'idImagen': imagen, 'idTrabajo': idTrabajo};
  }
}
