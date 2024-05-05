import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ofimex/theme/hotel_app_theme.dart';
import 'package:ofimex/widgets/InputTextFoemField.dart';
import 'package:ofimex/widgets/ServicioTypeMenu.dart';
import 'package:ofimex/widgets/cardServices.dart';
import 'package:ofimex/widgets/custom_icon_button.dart';
import 'package:ofimex/widgets/location_card.dart';
import 'package:ofimex/widgets/nearby.dart';
import 'package:ofimex/widgets/recommended_servicios.dart';
import 'package:ofimex/models/trabajador_list_data.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> with TickerProviderStateMixin<HomePage> {
  final TextEditingController txtSearchController = TextEditingController();
  late AnimationController animationController;
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
  Widget getListUI() {
    return Container(
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
          Container(
            height: MediaQuery.of(context).size.height - 156 - 50,
            child: FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                } else {
                  return ListView.builder(
                    itemCount: listTrabajador.length,
                    itemBuilder: (BuildContext context, int index) {
                      final int count = listTrabajador.length > 10 ? 10 : listTrabajador.length;
                      final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animationController,
                          curve: Interval((1 / count) * index, 1.0, curve: Curves.fastOutSlowIn),
                        ),
                      );
                      animationController.forward();
                      return TrabajadorListView(
                        callback: () { Navigator.pushNamed(context, "/datailServicio",
                          arguments: listTrabajador[index]);},
                        hotelData: listTrabajador[index],
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
        actions: const [
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 12),
            child: CustomIconButton(
              icon: Icon(Ionicons.file_tray_outline),
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
            padding: const EdgeInsets.only(top: 8,),
            child: InputTexFormtField(
              label: "Buscar",
              textController: txtSearchController,
              icon: Icons.search,
              inputType: TextInputType.text,
            ),
          ),
          const LocationCard(),
          const SizedBox(
            height: 15,
          ),
          ServicioTypeMenu(),
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
          const RecommendedServicos(),
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
          getListUI(), // Llamando al método que contiene la lista de hoteles
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:ofimex/widgets/InputTextFoemField.dart';
// import 'package:ofimex/widgets/ServicioTypeMenu.dart';
// import 'package:ofimex/widgets/cardServices.dart';
// import 'package:ofimex/widgets/custom_icon_button.dart';
// import 'package:ofimex/widgets/location_card.dart';
// import 'package:ofimex/widgets/nearby.dart';
// import 'package:ofimex/widgets/recommended_servicios.dart';
// import 'package:ofimex/models/hotel_list_data.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage>  with TickerProviderStateMixin{
//   final ScrollController _scrollController = ScrollController();
//   final TextEditingController txtSearchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     AnimationController? animationController;
//   List<HotelListData> hotelList = HotelListData.hotelList;
//   final ScrollController _scrollController = ScrollController();

//   DateTime startDate = DateTime.now();
//   DateTime endDate = DateTime.now().add(const Duration(days: 5));

//   @override
//   void initState() {
//     animationController = AnimationController(
//         duration: const Duration(milliseconds: 1000), vsync: this);
//     super.initState();
//   }

//   Future<bool> getData() async {
//     await Future<dynamic>.delayed(const Duration(milliseconds: 200));
//     return true;
//   }

//   @override
//   void dispose() {
//     animationController?.dispose();
//     super.dispose();
//   }


//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.black,
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("Ofimex"),
//             Text(
//               "Ayudando a todos",
//               style: Theme.of(context).textTheme.labelMedium,
//             ),
//           ],
//         ),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(left: 8.0, right: 12),
//             child: CustomIconButton(
//               icon: Icon(Ionicons.notifications_outline),
//             ),
//           ),
//         ],
//       ),
//       body: ListView(
//         physics: const BouncingScrollPhysics(),
//         padding: const EdgeInsets.all(14),
//         children: [
//           // LOCATION CARD
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 5),
//             child: InputTexFormtField(
//                 label: "Buscar",
//                 textController: txtSearchController,
//                 icon: Icons.search,
//                 inputType: TextInputType.text),
//           ),
//           const LocationCard(),
//           const SizedBox(
//             height: 15,
//           ),
//           const ServicioTypeMenu(),
//           // CATEGORIES
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Recomendaciones",
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//               TextButton(
//                   onPressed: () {
//                     // Navigator.of(context).pushNamed("/datailServicio");
//                   },
//                   child: const Text("Ver todo"))
//             ],
//           ),
//           const SizedBox(height: 10),
//           const RecommendedServicos(),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Servicios para ti",
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//               TextButton(onPressed: () {}, child: const Text("Ver todo"))
//             ],
//           ),
//           const SizedBox(height: 10),
//           const Nearby(),
//           const SizedBox(height: 10),
          
//         ],
//       ),
//     );
//      Widget getListUI() {
//     return Container(
//       decoration: BoxDecoration(
//         color: HotelAppTheme.buildLightTheme().backgroundColor,
//         boxShadow: <BoxShadow>[
//           BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               offset: const Offset(0, -2),
//               blurRadius: 8.0),
//         ],
//       ),
//       child: Column(
//         children: <Widget>[
//           Container(
//             height: MediaQuery.of(context).size.height - 156 - 50,
//             child: FutureBuilder<bool>(
//               future: getData(),
//               builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//                 if (!snapshot.hasData) {
//                   return const SizedBox();
//                 } else {
//                   return ListView.builder(
//                     itemCount: hotelList.length,
//                     scrollDirection: Axis.vertical,
//                     itemBuilder: (BuildContext context, int index) {
//                       final int count =
//                           hotelList.length > 10 ? 10 : hotelList.length;
//                       final Animation<double> animation =
//                           Tween<double>(begin: 0.0, end: 1.0).animate(
//                               CurvedAnimation(
//                                   parent: animationController!,
//                                   curve: Interval((1 / count) * index, 1.0,
//                                       curve: Curves.fastOutSlowIn)));
//                       animationController?.forward();

//                       return HotelListView(
//                         callback: () {},
//                         hotelData: hotelList[index],
//                         animation: animation,
//                         animationController: animationController!,
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   }
  
// }
