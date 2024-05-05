// ignore_for_file: public_member_api_docs, sort_constructors_first
class Trabajador {
  final String image;
  final double rating;
  final String name;
  final String location;
  Trabajador({
    required this.image,
    required this.rating,
    required this.name,
    required this.location
  });
}

List<Trabajador> trabajador= [
  Trabajador(
    image: "assets/fotoTrabajador/albañil.jpg",
    rating: 4.4,
    name: "Jorge Santos",
    location: "Teziutlan, Pue"
  ),
   Trabajador(
    image: "assets/fotoTrabajador/carpintero.jpg",
    rating: 4.8,
    name: "Felipe Romero",
    location: "Chignautla, Pue"
  ),
   Trabajador(
    image: "assets/fotoTrabajador/cerrajero.jpg",
    rating: 4.2,
    name: "Miguel Martinez",
    location: "Teziutlan, Pue"
  ),
   Trabajador(
    image: "assets/fotoTrabajador/electricista.jpg",
    rating: 4.6,
    name: "Julian Sanchez",
    location: "Chignautla, Pue"
  ),
   Trabajador(
    image: "assets/fotoTrabajador/jardinero.jpeg",
    rating: 4.3,
    name: "Pedro Santos",
    location: "Teziutlan, Pue"
  ),
 Trabajador(
    image: "assets/fotoTrabajador/plomero.jpeg",
    rating: 4.4,
    name: "Victor Cruz",
    location: "Teziutlan, Pue"
  ),
];
