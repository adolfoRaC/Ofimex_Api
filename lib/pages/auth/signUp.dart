// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:ofimex/models/usuario/responseAuth.dart';
import 'package:ofimex/models/usuario/usuario.dart';
import 'package:ofimex/pages/auth/login.dart';
import 'package:ofimex/services/services.dart';
import 'package:ofimex/theme/theme.dart';
import 'package:ofimex/widgets/InputTextFoemField.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final txtCorreoController = TextEditingController();
  final txtPwdController = TextEditingController();
  final txtPwdConfirmController = TextEditingController();
  final txtUsuarioController = TextEditingController();
  final txtNombreCompletoController = TextEditingController();

  bool showSignUp = true;
  bool isMaleSelected = false;
  bool isFemaleSelected = false;

  String gender = "";

  void onMaleChanged(bool? value) {
    setState(() {
      isMaleSelected = value ?? false;
      if (isMaleSelected) {
        isFemaleSelected = false;
        gender = "Hombre";
      }
    });
  }

  void onFemaleChanged(bool? value) {
    setState(() {
      isFemaleSelected = value ?? false;
      if (isFemaleSelected) {
        isMaleSelected = false;
        gender = "Mujer";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final correo = txtCorreoController.text;
    final pwd = txtPwdController.text;
    final pwdConfirm = txtPwdConfirmController.text;
    final nombre = txtNombreCompletoController.text;
    final usuario = txtUsuarioController.text;
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWeb = screenWidth > 500;
    double responsiveWidth = isWeb ? 500 : double.infinity;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        // brightness: Brightness.light,
        backgroundColor: Colors.white,
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     icon: const Icon(
        //       Icons.arrow_back_ios,
        //       size: 20,
        //       color: Colors.black,
        //     )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height - 50,
              width: responsiveWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      FadeInUp(
                        // duration: const Duration(microseconds: 50000),
                        child: const Text(
                          "Registrarse",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FadeInUp(
                        //  duration: const Duration(microseconds: 1200),
                        child: Text(
                          "Crear una cuenta en OFIMEX es gratis",
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      if (showSignUp) FadeInUp(child: _buildSignUpForm()),
                      if (!showSignUp) FadeInUp(child: _buildOtherForm()),
                    ],
                  ),
                  showSignUp
                      ? FadeInUp(
                          //  duration: const Duration(microseconds: 1500),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () {
                              // print(correo);
                              // print(pwd);
                              // print(pwdConfirm);

                              if (correo.isNotEmpty &&
                                  pwd.isNotEmpty &&
                                  pwdConfirm.isNotEmpty) {
                                if (pwd == pwdConfirm) {
                                  setState(() {
                                    showSignUp = !showSignUp;
                                  });
                                } else {
                                  mostrarDialogo(
                                      context,
                                      "La contraseña no coincide",
                                      Icons.cancel_outlined,
                                      Colors.red);
                                }
                              } else {
                                mostrarDialogo(
                                    context,
                                    "Llena todos los campos",
                                    Icons.list_alt,
                                    Colors.grey.shade100);
                              }
                            },
                            color: AppTheme().theme().primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: const Text(
                              "Comenzar registro",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      : FadeInUp(
                          //  duration: const Duration(microseconds: 1500),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () async {
                              if (nombre.isNotEmpty &&
                                      usuario.isNotEmpty &&
                                      isMaleSelected == true ||
                                  isMaleSelected == true) {
                                List<String> nombreDestructurado =
                                    nombre.trim().split(' ');
                                // Obtener nombre y apellidos
                                String nombreCompleto = "";
                                String apePat = "";
                                String apeMat = "";

                                // print(nombreDestructurado.length);
                                if (nombreDestructurado.length == 1) {
                                  nombreCompleto = nombreDestructurado[0];
                                  apePat = "";
                                  apeMat = "";
                                } else if (nombreDestructurado.length == 2) {
                                  nombreCompleto = nombreDestructurado[0];
                                  apePat = nombreDestructurado[1];
                                  apeMat = "";
                                } else if (nombreDestructurado.length == 3) {
                                  nombreCompleto = nombreDestructurado[0];
                                  apePat = nombreDestructurado[1];
                                  apeMat = nombreDestructurado[2];
                                } else if (nombreDestructurado.length == 4) {
                                  nombreCompleto =
                                      "$nombreDestructurado[0] $nombreDestructurado[1]";
                                  apePat = nombreDestructurado[2];
                                  apeMat = nombreDestructurado[3];
                                }
                                // print(nombreCompleto);
                                // print(apePat);
                                // print(apeMat);

                                final user = Usuario(
                                  nombre: nombreCompleto,
                                  apePat: apePat,
                                  apeMat: apeMat,
                                  sexo: gender,
                                  correo: correo,
                                  usuario: usuario,
                                  pwd: pwd,
                                  idRol: 1,
                                );
                                SmartDialog.showLoading(
                                    msg: "Registrando usuario...");

                                ResponseAuth response =
                                    await agregarUsuario(user);

                                SmartDialog.dismiss();

                                if (response.codigo == 200) {
                                  // ignore: use_build_context_synchronously
                                  mostrarDialogo(context, "Registrado",
                                      Icons.check, Colors.green);
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      "/login", (route) => false);
                                } else {
                                  // ignore: use_build_context_synchronously
                                  mostrarDialogo(
                                      context,
                                      "Hubo un error al registrar el usuario",
                                      Icons.cancel_outlined,
                                      Colors.red);
                                }
                              } else {
                                mostrarDialogo(
                                    context,
                                    "Llena todos los campos",
                                    Icons.list_alt,
                                    Colors.grey.shade100);
                              }
                            },
                            color: AppTheme().theme().primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: const Text(
                              "Registrarse",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                  FadeInUp(
                    //  duration: const Duration(microseconds: 1600),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("¿Ya tienes cuenta?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: const Text(
                            " Iniciar sesión",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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

  Widget _buildSignUpForm() {
    return Column(
      children: [
        InputTexFormtField(
          label: "Correo",
          textController: txtCorreoController,
          inputType: TextInputType.emailAddress,
          icon: Icons.email,
        ),
        InputTexFormtField(
          label: "Contraseña",
          obscureText: true,
          esPwd: true,
          textController: txtPwdController,
          inputType: TextInputType.text,
          icon: Icons.lock,
        ),
        InputTexFormtField(
          label: "Confirmar Contraseña",
          obscureText: true,
          esPwd: true,
          textController: txtPwdConfirmController,
          inputType: TextInputType.text,
          icon: Icons.password,
        ),
      ],
    );
  }

  Widget _buildOtherForm() {
    return Column(
      children: [
        InputTexFormtField(
          label: "Nombre completo",
          textController: txtNombreCompletoController,
          inputType: TextInputType.text,
          icon: Icons.badge,
        ),
        TextFormField(
          controller: txtUsuarioController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: "Usuario",
            prefixIcon: Icon(Icons.person),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Campo repetido";
            }
            return null;
          },
        ),

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

        // const SizedBox(height: 20),
        // Otros campos del formulario
        // MaterialButton(
        //   minWidth: double.infinity,
        //   height: 60,
        //   onPressed: () {
        //     // Lógica para el otro formulario
        //   },
        //   color: AppTheme().theme().primaryColor,
        //   elevation: 0,
        //   shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(50)),
        //   child: const Text(
        //     "Finalizar registro",
        //     style: TextStyle(
        //         fontWeight: FontWeight.w600, fontSize: 18,
        //         color: Colors.white),
        //   ),
        // ),
      ],
    );
  }
}
