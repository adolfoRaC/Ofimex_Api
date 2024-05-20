import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:ofimex/models/usuario/trabajador.dart';

import 'package:ofimex/theme/hotel_app_theme.dart';
import 'package:ofimex/theme/theme.dart';

class TrabajadorListView extends StatelessWidget {
  const TrabajadorListView({
    Key? key,
    this.trabajadorData,
    this.animationController,
    this.animation,
    this.callback,
  }) : super(key: key);

  final VoidCallback? callback;
  final Trabajador? trabajadorData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return animation != null && animationController != null
        ? AnimatedBuilder(
            animation: animationController!,
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                opacity: animation!,
                child: Transform(
                  transform: Matrix4.translationValues(
                    0.0,
                    50 * (1.0 - animation!.value),
                    0.0,
                  ),
                  child: _buildContent(context),
                ),
              );
            },
          )
        : _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: callback,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                offset: const Offset(4, 4),
                blurRadius: 16,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 2,
                      child: Image.network(trabajadorData!.usuario!.imagen!, fit: BoxFit.cover,),
                    ),
                    Container(
                      color: HotelAppTheme.buildLightTheme().backgroundColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, top: 8, bottom: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "${trabajadorData!.usuario!.nombre} ${trabajadorData!.usuario!.apePat} ${trabajadorData!.usuario!.apeMat} ",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.work,
                                        size: 12,
                                        color: AppTheme().theme().primaryColor,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: SizedBox(
                                          height:
                                              24, // Establecer una altura específica para el ListView
                                          child: ListView.builder(
                                            scrollDirection: Axis
                                                .horizontal, // Establecer dirección horizontal
                                            itemCount: trabajadorData!
                                                .usuario!.oficio!.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right:
                                                        8.0), // Espaciado entre elementos
                                                child: Text(
                                                  "${trabajadorData!.usuario!.oficio![index].oficio!.nombre}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: AppTheme()
                                                        .theme()
                                                        .primaryColor
                                                        .withOpacity(0.8),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.workspace_premium_outlined,
                                        size: 12,
                                        color: AppTheme().theme().primaryColor,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${trabajadorData!.experiencia} años de experiencia",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.withOpacity(0.8),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Row(
                                      children: <Widget>[
                                        RatingBar(
                                          initialRating: 5,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          ignoreGestures: true,
                                          itemCount: 5,
                                          itemSize: 24,
                                          ratingWidget: RatingWidget(
                                            full: Icon(
                                              Icons.star_rate_rounded,
                                              color: AppTheme()
                                                  .theme()
                                                  .primaryColor,
                                            ),
                                            half: Icon(
                                              Icons.star_half_rounded,
                                              color: AppTheme()
                                                  .theme()
                                                  .primaryColor,
                                            ),
                                            empty: Icon(
                                              Icons.star_border_rounded,
                                              color: AppTheme()
                                                  .theme()
                                                  .primaryColor,
                                            ),
                                          ),
                                          itemPadding: EdgeInsets.zero,
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        Text(
                                          '0 Reseñas',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.withOpacity(0.8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
