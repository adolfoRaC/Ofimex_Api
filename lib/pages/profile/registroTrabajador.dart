import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ofimex/provider/globales.dart';
import 'package:ofimex/theme/theme.dart';
import 'package:ofimex/widgets/InputTextFoemField.dart';
import 'package:provider/provider.dart';

class RegistrarTrabajador extends StatefulWidget {
  const RegistrarTrabajador({super.key});

  @override
  State<RegistrarTrabajador> createState() => _RegistrarTrabajadorState();
}

class _RegistrarTrabajadorState extends State<RegistrarTrabajador> {
  final txtNombreController = TextEditingController();
  final txtApellidoPaternoController = TextEditingController();
  final txtApellidoMaternoController = TextEditingController();
  final txtEdadController = TextEditingController();
  final txtExperienciaController = TextEditingController();
  bool showSignUp = true;

  // File? imagen;
  @override
  Widget build(BuildContext context) {
    final globales = context.watch<Globales>();
    double screenWidth = MediaQuery.of(context).size.width;

    bool isWeb = screenWidth > 500;
    txtNombreController.text = globales.usuario.nombre;
    txtApellidoPaternoController.text = globales.usuario.apePat;
    txtApellidoMaternoController.text = globales.usuario.apeMat;
    txtEdadController.text = "23";
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Registro",
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
          width: isWeb ? 500:double.infinity,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // imagen == null
                //     ? const SizedBox(
                //         height: 200,
                //       )
                //     : const SizedBox(),
                // imagen == null
                //     ? const Text(
                //         "Ingrese una foto de su credencial",
                //         style: TextStyle(fontSize: 20),
                //       )
                //     : const SizedBox(),
                // imagen == null
                //     ? SizedBox(
                //         width: 200,
                //         height: 60,
                //         child: ElevatedButton(
                //           onPressed: () {
                //             SeleccionarImagenGaleria();
                //           },
                //           style: ElevatedButton.styleFrom(
                //             backgroundColor: AppTheme().theme().primaryColor,
                //             shape: const StadiumBorder(),
                //           ),
                //           child: const Text("Editar perfil",
                //               style: TextStyle(color: Colors.white)),
                //         ),
                //       )
                //     : form(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future SeleccionarImagenGaleria() async {
  //   final picture = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (picture == null) return;
  //   setState(() {
  //     imagen = File(picture.path);
  //   });
  // }

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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  mensaje,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,

                    
                  ),
                ),
              ),
            ),
            const Center(child: Icon(Icons.check,color: Colors.green,size: 60,),)
          ],
        ),
      );
    });
  }

  Widget form() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                "Verifique y Añada los datos restantes",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InputTexFormtField(
              label: "Nombre",
              textController: txtNombreController,
              inputType: TextInputType.emailAddress,
            ),
            InputTexFormtField(
              label: "Apellido paterno",
              textController: txtApellidoPaternoController,
              inputType: TextInputType.text,
            ),
            InputTexFormtField(
              label: "Apellido materno",
              textController: txtApellidoMaternoController,
              inputType: TextInputType.text,
            ),
            InputTexFormtField(
              label: "Edad",
              textController: txtEdadController,
              inputType: TextInputType.text,
            ),
            InputTexFormtField(
              label: "Años de experiencia",
              textController: txtExperienciaController,
              inputType: TextInputType.number,
            ),
            SizedBox(
              width: 400,
              height: 60,
              child: ElevatedButton(
                onPressed: () async {
                  SmartDialog.showLoading(msg: "Cargando...");
                  await Future.delayed(const Duration(seconds: 2));
                  SmartDialog.dismiss();
                  // ignore: use_build_context_synchronously
                  mostrarDialogo(context, "Felicidades tu registro se ha realizado con éxito");
                  await Future.delayed(const Duration(seconds: 2));
                  Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme().theme().primaryColor,
                  shape: const StadiumBorder(),
                ),
                child: const Text("Finalizar registro",
                    style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
