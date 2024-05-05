// ignore_for_file: file_names


import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:ofimex/pages/auth/login.dart';
import 'package:ofimex/theme/theme.dart';
import 'package:ofimex/widgets/InputTextFoemField.dart';
import 'package:provider/provider.dart';

// import 'package:simple_animations/simple_animations.dart';
class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final txtCorreoController = TextEditingController();
  final txtPwdController = TextEditingController();
  final txtPwdConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    final gmail = txtCorreoController.text;
    final pwd = txtPwdController.text;
    final pwdConfirm = txtPwdConfirmController.text;

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
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    FadeInUp(
                      // duration: const Duration(microseconds: 50000),
                      child: const Text(
                        "Registratarse",
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
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    FadeInUp(
                        child: InputTexFormtField(
                      label: "Gmail",
                      textController: txtCorreoController,
                      inputType: TextInputType.emailAddress,
                      icon: Icons.email,
                    )),
                    FadeInUp(
                        child: InputTexFormtField(
                      label: "Contraseña",
                      obscureText: true,
                      textController: txtPwdController,
                      inputType: TextInputType.text,
                      icon: Icons.lock,
                      esPwd: true,
                    )),
                    FadeInUp(
                        child: InputTexFormtField(
                      label: "Confirmar Contraseña",
                      obscureText: true,
                      textController: txtPwdConfirmController,
                      inputType: TextInputType.text,
                      icon: Icons.password,
                      esPwd: true,
                    ))
                  ],
                ),
                FadeInUp(
                  //  duration: const Duration(microseconds: 1500),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () async {
                      // if (gmail.isNotEmpty &&
                      //     pwd.isNotEmpty &&
                      //     pwdConfirm.isNotEmpty) {
                      //   if (pwd == pwdConfirm) {
                      //     ResponseAuth response = await registrarUsuario(
                      //         txtCorreoController.value.text,
                      //         txtPwdController.value.text);
                      //     if (response.codigo == 200) {
                      //       gloables.correo =txtCorreoController.value.text;
                      //       SmartDialog.showToast(response.mensaje);
                      //       // ignore: use_build_context_synchronously
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) =>
                      //                   const WelcomePage()));
                      //     } else {
                      //       SmartDialog.showToast(response.mensaje);
                      //     }
                      //   } else {
                      //     mostrarDialogo(
                      //         context, "La contraseña no coincide");
                      //   }
                      // } else {
                      //   mostrarDialogo(context, "Llena todos los campos");
                      // }
                    },
                    color: AppTheme().theme().primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: const Text(
                      "Registrate",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18,color: Colors.white),
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
    );
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
}
