// import 'package:flutter/material.dart';
// import 'package:ofimex/widgets/InputTextFoemField.dart';
// import 'package:ofimex/widgets/ServicioTypeMenu.dart';

// class Prueba2 extends StatefulWidget {
//   const Prueba2({super.key});

//   @override
//   State<Prueba2> createState() => _Prueba2State();
// }

// class _Prueba2State extends State<Prueba2> {
//   final txtSearchController = TextEditingController();

//   final List servicioType = [
//     ['Carpintero', true],
//     ['Albañil', false],
//     ['Electrico', false],
//     ['Plomero', false],
//     ['Jardinero', false],
//     ['Chalan', false],
//   ];

//   void ServicioTypeMenuSelected(int index) {
//     setState(() {
//       for(int i = 0; i<servicioType.length; i++){
//         servicioType[i][1] = false;
//       }
//       servicioType[index][1] = true;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: InputTexFormtField(
//               label: "Buscar",
//               textController: txtSearchController,
//               icon: Icons.search,
//               inputType: TextInputType.text),
//         ),
//         Container(
//             height: 50,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//                 itemCount: servicioType.length,
//                 itemBuilder: (context, index) {
//                   return ServicioTypeMenu(
//                       servicioType: servicioType[index][0],
//                       isSelected: servicioType[index][1],
//                       onTap: () {
//                         ServicioTypeMenuSelected(index);
//                       });
//                 })),
//         Expanded(
//           child: ListView(
//             scrollDirection: Axis.horizontal,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 25.0, bottom: 25),
//                 child: Container(
//                   padding: const EdgeInsets.all(12),
//                   width: 200,
//                   height: 100,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: Color.fromARGB(255, 255, 255, 255),
//                     boxShadow: [
//                       BoxShadow(
//                         color: const Color.fromARGB(255, 224, 223, 223)
//                             .withOpacity(0.6), // Color de la sombra
//                         spreadRadius: 1, // Radio de difusión
//                         blurRadius: 2, // Radio de desenfoque
//                         offset:
//                             const Offset(0, 1), // Desplazamiento de la sombra
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.asset('assets/profile_image.jpg'),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 12, horizontal: 8),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Laura',
//                               style: TextStyle(fontSize: 20),
//                             ),
//                             Text(
//                               'Widh Almond Milk',
//                               style: TextStyle(color: Colors.grey[700]),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text("Teziutlán"),
//                             Container(
//                               padding: const EdgeInsets.all(4),
//                               decoration: BoxDecoration(
//                                 color: Colors.blue,
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                               child: const Icon(
//                                 Icons.add,
//                                 color: Colors.white,
//                               ),
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Text("Algo")
//       ]),
//     );
//   }
// }
