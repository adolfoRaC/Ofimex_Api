import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Prueba1 extends StatefulWidget {
  const Prueba1({super.key});

  @override
  State<Prueba1> createState() => _Prueba1State();
}

class _Prueba1State extends State<Prueba1> {
  bool _mostrarLista1 = false;
  bool _mostrarLista2 = false;

  void _mostrarTrabajos1() {
    setState(() {
      _mostrarLista1 = !_mostrarLista1;
    });
  }

  void _mostrarTrabajos2() {
    setState(() {
      _mostrarLista2 = !_mostrarLista2;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Historial",
          ),
          centerTitle: true),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: _mostrarTrabajos1,
            child: const Row(
              children: <Widget>[
                Text('Mostrar trabajos 1'),
              ],
            ),
          ),
          _mostrarLista1
              ? AnimationLimiter(
                  child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: ListTile(
                              title: Text('Trabajo 1 - ${index + 1}'),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Container(),
          const SizedBox(height: 10), // Espacio entre filas
          GestureDetector(
            onTap: _mostrarTrabajos2,
            child: const Row(
              children: <Widget>[
                Text('Mostrar trabajos 2'),
              ],
            ),
          ),
          _mostrarLista2
              ? AnimationLimiter(
                  child: ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: ListTile(
                              title: Text('Trabajo 2 - ${index + 1}'),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Container(),
        ],
            ),
      )
    );
  }
}
