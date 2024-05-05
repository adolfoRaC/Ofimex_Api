class TrabjadorListData {
  TrabjadorListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.dist = 1.8,
    this.reviews = 80,
    this.rating = 4.5,
    this.perNight = 180,
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  double dist;
  double rating;
  int reviews;
  int perNight;

  static List<TrabjadorListData> listTrabajador = <TrabjadorListData>[
    TrabjadorListData(
      imagePath: 'assets/fotoTrabajador/albañil.jpg',
      titleTxt: 'Jorge Santos',
      subTxt: 'Teziutlán, Puebla',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      perNight: 180,
    ),
    TrabjadorListData(
      imagePath: 'assets/fotoTrabajador/carpintero.jpg',
      titleTxt: 'Felipe Romero',
      subTxt: 'Chignautla, Puebla',
      dist: 4.0,
      reviews: 74,
      rating: 4.5,
      perNight: 200,
    ),
    TrabjadorListData(
      imagePath: 'assets/fotoTrabajador/cerrajero.jpg',
      titleTxt: 'Miguel Martinez',
      subTxt: 'Teziutlán, Puebla',
      dist: 3.0,
      reviews: 62,
      rating: 4.0,
      perNight: 60,
    ),
    TrabjadorListData(
      imagePath: 'assets/fotoTrabajador/electricista.jpg',
      titleTxt: 'Julian Sanchez',
      subTxt: 'Chignautla, Puebla',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      perNight: 170,
    ),
    TrabjadorListData(
      imagePath: 'assets/fotoTrabajador/jardinero.jpeg',
      titleTxt: 'Pedro Santos',
      subTxt: 'Teziutlán, Puebla',
      dist: 2.0,
      reviews: 240,
      rating: 4.5,
      perNight: 200,
    ),
    TrabjadorListData(
      imagePath: 'assets/fotoTrabajador/plomero.jpeg',
      titleTxt: 'Victor Cruz',
      subTxt: 'Teziutlán, Puebla',
      dist: 2.0,
      reviews: 240,
      rating: 4.5,
      perNight: 200,
    ),
  ];
}
