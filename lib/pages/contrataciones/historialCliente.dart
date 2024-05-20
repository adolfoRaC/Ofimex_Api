import 'package:flutter/material.dart';
import 'package:ofimex/models/usuario/trabajo.dart';
import 'package:ofimex/provider/globales.dart';
import 'package:ofimex/services/services.dart';
import 'package:ofimex/widgets/cardHistorialCliente.dart';

import 'package:provider/provider.dart';
class HistorialCliente extends StatefulWidget {
  const HistorialCliente({super.key});

  @override
  State<HistorialCliente> createState() => _HistorialClienteState();
}

class _HistorialClienteState extends State<HistorialCliente> {
   late Future<List<Trabajo>> _futureTrabajos;
  
  @override
  void initState() {
    super.initState();
    _loadTrabajos();
  }

  void _loadTrabajos() {
    final globales = context.read<Globales>();
    setState(() {
      _futureTrabajos = getTrabajosCliente(
          globales.usuario.id!);
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10),
          //   child: MenuStatus(text: "En espera", callback: () {}),
          // ),
          const SizedBox(height: 10),
          SizedBox(
            height: MediaQuery.of(context).size.height - 90,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FutureBuilder<List<Trabajo>>(
                  future: _futureTrabajos,
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
                            return Column(
                              children: [
                                WorkerServiceCardCliente(trabajo: trabajo[index], onRefresh: _loadTrabajos, ),
                                const SizedBox(height: 10,)
                              ],
                            );
                          });
                    }
                  }),
            ),
          ),
          // MenuStatus(text: "En proceso", callback: () {}),
          // MenuStatus(text: "Realizado", callback: () {}),
          // MenuStatus(text: "Cancelado", callback: () {}),
        ],
      ),
    );
  }
}