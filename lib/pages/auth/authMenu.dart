import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ofimex/theme/theme.dart';
import 'package:rive/rive.dart';

class AuthMenu extends StatelessWidget {
  const AuthMenu({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Determinar si es web o móvil basado en el ancho
    bool isWeb = screenWidth > 500; 

    double buttonWidth = isWeb ? 500 : double.infinity;
    return Scaffold(
      body: Stack(children: [
        const RiveAnimation.asset("assets/shapes.riv"),
        Positioned.fill(
            child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: const SizedBox(),
        )),
        SafeArea(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FadeInRight(
                      child: const Text(
                        "BIENVENIDO",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeInLeft(
                      child: Text(
                        'Bienvenido a OFIMEX Web, la app que te ayudara a encontrar los mejores servicios',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey[700],
                            // fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
                FadeInDown(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/logo.png'))),
                  ),
                ),
                Column(
                  children: <Widget>[
                    FadeInRight(
                      child: MaterialButton(
                        minWidth: buttonWidth,
                        height: 60,
                        onPressed: () {
                          Navigator.of(context).pushNamed("/login");
                        },
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(50)),
                        child: const Text(
                          "Iniciar sesión",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FadeInLeft(
                      child: MaterialButton(
                        minWidth: buttonWidth,
                        height: 60,
                        onPressed: () {
                          Navigator.of(context).pushNamed("/signUp");
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
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
