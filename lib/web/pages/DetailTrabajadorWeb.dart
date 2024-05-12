import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ofimex/models/trabajador_list_data.dart';
import 'package:ofimex/theme/theme.dart';
import 'package:ofimex/widgets/InputTextFoemField.dart';
import 'package:ofimex/widgets/listButtons.dart';
import 'package:readmore/readmore.dart';
import 'package:rive/rive.dart';
import 'package:text_area/text_area.dart';

class DetailTrabajadorWeb extends StatefulWidget {
  const DetailTrabajadorWeb({
    super.key,
  });

  @override
  State<DetailTrabajadorWeb> createState() => _DetailTrabajadorWebState();
}

class _DetailTrabajadorWebState extends State<DetailTrabajadorWeb> {
  int gottenStarts = 4;
  int selectedIndex = -1;
  final txtDescripcionController = TextEditingController();
  final txtCostoController = TextEditingController();

  var reasonValidation = true;
  //Dirección

  final txtMunicipioController = TextEditingController();
  final txtColoniaController = TextEditingController();
  final txtCalleController =TextEditingController();
  final txtCPController = TextEditingController();
  final txtNumeroExtController = TextEditingController();
  final txtNumeroIntController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    txtCostoController.text = "0";
    final  TrabjadorListData trabajador =
        ModalRoute.of(context)!.settings.arguments as TrabjadorListData;
    return Scaffold(
      body: SizedBox(
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
                          .pushNamedAndRemoveUntil("/home", (route) => false);
                    },
                    icon: const Icon(Ionicons.arrow_back),
                    color: const Color.fromARGB(255, 255, 255, 255),
                  )
                ],
              ),
            ),
            Positioned(
              top: 70,
              bottom: 10,
              child: Container(
                padding: const EdgeInsets.only(left: 100, right: 100, top: 30),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                                width: 120,
                                height: 120,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child:  Image(
                                      image: AssetImage(
                                          trabajador.imagePath)), 
                                ),
                              ),
                          Text(
                            trabajador.titleTxt,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700,
                                fontSize: 25),
                          ),
                          SizedBox(width: 30,),
                          Text(
                            "${trabajador.servicio}",
                            style: TextStyle(
                                color: AppTheme().theme().primaryColor.withOpacity(0.8),
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
                          Wrap(children: [
                            StarsReview(value: trabajador.rating, size: 24)
                          ]),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "(${trabajador!.rating})",
                            style: TextStyle(fontSize: 18),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed("/review");
                              },
                              child: Text("Ver reseñas"))
                        ],
                      ),                      const SizedBox(height: 25),

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
                      Center(
                        child: SizedBox(
                          width: 500,
                          child: BannerCarousel(
                            // disableColor: Colors.white,
                            
                            banners: [
                              BannerModel(
                                  imagePath: "assets/evidencia/evi1.jpeg", id: "1"),
                              BannerModel(
                                  imagePath: "assets/evidencia/evi2.jpg", id: "2"),
                              BannerModel(
                                  imagePath: "assets/evidencia/evi4.jpeg", id: "3"),
                            ],
                            onTap: (value){
                              show(value);
                            },
                            borderRadius: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      // Text(
                      //   "Chalanes",
                      //   style: TextStyle(
                      //       color: Colors.black.withOpacity(0.8),
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.w600),
                      // ),
                      // const SizedBox(height: 5),
                      // const Text(
                      //   "Seleccione si requiere chalanes",
                      //   style: TextStyle(
                      //     color: Colors.black54,
                      //   ),
                      // ),
                      // const SizedBox(height: 10),
                      // Wrap(
                      //   children: List.generate(5, (index) {
                      //     return InkWell(
                      //       onTap: () {
                      //         setState(() {
                      //           selectedIndex = index;
                      //         });
                      //       },
                      //       child: Container(
                      //         margin:
                      //             const EdgeInsets.only(right: 10, bottom: 10),
                      //         child: ListButtons(
                      //           color: selectedIndex == index
                      //               ? Colors.white
                      //               : Colors.black,
                      //           size: 50,
                      //           backgroundColor: selectedIndex == index
                      //               ? Colors.black
                      //               : Colors.grey.shade200,
                      //           borderColor: selectedIndex == index
                      //               ? Colors.black
                      //               : Colors.grey.shade200,
                      //           text: index.toString(),
                      //           // icon: Ionicons.heart_outline,
                      //           // isIcon: true,
                      //         ),
                      //       ),
                      //     );
                      //   }),
                      // ),
                      
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
        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 100),
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
                onPressed: ()  async{
                 SmartDialog.showLoading(msg: "Cargando...");
                  await Future.delayed(const Duration(seconds: 2));
                  SmartDialog.dismiss();
                  // ignore: use_build_context_synchronously
                  solicitarContratacion(context, "Formulario de contratación");
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
  
   void show(String text) async {
    SmartDialog.show(builder: (_) {
      return Container(
        height: 80,
        width: 180,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child:  Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      );
    });
  }
  
  solicitarContratacion(BuildContext context, String mensaje) {
    SmartDialog.show(builder: (_) {
      return Container(
        height: 420,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                mensaje,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Descripción del trabajo",
                  style: TextStyle(fontWeight: FontWeight.w600)),
              TextArea(
                borderRadius: 10,
                borderColor: const Color(0xFFCFD6FF),
                textEditingController: txtDescripcionController,
                suffixIcon: Icons.attach_file_rounded,
                onSuffixIconPressed: () => {},
                validation: reasonValidation,
                errorText: 'No puede dejar el campo vacío!',
              ),
              const SizedBox(height: 15),
              const Text(
                "Costo total",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              InputTexFormtField(
                  label: "Costo",
                  textController: txtCostoController,
                  icon: Icons.money_rounded,
                  inputType: TextInputType.number),
              ElevatedButton(
                onPressed: () async {
                  SmartDialog.dismiss();
                  SmartDialog.showLoading(msg: "Cargando...");
                  await Future.delayed(const Duration(seconds: 2));
                  SmartDialog.dismiss();
                  agregarDireccion(context, "Dirección");
                },
                child: const Text('Siguiente'),
              ),
            ],
          ),
        ),
      );
    });
  }
  agregarDireccion(BuildContext context, String mensaje) {
  SmartDialog.show(builder: (_) {
    return Container(
      height: 620,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              mensaje,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            InputTexFormtField(label: "Municipio", textController: txtMunicipioController, inputType: TextInputType.text),
            InputTexFormtField(label: "Colonia", textController: txtColoniaController, inputType: TextInputType.text),
            InputTexFormtField(label: "Calle", textController: txtCalleController, inputType: TextInputType.text),
            InputTexFormtField(label: "CP", textController: txtCPController, inputType: TextInputType.text),
            InputTexFormtField(label: "Núm. Ext", textController: txtNumeroExtController, inputType: TextInputType.text),
            InputTexFormtField(label: "Núm. Interior (Opcional)", textController: txtNumeroIntController, inputType: TextInputType.text),

            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: ()async {
                SmartDialog.dismiss();
                  SmartDialog.showLoading(msg: "Cargando...");
                  await Future.delayed(const Duration(seconds: 2));
                  SmartDialog.dismiss();
                  // ignore: use_build_context_synchronously
                  mostrarDialogo(context, "Solicitud enviada");
               
              },
              child: const Text('Finalizar'),
            ),
          ],
        ),
      ),
    );
  });
}
}

mostrarDialogo(BuildContext context, String mensaje) {
    SmartDialog.show(builder: (_) {
      return Container(
        height: 200,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              mensaje,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                SmartDialog.dismiss();
              },
              child: const Text('Cerrar'),
            ),
          ],
        ),
      );
    });
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
