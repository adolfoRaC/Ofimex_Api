import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ofimex/models/usuario/oficio.dart';
import 'package:ofimex/models/usuario/oficoTrabajo.dart';
import 'package:ofimex/models/usuario/responseAuth.dart';
import 'package:ofimex/models/usuario/trabajador.dart';
import 'package:ofimex/provider/globales.dart';
import 'package:ofimex/services/services.dart';
import 'package:ofimex/theme/theme.dart';
import 'package:ofimex/widgets/InputTextFoemField.dart';
import 'package:provider/provider.dart';

class RegistrarTrabajador extends StatefulWidget {
  const RegistrarTrabajador({super.key});

  @override
  State<RegistrarTrabajador> createState() => _RegistrarTrabajadorState();
}

class _RegistrarTrabajadorState extends State<RegistrarTrabajador> {
  late Future<List<Oficio>> _oficio;
  late List<OficioTrabajo> _oficiosSeleccionados = [];
  late Map<int, bool> _selectedOficios = {};
  @override
  void initState() {
    super.initState();
    _oficio = getOficios();
  }

  final txtNombreController = TextEditingController();
  final txtApellidoPaternoController = TextEditingController();
  final txtApellidoMaternoController = TextEditingController();
  final txtEdadController = TextEditingController();
  final txtExperienciaController = TextEditingController();
  bool showForm = false;
  bool _checked = false;

  int? idUsuario = 0;
  String nombre = "";
  String apePat = "";
  String apeMat = "";
  // File? imagen;
  @override
  Widget build(BuildContext context) {
    final globales = context.watch<Globales>();
    idUsuario = globales.usuario.id;
    nombre = globales.usuario.nombre;
    apePat = globales.usuario.apePat;
    apeMat = globales.usuario.apeMat;
    double screenWidth = MediaQuery.of(context).size.width;

    bool isWeb = screenWidth > 500;
    txtNombreController.text = globales.usuario.nombre;
    txtApellidoPaternoController.text = globales.usuario.apePat;
    txtApellidoMaternoController.text = globales.usuario.apeMat;
    // txtEdadController.text = "23";
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Registro",
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(child: showForm ? formOficios() : form()),
    );
  }

  // Future SeleccionarImagenGaleria() async {
  //   final picture = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (picture == null) return;
  //   setState(() {
  //     imagen = File(picture.path);
  //   });
  // }

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
              icon: Icons.person,
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
              inputType: TextInputType.number,
              icon: Icons.onetwothree,
            ),
            InputTexFormtField(
                label: "Años de experiencia",
                textController: txtExperienciaController,
                inputType: TextInputType.number,
                icon: Icons.line_axis_sharp),
            SizedBox(
              width: 400,
              height: 60,
              child: ElevatedButton(
                onPressed: () async {
                  if (txtNombreController.text.isNotEmpty &&
                      txtApellidoPaternoController.text.isNotEmpty &&
                      txtApellidoMaternoController.text.isNotEmpty &&
                      txtEdadController.text.isNotEmpty &&
                      txtExperienciaController.text.isNotEmpty) {
                    setState(() {
                      showForm = !showForm;
                    });
                    SmartDialog.showLoading(msg: "Cargando...");
                    await Future.delayed(const Duration(seconds: 1));
                    SmartDialog.dismiss();
                  } else {
                    mostrarDialogo(
                        context,
                        "Llena todo los campos para avanzar",
                        Icons.cancel_outlined,
                        Colors.red);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme().theme().primaryColor,
                  shape: const StadiumBorder(),
                ),
                child: const Text("Siguiente",
                    style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget formOficios() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            height: 60,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              "Selecciona los oficios",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // Verifica que los widgets hijos estén configurados correctamente
          FutureBuilder<List<Oficio>>(
            future: _oficio,
            builder:
                (BuildContext context, AsyncSnapshot<List<Oficio>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap:
                      true, // Añadido para evitar problemas de desplazamiento
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final oficio = snapshot.data![index];
                    final isSelected = _selectedOficios[oficio.id] ??
                        false; // Paso 3: Obtener el estado del checkbox
                    return CheckboxListTile(
                      title: Text(oficio.nombre),
                      value: isSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          _selectedOficios[oficio.id] = value ??
                              false; // Paso 2: Actualizar el estado del checkbox
                          if (value != null && value) {
                            _oficiosSeleccionados.add(OficioTrabajo(
                              idOficio: oficio.id,
                              idTrabajador: idUsuario!,
                            ));
                          } else {
                            _oficiosSeleccionados.removeWhere(
                                (element) => element.idOficio == oficio.id);
                          }
                        });
                      },
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text("No hay oficios"),
                );
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 400,
            height: 60,
            child: ElevatedButton(
              onPressed: () async {
                if (_oficiosSeleccionados.length > 0) {
                  final trabajador = Trabajador(
                      edad: int.parse(txtEdadController.text),
                      experiencia: int.parse(txtExperienciaController.text),
                      idUsuario: idUsuario!);
                  SmartDialog.showLoading(msg: "Registrando trabajador...");
                  final ResponseAuth responseRegistrabajdor =
                      await registrarTrabajador(
                          trabajador, idUsuario!, nombre, apePat, apeMat);
                  if (responseRegistrabajdor.codigo == 200) {
                    // final ofi = OficioTrabajo( idUsuario: idUsuario!,idOficio: 1,);
                    final responseOficioTrabajador =
                        await registrarOficioTrabajador(_oficiosSeleccionados);

                    if (responseOficioTrabajador.codigo == 200) {
                      SmartDialog.dismiss();
                      // ignore: use_build_context_synchronously
                      mostrarDialogo(context, responseOficioTrabajador.mensaje,
                          Icons.check, Colors.green);
                      await Future.delayed(const Duration(seconds: 2));
                      // ignore: use_build_context_synchronously
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("/home", (route) => false);
                    } else {
                      SmartDialog.dismiss();

                      // ignore: use_build_context_synchronously
                      mostrarDialogo(context, responseOficioTrabajador.mensaje,
                          Icons.cancel_outlined, Colors.red);
                    }
                  } else {
                    SmartDialog.dismiss();

                    mostrarDialogo(context, responseRegistrabajdor.mensaje,
                        Icons.cancel, Colors.red);
                  }
                }

                // Imprimir los oficios seleccionados
                // print('Oficios seleccionados:');
                // for (var oficio in _oficiosSeleccionados) {
                //   print(
                //       'ID: ${oficio.idOficio}, ID Usuario: ${oficio.idUsuario}');
                // }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme().theme().primaryColor,
                shape: const StadiumBorder(),
              ),
              child: const Text("Finalizar registro",
                  style: TextStyle(color: Colors.white)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 400,
            height: 60,
            child: ElevatedButton(
              onPressed: () async {
                setState(() {
                  showForm = false;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: const StadiumBorder(),
              ),
              child:
                  const Text("Regresar", style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
