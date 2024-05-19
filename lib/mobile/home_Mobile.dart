import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'package:ofimex/services/services.dart';
import 'package:ofimex/theme/hotel_app_theme.dart';
import 'package:ofimex/widgets/InputTextFoemField.dart';
import 'package:ofimex/widgets/ServicioTypeMenu.dart';
import 'package:ofimex/widgets/cardTrabajador.dart';
import 'package:ofimex/widgets/custom_icon_button.dart';
import 'package:ofimex/widgets/location_card_mobile.dart';
import 'package:ofimex/widgets/recommended_servicios.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({Key? key}) : super(key: key);

  @override
  _HomePageMobileState createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile>
    with TickerProviderStateMixin {
  final TextEditingController txtSearchController = TextEditingController();
  late AnimationController animationController;
  String? selectedService;
  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget getListUI() {
    Future<List<dynamic>> getFuture() {
    switch (selectedService) {
      case 'Todo':
        return getTrabajadores();
      case 'Plomero':
        return getTrabajadoresOficio(1);
      case 'Electricista':
        return getTrabajadoresOficio(2);
      case 'Pintor':
        return getTrabajadoresOficio(3);
      case 'Carpintero':
        return getTrabajadoresOficio(4);
      case 'Herrero':
        return getTrabajadoresOficio(5);
      case 'Jardinero':
        return getTrabajadoresOficio(6);
      // Agrega más casos según sea necesario
      default:
        // Retornar un future vacío si no se selecciona ningún servicio específico
        return getTrabajadores();
    }
  }
    return Container(
      // padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: HotelAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: const Offset(0, -2),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height - 156 - 50,
            child: FutureBuilder<List<dynamic>>(
              future:getFuture(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Center(child: CircularProgressIndicator()),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final trabajadores = snapshot.data!;
                  return ListView.builder(
                    itemCount: trabajadores.length,
                    itemBuilder: (BuildContext context, int index) {
                      final int count =
                          trabajadores.length > 10 ? 10 : trabajadores.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animationController,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn),
                        ),
                      );
                      animationController.forward();
                      return TrabajadorListView(
                        callback: () {
                          Navigator.pushNamed(
                              context, "/datailTrabajadorMobile",
                              arguments: trabajadores[index]);
                        },
                        trabajadorData: trabajadores[index],
                        animation: animation,
                        animationController: animationController,
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Ofimex"),
            Text(
              "Ayudando a todos",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 12),
            child: CustomIconButton(
              icon: const Icon(Icons.history),
              callback: () async {
                // await getTrabajadoresOficio(1);
                Navigator.of(context).pushNamed("/historial");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 12),
            child: CustomIconButton(
              icon: const Icon(Ionicons.notifications_outline),
              callback: () {},
            ),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: InputTexFormtField(
              label: "Buscar",
              textController: txtSearchController,
              icon: Icons.search,
              inputType: TextInputType.text,
            ),
          ),
          const LocationCardMobile(),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recomendaciones",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Ver todo"),
              )
            ],
          ),
          const SizedBox(height: 10),
          RecommendedServicos(),
          const SizedBox(height: 10),
          ServicioTypeMenu(
            onItemSelected: (value) {
              setState(() {
                selectedService = value;
                print(value);
              });
              
            },
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Servicios para ti",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Ver todo"),
              ),
            ],
          ),
          const SizedBox(height: 10),
          getListUI(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
