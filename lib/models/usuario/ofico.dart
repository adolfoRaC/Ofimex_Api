class Oficio {
  int id;
  int idOficio;
  int idUsuario;

  Oficio({required this.id, required this.idOficio, required this.idUsuario});

  factory Oficio.getJson(Map json) {
    return Oficio(
        id: json['id'],
        idOficio: json['idOficio'],
        idUsuario: json['idUsuario']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idOficio': idOficio,
      'idUsuario': idUsuario,
    };
  }
}
