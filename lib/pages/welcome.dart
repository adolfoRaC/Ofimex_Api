import 'dart:async';
import 'dart:math';

// import 'package:design/Animations/FadeAnimation.dart';

import 'package:flutter/material.dart';
import 'package:ofimex/models/service.dart';
import 'package:ofimex/theme/theme.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List<Service> services = [
    Service(
        'Baches', 'https://cdn-icons-png.flaticon.com/512/3410/3410124.png'),
    Service('Faros', 'https://cdn-icons-png.flaticon.com/512/2983/2983631.png'),
    Service('Poste', 'https://cdn-icons-png.flaticon.com/512/2824/2824713.png'),
    Service('Luz', 'https://cdn-icons-png.flaticon.com/512/4178/4178539.png'),
    Service('Arboles',
        'https://cdn0.iconfinder.com/data/icons/trees-5/100/23-1024.png'),
    Service(
        'Basura', 'https://cdn-icons-png.flaticon.com/512/4380/4380445.png'),
    Service('Bad Parking',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/Singapore_Road_Signs_-_Restrictive_Sign_-_No_Parking.svg/1200px-Singapore_Road_Signs_-_Restrictive_Sign_-_No_Parking.svg.png'),
    Service('Alcantarilla',
        'https://firebasestorage.googleapis.com/v0/b/iq6b-2024-arc.appspot.com/o/reportesImg%2Fa139a657d87c9a6ee6d5dd8613b0205c.png?alt=media&token=81087034-0a56-4d88-8013-b07f7c7bf8d4'),
    Service('Agua', 'https://cdn-icons-png.flaticon.com/512/1503/1503681.png'),
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
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: services.length,
                  itemBuilder: (BuildContext context, int index) {
                    return serviceContainer(
                        services[index].imageURL, services[index].name, index);
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
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Center(
                  child: Text(
                    'Una manera fácil y rapida de hacer reportes de fallos en Pueblo Mágico de Teziutlán',
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
                    'Le proporcionamos la manera de hacer reporte y ver los reportes de las demás personas.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20),
                child: MaterialButton(
                  minWidth: double.infinity,
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("/nav", (route) => false);
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
            ],
          ),
        )
      ],
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
              Image.network(image, height: 30),
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
