class Rol {
  int? id;
  String nombre;

  Rol({
    this.id,
    required this.nombre,
  });

  factory Rol.getJson(Map<String, dynamic> json) {
    return Rol(
      id: json['id'],
      nombre: json['nombre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nombre': nombre};
  }
}
