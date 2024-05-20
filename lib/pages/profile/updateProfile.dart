import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:ofimex/models/usuario/responseAuth.dart';
import 'package:ofimex/models/usuario/usuario.dart';
import 'package:ofimex/provider/globales.dart';
import 'package:ofimex/services/services.dart';
import 'package:ofimex/theme/theme.dart';
import 'package:ofimex/widgets/InputTextFoemField.dart';
import 'package:provider/provider.dart';

class UpdateProfileScreen extends StatefulWidget {
  UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final txtNombreController = TextEditingController();
  final txtApePatController = TextEditingController();
  final txtApeMatController = TextEditingController();
  final txtCorreoController = TextEditingController();
  final txtUsuarioController = TextEditingController();
  final txtPasswordController = TextEditingController();

  bool isMaleSelected = false;
  bool isFemaleSelected = false;
  String gender = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final globales = context.watch<Globales>();
    txtNombreController.text = globales.usuario.nombre;
    txtApePatController.text = globales.usuario.apePat;
    txtApeMatController.text = globales.usuario.apeMat;
    txtUsuarioController.text = globales.usuario.usuario;
    txtCorreoController.text = globales.usuario.correo;

   

    double screenWidth = MediaQuery.of(context).size.width;
    bool isWeb = screenWidth > 500;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          "Editar perfil",
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: isWeb ? 500 : double.infinity,
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(globales.usuario.imagen!,fit: BoxFit.cover,),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppTheme().theme().primaryColor,
                        ),
                        child: const Icon(Icons.camera_alt,
                            color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Form(
                  child: Column(
                    children: [
                      InputTexFormtField(
                          label: "Nombre",
                          textController: txtNombreController,
                          icon: Icons.person,
                          inputType: TextInputType.text),
                      InputTexFormtField(
                          label: "Apellido Paterno",
                          textController: txtApePatController,
                          icon: Icons.person,
                          inputType: TextInputType.text),
                      InputTexFormtField(
                          label: "Apellido Materno",
                          textController: txtApeMatController,
                          icon: Icons.person,
                          inputType: TextInputType.text),
                      Row(
                        children: [
                          Checkbox(
                            value: isMaleSelected,
                            onChanged: onMaleChanged,
                          ),
                          const Text("Hombre"),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: isFemaleSelected,
                            onChanged: onFemaleChanged,
                          ),
                          const Text("Mujer"),
                        ],
                      ),
                      InputTexFormtField(
                          label: "Usuario",
                          textController: txtUsuarioController,
                          icon: Icons.person,
                          inputType: TextInputType.text),
                      InputTexFormtField(
                          label: "Correo",
                          textController: txtCorreoController,
                          icon: Icons.email,
                          inputType: TextInputType.emailAddress),
                      InputTexFormtField(
                        label: "Contraseña",
                        textController: txtPasswordController,
                        icon: Icons.password,
                        inputType: TextInputType.text,
                        obscureText: true,
                        esPwd: true,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            print("presión");
                            if (txtNombreController.text.isNotEmpty &&
                                txtApePatController.text.isNotEmpty &&
                                txtApeMatController.text.isNotEmpty &&
                                txtCorreoController.text.isNotEmpty &&
                                txtPasswordController.text.isNotEmpty &&
                                gender.isNotEmpty) {
                              Usuario user = Usuario(id: globales.usuario.id,nombre: txtNombreController.text, apePat: txtApePatController.text, apeMat: txtApeMatController.text, sexo: gender, correo: txtCorreoController.text, usuario: txtUsuarioController.text, pwd: txtPasswordController.text,imagen: globales.usuario.imagen, idRol: globales.usuario.idRol);
                              final ResponseAuth response = await actualizarUsuario(user);

                              if(response.codigo == 200){
                                mostrarDialogo(context, "Datos actualizados!!", Icons.check, Colors.green);
                              }
                            } else {
                              mostrarDialogo(context, "Llene todos los campos",
                                  Icons.warning, Colors.yellow);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                AppTheme().theme().primaryColor,
                            shape: const StadiumBorder(),
                          ),
                          child: const Text("Guardar cambios",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

 void onMaleChanged(bool? value) {
  setState(() {
    isMaleSelected = value ?? false;
    if (isMaleSelected) {
      isFemaleSelected = false;
      gender = "Masculino";
    } else {
      gender = ""; // Deseleccionar género si se desmarca el checkbox masculino
    }
  });
}

void onFemaleChanged(bool? value) {
  setState(() {
    isFemaleSelected = value ?? false;
    if (isFemaleSelected) {
      isMaleSelected = false;
      gender = "Femenino";
    } else {
      
      gender = ""; // Deseleccionar género si se desmarca el checkbox femenino
    }
  });
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
}
