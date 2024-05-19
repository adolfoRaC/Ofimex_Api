// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:ofimex/models/trabajador_list_data.dart';
// import 'package:ofimex/theme/theme.dart';
// import 'package:ofimex/widgets/cardTrabajador.dart';
// import 'package:http/http.dart' as http;

// class PagoScreen extends StatefulWidget {
//   const PagoScreen({super.key});

//   @override
//   State<PagoScreen> createState() => _PagoScreenState();
// }

// class _PagoScreenState extends State<PagoScreen>
//     with TickerProviderStateMixin<PagoScreen> {
//   late AnimationController animationController;
//   List<TrabjadorListData> listTrabajador = TrabjadorListData.listTrabajador;


//   @override
//   void initState() {
//     animationController = AnimationController(
//       duration: const Duration(milliseconds: 1000),
//       vsync: this,
//     );
//     listTrabajador = TrabjadorListData.listTrabajador;
//     super.initState();
//   }

//   @override
//   void dispose() {
//     animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;

//     bool isWeb = screenWidth > 500; 
//     double resposiveWidth = isWeb ? 500 : double.infinity;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Pago"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: isWeb ? 400 : 0,
//               width: isWeb ? 600: 0,
//               child: TrabajadorListView(
//                 callback: () {},
//                 trabajadorData: listTrabajador[1],
//                 animationController: animationController,
//               ),
//             ),
//             Padding(
//               padding: isWeb ? const EdgeInsets.symmetric(horizontal: 400): const EdgeInsets.all(8.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                     border: Border.all(width: 1, color: Colors.grey.shade400),
//                     borderRadius: BorderRadius.circular(20)),
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//                 child: Column(children: [
//                   const Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [Text("SubTotal:"), Text("\$200.00")],
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   const Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [Text("Otros agregados:"), Text("\$50.00")],
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   const Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [Text("Total:"), Text("\$250.00")],
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   const Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [Text("Tiempo de contratación:"), Text("2 horas")],
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   const Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [Text("Fecha:"), Text("12/09/2024")],
//                   ),
//                   const Divider(),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         "Método de pago",
//                         style: TextStyle(
//                             fontWeight: FontWeight.w700, fontSize: 18),
//                       ),
//                       TextButton(onPressed: () {}, child: const Text("Cambiar"))
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                           height: 50,
//                           width: 50,
//                           child: Image.asset("assets/paypal.png"))
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         "Dirección",
//                         style: TextStyle(
//                             fontWeight: FontWeight.w700, fontSize: 18),
//                       ),
//                       TextButton(onPressed: () {}, child: const Text("Cambiar"))
//                     ],
//                   ),
//                   const Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Icon(Icons.pin_drop),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Expanded(
//                           child: Text(
//                               " Av Miguel Hidalgo 701, Centro, 73800 Teziutlán, Pue."))
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   const Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Icon(Icons.call),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Text("+52 231-593-5858")
//                     ],
//                   ),
//                 ]),
//               ),
//             ),
//             const SizedBox(
//                     height: 10,
//                   ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Padding(
//           padding:  EdgeInsets.symmetric(horizontal: isWeb ? 390 : 15, vertical: 5),
//           child: MaterialButton(
//             onPressed: () async {

//               // makePayment();
//               // print("Presionado");
//               // Navigator.of(context).pushNamed("/review");
//             },
//             child: Container(
//               width: double.infinity,
//               height: 50,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: AppTheme().theme().primaryColor,
//               ),
//               child: const Center(
//                   child: Text(
//                 "Pagar",
//                 style: TextStyle(color: Colors.white),
//               )),
//             ),
//           )),
//     );
//   }
// }
