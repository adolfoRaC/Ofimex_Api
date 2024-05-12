import 'dart:async';
import 'dart:math';

// import 'package:design/Animations/FadeAnimation.dart';

import 'package:flutter/material.dart';
import 'package:ofimex/models/service.dart';
import 'package:ofimex/models/servicioIconTypeModel.dart';
import 'package:ofimex/theme/theme.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
   List<ServicioIconModel> services = [
  ServicioIconModel(name: "Albañil", image: "assets/servicios/icons/albanil.png",false),
  ServicioIconModel(name: "Plomero", image: "assets/servicios/icons/plomero.png",false),
  ServicioIconModel(name: "Electricista", image: "assets/servicios/icons/electrico.png",false),
  ServicioIconModel(name: "Carpintero", image: "assets/servicios/icons/carpintero.png",false),
  ServicioIconModel(name: "Pintor", image: "assets/servicios/icons/pintor.png",false),
  ServicioIconModel(name: "Herrero", image: "assets/servicios/icons/herrero.png",false),
];

  int selectedService = 4;
  late Timer _timer;

  @override
  void initState() {
    // Iniciar el temporizador en initState
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        selectedService = Random().nextInt(services.length);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // Cancelar el temporizador en dispose para evitar fugas de memoria
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    bool isWeb = screenWidth > 500;
    double responsiveWidth = isWeb ? 500 : double.infinity;

    return Scaffold(
        body: Center(
      child: SizedBox(
        width: responsiveWidth,
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: isWeb ? EdgeInsets.only(top: 0) : EdgeInsets.only(top: 50),
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  height: isWeb ? MediaQuery.of(context).size.height * 0.45 : MediaQuery.of(context).size.height * 0.30,
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: services.length,
                      itemBuilder: (BuildContext context, int index) {
                        return serviceContainer(services[index].image,
                            services[index].name, index);
                      }),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80),
                    topRight: Radius.circular(80),
                  )),
              child: Column(
                children: [
                  
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Center(
                      child: Text(
                        'Una manera fácil y confiable de cuidar tu hogar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Center(
                      child: Text(
                        'Le proporcionamos las mejores personas para ayudarle a cuidar su hogar.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 50.0, horizontal: 20),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil("/home", (route) => false);
                      },
                      height: 55,
                      color: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: const Text(
                        "Empezar",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40,)
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  serviceContainer(String image, String name, int index) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: selectedService == index ? Colors.white : Colors.grey.shade100,
          border: Border.all(
            color: selectedService == index
                ? Colors.blue.shade100
                : Colors.grey.withOpacity(0),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(image, height: 30),
              const SizedBox(
                height: 10,
              ),
              Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14),
              )
            ]),
      ),
    );
  }
}
