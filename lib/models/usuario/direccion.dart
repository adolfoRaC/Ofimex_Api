
class Direccion {
  int? id;
  double latitud;
  double longitud;
  String municipio;
  String colonia;
  String calle;
  int cp;
  int numeroExt;
  String descripcion;
  int idTrabajo;

  Direccion({
    this.id,
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

  factory Direccion.getJson(Map<String, dynamic> json) {
    return Direccion(
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latitud': latitud,
      'longitud': longitud,
      'municipio': municipio,
      'colonia': colonia,
      'calle': calle,
      'cp': cp,
      'numeroExt': numeroExt,
      'descripcion': descripcion,
      'idTrabajo': idTrabajo
    };
  }
}
