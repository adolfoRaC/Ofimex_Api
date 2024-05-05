import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ofimex/theme/theme.dart';
import 'package:ofimex/widgets/messsage_field_box.dart';
import 'package:readmore/readmore.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Reseñas"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      flex: 3,
                      child: Text(
                        "4.2",
                        style: TextStyle(fontSize: 60),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Column(
                        children: [
                          RatingIndicator(text: "5", value: 0.8),
                          RatingIndicator(text: "4", value: 0.5),
                          RatingIndicator(text: "3", value: 0.45),
                          RatingIndicator(text: "2", value: 0.1),
                          RatingIndicator(text: "1", value: 0.2),
                        ],
                      ),
                    )
                  ],
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
                        ' 150 Reviews',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                const CardReview()
              ],
            ),
          ),
        ));
  }
}

class CardReview extends StatelessWidget {
  const CardReview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/perfil1.jpg"),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Rosa Martz",
                  style: TextStyle(fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            PopupMenuButton(
              itemBuilder: (value) => [
                const PopupMenuItem(child: Text("Imagenes")),
                const PopupMenuItem(child: Text("Caminos"))
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
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StarsReview(value: 4.5, size: 24),
            const Text("01 May 2023")
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        ReadMoreText(
          "Et aliquip culpa dolore in ut aliquip cupidatat fugiat aute nulla eu. Velit labore aute incididunt aliquip incididunt occaecat. Deserunt consequat est do amet amet qui irure proident. Duis elit minim velit ea. Do eiusmod sunt consectetur excepteur adipisicing ullamco enim elit officia esse. Anim in pariatur consequat minim veniam do id laboris. Et occaecat quis veniam aliquip dolor labore eiusmod Lorem.",
          trimLines: 1,
          trimExpandedText: ' Leer menos',
          trimCollapsedText: ' Leer más',
          moreStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppTheme().theme().primaryColor),
          lessStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppTheme().theme().primaryColor),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
              vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade300,
          ),
          child: Column(children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Julio Martinez"),
                Text("01 May 2024")
              ],
            ),
            const SizedBox(height: 10,),
            ReadMoreText(
              "Velit labore aute incididunt aliquip incididunt occaecat. Deserunt consequat est do amet amet qui irure proident.",
              trimLines: 2,
              trimExpandedText: ' Leer menos',
              trimCollapsedText: ' Leer más',
              moreStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme().theme().primaryColor),
              lessStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme().theme().primaryColor),
            ),
          ]),
        ),
        const SizedBox(
          height: 10,
        ),
        MessageFieldBox(onValue: (value) {}),
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
