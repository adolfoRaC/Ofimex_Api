class Oficio {
  int id;
  String nombre;

  Oficio({
    required this.id,
    required this.nombre,
  });

  factory Oficio.getJson(Map json) {
    return Oficio(
      id: json['id'],
      nombre: json['nombre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
    };
  }
}
