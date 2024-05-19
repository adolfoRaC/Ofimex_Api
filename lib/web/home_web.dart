import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ofimex/widgets/InputTextFoemField.dart';
import 'package:ofimex/widgets/ServicioTypeMenu.dart';
import 'package:ofimex/widgets/cardTrabajador.dart';
import 'package:ofimex/widgets/custom_icon_button.dart';
import 'package:ofimex/widgets/location_card_web.dart';
import 'package:ofimex/widgets/recommended_servicios.dart';
import 'package:ofimex/models/trabajador_list_data.dart';

class HomePageWeb extends StatefulWidget {
  const HomePageWeb({Key? key}) : super(key: key);

  @override
  _HomePageWebState createState() => _HomePageWebState();
}

class _HomePageWebState extends State<HomePageWeb>
    with TickerProviderStateMixin<HomePageWeb> {
  final TextEditingController txtSearchController = TextEditingController();
  late AnimationController animationController;
  String? selectedService;
  List<TrabjadorListData> listTrabajador = TrabjadorListData.listTrabajador;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    listTrabajador = TrabjadorListData.listTrabajador;
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

  // Widget getListUI() {
  //   return FutureBuilder<bool>(
  //     future: getData(),
  //     builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
  //       if (!snapshot.hasData) {
  //         return const Center(child: CircularProgressIndicator());
  //       } else {
  //         // Obtener el ancho de la pantalla
  //         double screenWidth = MediaQuery.of(context).size.width;

  //         // Definir el número de columnas según el ancho de la pantalla
  //         int crossAxisCount = 3; // Valor por defecto
  //         if (screenWidth < 800) {
  //           crossAxisCount = 2; // Pantallas pequeñas
  //         } else if (screenWidth < 1000) {
  //           crossAxisCount = 3; // Pantallas medianas
  //         }

  //         return GridView.builder(
  //           shrinkWrap:
  //               true, // Asegura que el GridView tenga el tamaño adecuado
  //           itemCount: listTrabajador.length,
  //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //             crossAxisCount: crossAxisCount, // Número de columnas adaptativo
  //             crossAxisSpacing: 3, // Espaciado horizontal entre columnas
  //             mainAxisSpacing: 3, // Espaciado vertical entre filas
  //             childAspectRatio: 1.38, // Proporción entre ancho y alto
  //           ),
  //           itemBuilder: (BuildContext context, int index) {
  //             final int count =
  //                 listTrabajador.length > 10 ? 10 : listTrabajador.length;
  //             final Animation<double> animation =
  //                 Tween<double>(begin: 0.0, end: 1.0).animate(
  //               CurvedAnimation(
  //                 parent: animationController,
  //                 curve: Interval((1 / count) * index, 1.0,
  //                     curve: Curves.fastOutSlowIn),
  //               ),
  //             );
  //             animationController.forward();

  //             return TrabajadorListView(
  //               callback: () {
  //                 Navigator.pushNamed(context, "/datailTrabajadorWeb",
  //                     arguments: listTrabajador[index]);
  //               },
  //               trabajadorData: listTrabajador[index],
  //               animation: animation,
  //               animationController: animationController,
  //             );
  //           },
  //         );
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWeb = screenWidth > 500;
    double responsiveWidth = isWeb ? 500 : double.infinity;
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
        actions: const [
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 12),
            child: CustomIconButton(
              icon: Icon(Icons.history),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 12),
            child: CustomIconButton(
              icon: Icon(Ionicons.notifications_outline),
            ),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        children: [
          // LOCATION CARD
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
            ),
            child: InputTexFormtField(
              label: "Buscar",
              textController: txtSearchController,
              icon: Icons.search,
              inputType: TextInputType.text,
            ),
          ),
          const LocationCardWeb(),
          const SizedBox(
            height: 15,
          ),
         ServicioTypeMenu(
            onItemSelected: (value) {
              setState(() {
                selectedService = value;
                print(selectedService);
              });
            },
          ),
          // CATEGORIES
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recomendaciones",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(
                onPressed: () {
                  // Navigator.of(context).pushNamed("/datailServicio");
                },
                child: const Text("Ver todo"),
              )
            ],
          ),
          const SizedBox(height: 10),
           RecommendedServicos(isWeb: isWeb!,),
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
          // const Nearby(),
          // getListUI(), // Llamando al método que contiene la lista de hoteles
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
