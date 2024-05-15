import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:ofimex/models/usuario/login.dart';
import 'package:ofimex/models/usuario/responseAuth.dart';
import 'package:ofimex/pages/auth/signUp.dart';
import 'package:ofimex/pages/welcome.dart';
import 'package:ofimex/provider/globales.dart';
import 'package:ofimex/services/services.dart';
import 'package:ofimex/theme/theme.dart';
import 'package:ofimex/widgets/InputTextFoemField.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final txtCorreoController = TextEditingController();
  final txtPwdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final globales = context.watch<Globales>();

    double screenWidth = MediaQuery.of(context).size.width;

    bool isWeb = screenWidth > 500;
    double resposiveWidth = isWeb ? 500 : double.infinity;

    // txtCorreoController.text = "adolfo@gmail.com";
    // txtPwdController.text = "_adolfo777";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        // brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            )),
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: resposiveWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        FadeInUp(
                          child: const Text(
                            "Iniciar Sesión",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeInUp(
                          child: Text(
                            "Ingrese su cuenta",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700]),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          FadeInUp(
                              child: InputTexFormtField(
                                
                            label: "Usuario",
                            textController: txtCorreoController,
                            inputType: TextInputType.text,
                            icon: Icons.person,
                          )),
                          FadeInUp(
                              child: InputTexFormtField(
                            label: "Contraseña",
                            obscureText: true,
                            textController: txtPwdController,
                            inputType: TextInputType.text,
                            icon: Icons.lock,
                            esPwd: true,
                          ))
                        ],
                      ),
                    ),
                    FadeInUp(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () async {
                            SmartDialog.showLoading(msg: "Cargando...");
                            // Navigator.of(context).pushNamedAndRemoveUntil(
                            //     "/welcome", (route) => false);
                            if (txtCorreoController.text.isNotEmpty &&
                                txtPwdController.text.isNotEmpty) {
                                final login=  Login(usuario: txtCorreoController.text, pwd: txtPwdController.text);
                              ResponseAuth response = await loginUser(login);
                            
                              if (response.codigo == 200) {
                                globales.usuario = response.usuario!;
                                SmartDialog.showToast(response.mensaje);
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const WelcomePage()));
                              } else {
                               // ignore: use_build_context_synchronously
                               mostrarDialogo(context, response.mensaje, Icons.cancel_outlined, Colors.red);
                              }
                            }
                            SmartDialog.dismiss();

                          },
                          color: AppTheme().theme().primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: const Text(
                            "Iniciar Sesión",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    FadeInUp(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("¿No tienes cuenta?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUpPage()));
                            },
                            child: const Text(
                              " Regístrate",
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
              FadeInUp(
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/servicioLogin.png"),
                        fit: BoxFit.cover),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  mostrarDialogo(BuildContext context, String mensaje, IconData icon, Color color) {
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
