// ignore_for_file: public_member_api_docs, sort_constructors_first
class ServicioIconModel {
  final String name;
  final String image;
  bool isSelected;
  ServicioIconModel(this.isSelected, {
    required this.name,
    required this.image,
  });
}

List<ServicioIconModel> typeServices = [
  ServicioIconModel(name: "Todo", image: "assets/servicios/icons/all.png", true),
  ServicioIconModel(name: "Albañil", image: "assets/servicios/icons/albanil.png",false),
  ServicioIconModel(name: "Plomero", image: "assets/servicios/icons/plomero.png",false),
  ServicioIconModel(name: "Electricista", image: "assets/servicios/icons/electrico.png",false),
  ServicioIconModel(name: "Carpintero", image: "assets/servicios/icons/carpintero.png",false),
  ServicioIconModel(name: "Pintor", image: "assets/servicios/icons/pintor.png",false),
  ServicioIconModel(name: "Herrero", image: "assets/servicios/icons/herrero.png",false),
];
