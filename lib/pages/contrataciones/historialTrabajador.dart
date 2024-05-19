import 'package:flutter/material.dart';
import 'package:ofimex/models/usuario/trabajo.dart';
import 'package:ofimex/provider/globales.dart';
import 'package:ofimex/services/services.dart';
import 'package:ofimex/widgets/cardHistorial.dart';
import 'package:ofimex/widgets/menuStatus.dart';
import 'package:provider/provider.dart';

class HistorialTrabajador extends StatefulWidget {
  const HistorialTrabajador({super.key});

  @override
  State<HistorialTrabajador> createState() => _HistorialTrabajadorState();
}

class _HistorialTrabajadorState extends State<HistorialTrabajador> {
  @override
  Widget build(BuildContext context) {
    final globales = context.watch<Globales>();

    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: MenuStatus(text: "En espera", callback: () {}),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.height - 156 - 50,
              
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FutureBuilder<List<Trabajo>>(
                    future: getTrabajosTrabajador(globales.usuario.oficio![0].idOficio, globales.usuario.trabajador!.id!),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Trabajo>> snapshot) {
                      // print('Error: ${snapshot.hasData}');
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final trabajo = snapshot.data!;
                        return ListView.builder(
                          
                            itemCount: trabajo.length,
                            itemBuilder: (BuildContext context, int index) {
                              
                              // print(trabajo[index]);
                              return WorkerServiceCard(
                                trabajo: trabajo[index],
                                  oficio: trabajo[index]
                                      .trabajador!
                                      .usuario!
                                      .oficio![0]
                                      .oficio!
                                      .nombre,
                                  descripcion: trabajo[index].descripcion,
                                  costo: trabajo[index].costoTotal,
                                  cliente: '${trabajo[index].usuario!.nombre} ${trabajo[index].usuario!.apePat} ${trabajo[index].usuario!.apeMat}',
                                  direccion:'${trabajo[index].direccion![0].calle} ${trabajo[index].direccion![0].numeroExt}, ${trabajo[index].direccion![0].colonia},${trabajo[index].direccion![0].cp}, ${trabajo[index].direccion![0].municipio}',
                                  estatus: trabajo[index].idEstado!);
                            });
                      }
                    }),
             
              ),
            ),
            MenuStatus(text: "En proceso", callback: () {}),
            MenuStatus(text: "Realizado", callback: () {}),
            MenuStatus(text: "Cancelado", callback: () {}),
          ],
        ),
    );
  }
}