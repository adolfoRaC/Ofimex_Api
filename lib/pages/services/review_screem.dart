import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ofimex/theme/theme.dart';
import 'package:ofimex/widgets/messsage_field_box.dart';
import 'package:readmore/readmore.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    bool isWeb = screenWidth > 500;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Reseñas"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                SizedBox(
                  width: isWeb ? 1000 : double.infinity,
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 3,
                        child: Text(
                          "4.3",
                          style: TextStyle(fontSize: 60),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Column(
                          children: [
                            RatingIndicator(text: "5", value: 0.0),
                            RatingIndicator(text: "4", value: 0.6),
                            RatingIndicator(text: "3", value: 0.3),
                            RatingIndicator(text: "2", value: 0.0),
                            RatingIndicator(text: "1", value: 0.0),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      StarsReview(
                        value: 4.2,
                        size: 24,
                      ),
                      Text(
                        ' 3 Reviews',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: isWeb ? 800 : double.infinity,
                  child: const Column(
                    children: [
                      CardReview(
                        image: "assets/perfil1.jpg",
                        rating: 4.5,
                        date: "01 May 2024",
                        name: "Rosa Martz",
                      ),
                      SizedBox(height: 15,),
                      CardReview(
                        image: "assets/perfil3.jpg",
                        rating: 4.0,
                        date: "15 Abr 2024",
                        name: "Carlos Rivera",
                      ),
                      SizedBox(height: 15,),

                      CardReview(
                        image: "assets/perfil2.jpg",
                        rating: 4.5,
                        date: "05 May 2024",
                        name: "Ana Gómez",
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ));
  }
}

class CardReview extends StatelessWidget {
  final String image; // Imagen de perfil
  final double rating; // Calificación de estrellas
  final String date; // Fecha de la revisión
  final String name;
  const CardReview({
    required this.image, // Ruta de la imagen
    required this.rating, // Calificación
    required this.date, // Fecha de la revisión
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      AssetImage(image), // Usar imagen proporcionada
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  name,
                  style: TextStyle(fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(child: Text("Imágenes")),
                const PopupMenuItem(child: Text("Caminos")),
              ],
              offset: const Offset(-20, 50),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StarsReview(
                value: rating, size: 24), // Usar el rating proporcionado
            Text(date), // Mostrar la fecha
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        ReadMoreText(
          "Et aliquip culpa dolore in ut aliquip cupidatat fugiat aute nulla eu. Velit labore aute incididunt aliquip occaecat.",
          trimLines: 1,
          trimExpandedText: ' Leer menos',
          trimCollapsedText: ' Leer más',
          moreStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor, // Usar el color primario
          ),
          lessStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade300,
          ),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Julio Sanchez"),
                  Text("01 May 2024"), // Fecha estática de ejemplo
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ReadMoreText(
                "Velit labore aute incididunt aliquip incididunt occaecat.",
                trimLines: 2,
                trimExpandedText: ' Leer menos',
                trimCollapsedText: ' Leer más',
                moreStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
                lessStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        // Ejemplo de campo de texto para mensajes
        MessageFieldBox(onValue: (value) {
          print("Mensaje recibido: $value");
        }),
      ],
    );
  }
}

class StarsReview extends StatelessWidget {
  double value;
  double size;
  StarsReview({
    required this.value,
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      initialRating: value,
      direction: Axis.horizontal,
      allowHalfRating: true,
      ignoreGestures: true,
      itemCount: 5,
      itemSize: size,
      ratingWidget: RatingWidget(
        full: Icon(
          Icons.star_rate_rounded,
          color: AppTheme().theme().primaryColor,
        ),
        half: Icon(
          Icons.star_half_rounded,
          color: AppTheme().theme().primaryColor,
        ),
        empty: Icon(
          Icons.star_border_rounded,
          color: AppTheme().theme().primaryColor,
        ),
      ),
      itemPadding: EdgeInsets.zero,
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}

class RatingIndicator extends StatelessWidget {
  String text;
  double value;
  RatingIndicator({super.key, required this.text, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(text)),
        Expanded(
          flex: 11,
          child: SizedBox(
            width: 50,
            child: LinearProgressIndicator(
              value: value,
              minHeight: 10,
              backgroundColor: Colors.grey.shade300,
              valueColor:
                  AlwaysStoppedAnimation(AppTheme().theme().primaryColor),
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        )
      ],
    );
  }
}
