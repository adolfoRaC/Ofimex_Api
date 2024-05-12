class Trabajador {
 int? id;
 int edad;
 int experiencia;
 int? trabajos;
 bool? disponible;
 DateTime? membresia;
 int idUsuario;

  Trabajador({
    this.id,
    required this.edad,
    required this.experiencia,
    this.trabajos,
    this.disponible,
    this.membresia,
    required this.idUsuario,

  });

  factory Trabajador.getJson(Map json){
    return Trabajador(id: json['id'], edad: json['edad'], experiencia: json['experiencia'], trabajos: json['trabajos'],disponible: json['disponible'], membresia: json['membresia'], idUsuario: json['idUsuario']);
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'edad': edad,
      'experiencia': experiencia,
      'trabajos': trabajos,
      'disponible': disponible,
      'membresia': membresia,
      'idUsuario': idUsuario
    };
  }
}
