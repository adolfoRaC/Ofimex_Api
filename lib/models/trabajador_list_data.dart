class TrabjadorListData {
  TrabjadorListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.servicio="",
    this.reviews = 0,
    this.rating = 0,

  });

  String imagePath;
  String titleTxt;
  String subTxt;
  String servicio;
  double rating;
  int reviews;


  static List<TrabjadorListData> listTrabajador = <TrabjadorListData>[
    TrabjadorListData(
      imagePath: 'assets/fotoTrabajador/albañil.jpg',
      titleTxt: 'Jorge Santos',
      subTxt: 'Teziutlán, Puebla',
      servicio: 'Albañil',
      reviews: 2,
      rating: 4.4,

    ),
    
    
    TrabjadorListData(
      imagePath: 'assets/fotoTrabajador/electricista.jpg',
      titleTxt: 'Julian Sanchez',
      subTxt: 'Chignautla, Puebla',
      servicio: 'Electricista',
      reviews: 1,
      rating: 4.3,
      
    ),
    
    TrabjadorListData(
      imagePath: 'assets/fotoTrabajador/plomero.jpeg',
      titleTxt: 'Victor Cruz',
      subTxt: 'Teziutlán, Puebla',
      servicio: 'Plomero',
      reviews: 1,
      rating: 4.5,
      
    ),
  ];
}
