import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'package:ofimex/models/usuario/trabajador.dart';
import 'package:ofimex/services/services.dart';
import 'package:ofimex/theme/theme.dart';

class RecommendedServicos extends StatelessWidget {
  final bool? isWeb;

  RecommendedServicos({Key? key, this.isWeb = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Trabajador>>(
      future: getTrabajadores(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Column(
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No se encontraron datos'),
          );
        } else {
          List<Trabajador> listTrabajador = snapshot.data!;
          return SizedBox(
            height: 245,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: listTrabajador.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 220,
                  child: Card(
                    elevation: 0.4,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        if (isWeb == true) {
                          Navigator.pushNamed(context, "/datailTrabajadorWeb",
                              arguments: listTrabajador[index]);
                        } else {
                          Navigator.pushNamed(
                              context, "/datailTrabajadorMobile",
                              arguments: listTrabajador[index]);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                listTrabajador[index].usuario!.imagen!,
                                width: double.maxFinite,
                                fit: BoxFit.cover,
                                height: 150,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  "${listTrabajador[index].usuario!.nombre} ${listTrabajador[index].usuario!.apePat} ${listTrabajador[index].usuario!.apeMat}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow.shade700,
                                  size: 14,
                                ),
                                const Text(
                                  "5",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            Expanded(
                              child: SizedBox(
                                height:
                                    24, // Establecer una altura específica para el ListView
                                child: ListView.builder(
                                  scrollDirection: Axis
                                      .horizontal, // Establecer dirección horizontal
                                  itemCount: listTrabajador[index]
                                      .usuario!
                                      .oficio!
                                      .length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          right:
                                              8.0), // Espaciado entre elementos
                                      child: Text(
                                        listTrabajador[index]
                                            .usuario!
                                            .oficio![index]
                                            .oficio!
                                            .nombre,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppTheme()
                                              .theme()
                                              .primaryColor
                                              .withOpacity(0.8),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(
                                  Icons.workspace_premium_outlined,
                                  color: Theme.of(context).primaryColor,
                                  size: 16,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "${listTrabajador[index].experiencia} años de experiencia",
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.only(right: 10),
              ),
            ),
          );
        }
      },
    );
  }
}
