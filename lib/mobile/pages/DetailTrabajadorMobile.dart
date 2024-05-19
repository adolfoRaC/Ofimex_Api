import 'dart:ffi';

import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ofimex/models/usuario/direccion.dart';

import 'package:ofimex/models/usuario/trabajador.dart';
import 'package:ofimex/models/usuario/trabajo.dart';
import 'package:ofimex/provider/globales.dart';
import 'package:ofimex/services/services.dart';
import 'package:ofimex/theme/theme.dart';
import 'package:ofimex/widgets/InputTextFoemField.dart';
import 'package:ofimex/widgets/listButtons.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import 'package:text_area/text_area.dart';

class DetailTrabajadorMobile extends StatefulWidget {
  const DetailTrabajadorMobile({
    super.key,
  });

  @override
  State<DetailTrabajadorMobile> createState() => _DetailTrabajadorMobileState();
}

class _DetailTrabajadorMobileState extends State<DetailTrabajadorMobile> {
  int gottenStarts = 4;
  int selectedIndex = -1;
  //Descripción del trabajo
  final txtDescripcionController = TextEditingController();

  var reasonValidation = true;
  //Dirección

  final txtMunicipioController = TextEditingController();
  final txtColoniaController = TextEditingController();
  final txtCalleController = TextEditingController();
  final txtCPController = TextEditingController();
  final txtNumeroExtController = TextEditingController();
  final txtNumeroIntController = TextEditingController();

  int? idUsuario = 0;
  int? idTrabajador = 0;
  int idOficio = 0;
  int idTrabajo = 0;

  double latitud = 0.0;
  double longitud = 0.0;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  // Function to get the location
  void _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      latitud = position.latitude;
      longitud = position.longitude;

      print(position.latitude);
      print(position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Trabajador trabajador =
        ModalRoute.of(context)!.settings.arguments as Trabajador;
    final globales = context.watch<Globales>();

    idUsuario = globales.usuario.id;
    idOficio = trabajador.usuario!.oficio![0].idOficio;
    idTrabajador = trabajador.id;
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
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/person.png"),
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
                    color: Color.fromARGB(255, 0, 0, 0),
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
                            "${trabajador.usuario!.nombre} ${trabajador.usuario!.apePat} ${trabajador.usuario!.apeMat}",
                            style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700,
                                fontSize: 25),
                          ),
                        ],
                      ),
                      Text(
                        "${trabajador.usuario!.oficio![0].oficio!.nombre}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppTheme().theme().primaryColor, ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.certificate,
                            color: AppTheme().theme().primaryColor,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text("${trabajador.experiencia} años de experiencia"),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Wrap(children: [StarsReview(value: 5, size: 24)]),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "(5)",
                            style: TextStyle(fontSize: 18),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed("/review");
                              },
                              child: const Text("Ver reseñas"))
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
                              imagePath: "assets/evidencia/evi1.jpeg", id: "1"),
                          BannerModel(
                              imagePath: "assets/evidencia/evi2.jpg", id: "2"),
                          BannerModel(
                              imagePath: "assets/evidencia/evi4.jpeg", id: "3"),
                        ],
                        onTap: (value) {},
                        borderRadius: 20,
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
                onPressed: () async {
                  // Navigator.of(context).pushNamed("/pago");
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
              ElevatedButton(
                onPressed: () async {
                  SmartDialog.dismiss();
                  SmartDialog.showLoading(msg: "Cargando...");
                  if (txtDescripcionController.text.isNotEmpty) {
                    await Future.delayed(const Duration(seconds: 2));
                    // ignore: use_build_context_synchronously
                    agregarDireccion(context, "Agrega tu dirección");
                  } else {
                    mostrarDialogo(context, "Ingresa una descripción",
                        Icons.warning, Colors.yellow);
                    await Future.delayed(const Duration(seconds: 2));
                    SmartDialog.dismiss();
                  }
                  SmartDialog.dismiss();
                  // await Future.delayed(const Duration(seconds: 2));
                  // agregarDireccion(context, "Dirección");
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
              InputTexFormtField(
                  label: "Municipio*",
                  textController: txtMunicipioController,
                  inputType: TextInputType.text),
              InputTexFormtField(
                  label: "Colonia*",
                  textController: txtColoniaController,
                  inputType: TextInputType.text),
              InputTexFormtField(
                  label: "Calle*",
                  textController: txtCalleController,
                  inputType: TextInputType.text),
              InputTexFormtField(
                  label: "CP*",
                  textController: txtCPController,
                  inputType: TextInputType.number),
              InputTexFormtField(
                  label: "Núm. Ext*",
                  textController: txtNumeroExtController,
                  inputType: TextInputType.number),
              InputTexFormtField(
                  label: "Núm. Interior (Opcional)",
                  textController: txtNumeroIntController,
                  inputType: TextInputType.number),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  SmartDialog.showLoading(msg: "Cargando...");
                  final trabajo = Trabajo(
                      descripcion: txtDescripcionController.text,
                      costoTotal: 0,
                      idUsuario: idUsuario!,
                      idTrabajador: idTrabajador!,
                      idOficio: idOficio);
                  final response = await contratarTrabajador(trabajo);
                  idTrabajo = response.trabajo!.id!;

                  if (response.codigo == 200) {
                    if (txtMunicipioController.text.isNotEmpty &&
                        txtColoniaController.text.isNotEmpty &&
                        txtCalleController.text.isNotEmpty &&
                        txtCPController.text.isNotEmpty &&
                        txtNumeroExtController.text.isNotEmpty) {
                      if (txtNumeroIntController.text.isEmpty) {
                        txtNumeroIntController.text = "N/A";
                      }
                      final address = Direccion(
                          latitud: 10 ,
                          longitud: 10,
                          municipio: txtMunicipioController.text,
                          colonia: txtColoniaController.text,
                          calle: txtCalleController.text,
                          cp: int.parse(txtCPController.text),
                          numeroExt: int.parse(txtNumeroExtController.text),
                          descripcion: txtNumeroIntController.text,
                          idTrabajo: idTrabajo);
                      final resp = await agregarDireccionTrabajo(address);
                      if (resp.codigo == 200) {
                        SmartDialog.dismiss();
                        // ignore: use_build_context_synchronously
                        mostrarDialogo(context, "Solicitud enviada",
                            Icons.check, Colors.green);
                        await Future.delayed(const Duration(seconds: 2));
                        SmartDialog.dismiss();
                      } else {
                        SmartDialog.dismiss();

                        // ignore: use_build_context_synchronously
                        mostrarDialogo(context, "Error en la dirección",
                            Icons.close, Colors.red);
                      }
                    } else {
                      SmartDialog.dismiss();

                      // ignore: use_build_context_synchronously
                      mostrarDialogo(context, "Llene los campos requeridos",
                          Icons.warning, Colors.yellow.shade600);
                    }
                  } else {
                    // SmartDialog.dismiss();

                    // ignore: use_build_context_synchronously
                    mostrarDialogo(
                        context,
                        "Error al contratar: ${response.mensaje} ",
                        Icons.cancel_outlined,
                        Colors.red);
                    await Future.delayed(const Duration(seconds: 2));
                    SmartDialog.dismiss();
                  }
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

mostrarDialogo(
    BuildContext context, String mensaje, IconData icon, Color color) {
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
          Center(
            child: Icon(
              icon,
              color: color,
              size: 60,
            ),
          )
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
