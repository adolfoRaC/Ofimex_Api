import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ofimex/models/trabajador_list_data.dart';
import 'package:ofimex/theme/theme.dart';
import 'package:ofimex/widgets/listButtons.dart';
import 'package:readmore/readmore.dart';
import 'package:rive/rive.dart';

class DetailServicio extends StatefulWidget {
  const DetailServicio({
    super.key,
  });

  @override
  State<DetailServicio> createState() => _DetailServicioState();
}

class _DetailServicioState extends State<DetailServicio> {
  int gottenStarts = 4;
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    final TrabjadorListData trabajador =
        ModalRoute.of(context)!.settings.arguments as TrabjadorListData;
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(trabajador.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 30,
              left: 10,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("/nav", (route) => false);
                    },
                    icon: const Icon(Ionicons.arrow_back),
                    color: const Color.fromARGB(255, 255, 255, 255),
                  )
                ],
              ),
            ),
            Positioned(
              top: 260,
              child: Container(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
                width: MediaQuery.of(context).size.width,
                height: 400,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            trabajador.titleTxt,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700,
                                fontSize: 25),
                          ),
                          Text(
                            "\$${trabajador.perNight}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 23),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        children: [
                          Icon(
                            Ionicons.location,
                            color: Colors.black54,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Teziutlán, Puebla"),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Wrap(
                            children: List.generate(5, (index) {
                              return Icon(
                                Ionicons.star,
                                color: index < gottenStarts
                                    ? Colors.amber
                                    : Colors.grey[300],
                              );
                            }),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "(5.0)",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      const SizedBox(height: 25),

                      Text(
                        "Trabajos realizados",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BannerCarousel.fullScreen(
                        // disableColor: Colors.white,
                        
                        banners: [
                          BannerModel(
                              imagePath: "assets/places/place1.jpg", id: "1"),
                          BannerModel(
                              imagePath: "assets/places/place2.jpg", id: "2"),
                          BannerModel(
                              imagePath: "assets/places/place3.jpg", id: "3"),
                        ],
                        onTap: (value){
                          
                        },
                        borderRadius: 20,
                      ),
                      const SizedBox(height: 25),
                      Text(
                        "Chalanes",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Seleccione si requiere chalanes",
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        children: List.generate(5, (index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.only(right: 10, bottom: 10),
                              child: ListButtons(
                                color: selectedIndex == index
                                    ? Colors.white
                                    : Colors.black,
                                size: 50,
                                backgroundColor: selectedIndex == index
                                    ? Colors.black
                                    : Colors.grey.shade200,
                                borderColor: selectedIndex == index
                                    ? Colors.black
                                    : Colors.grey.shade200,
                                text: index.toString(),
                                // icon: Ionicons.heart_outline,
                                // isIcon: true,
                              ),
                            ),
                          );
                        }),
                      ),
                      
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Descripción",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
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
                    ],
                  ),
                ),
              ),
            ),
            // Positioned(
            //   left: 20,
            //   bottom: 20,
            //   child: Row(
            //     children: [
            //       ListButtons(
            //         color: Colors.grey,
            //         backgroundColor: Colors.white,
            //         borderColor: Colors.grey,
            //         size: 50,
            //         isIcon: true,
            //         icon: Ionicons.heart_outline,
            //       ),
            //       MaterialButton(
            //         onPressed: () {
            //           Navigator.of(context).pushNamed("/pago");
            //         },
            //         child: Container(
            //           width: 250,
            //           height: 50,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(20),
            //               color: AppTheme().theme().primaryColor,),
            //           child: const Center(
            //               child: Text(
            //             "Comprar",
            //             style: TextStyle(color: Colors.white),
            //           )),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListButtons(
              color: Colors.grey,
              backgroundColor: Colors.white,
              borderColor: Colors.grey,
              size: 50,
              isIcon: true,
              icon: Ionicons.heart_outline,
            ),
            Expanded(
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/pago");
                },
                child: Container(
                  // width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppTheme().theme().primaryColor,
                  ),
                  child: const Center(
                      child: Text(
                    "Contratar",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
