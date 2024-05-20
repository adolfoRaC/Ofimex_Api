class Comentario {
  int? id;
  String mensaje;
  int calificiacion;
  int idTrabajo;

  Comentario(
      {this.id,
      required this.mensaje,
      required this.calificiacion,
      required this.idTrabajo});

  factory Comentario.getJson(Map<String, dynamic> json) {
    return Comentario(
        id: json['id'],
        mensaje: json['mensaje'],
        calificiacion: json['calificacion'],
        idTrabajo: json['idTrabajo']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mensaje': mensaje,
      'calificacion': calificiacion,
      'idTrabajo': idTrabajo
    };
  }
}
