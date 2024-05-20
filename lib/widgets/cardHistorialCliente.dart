// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ofimex/models/usuario/trabajo.dart';
import 'package:ofimex/services/services.dart';
import 'package:ofimex/theme/theme.dart';

import 'package:readmore/readmore.dart';
import 'package:text_area/text_area.dart';

// ignore: must_be_immutable
class WorkerServiceCardCliente extends StatefulWidget {
  final Trabajo trabajo;
  final VoidCallback onRefresh;
  WorkerServiceCardCliente({
    super.key,
    required this.trabajo,
    required this.onRefresh,
  });

  @override
  State<WorkerServiceCardCliente> createState() =>
      _WorkerServiceCardClienteState();
}

class _WorkerServiceCardClienteState extends State<WorkerServiceCardCliente> {
  // Método para obtener el ícono según el estado del servicio
  IconData getStatusIcon(int estatus) {
    switch (estatus) {
      case 1:
        return Icons.hourglass_empty; // Ícono para "En espera"
      case 2:
        return Icons.timelapse; // Ícono para "En proceso"
      case 3:
        return Icons.check_circle; // Ícono para "Realizado"
      case 4:
        return Icons.cancel; // Ícono para "Cancelado"
      case 5:
        return Icons.comments_disabled; // Ícono para "Sin comentarios"
      default:
        return Icons.help_outline; // Ícono para "Sin comentarios" u otros
    }
  }

  // Método para obtener el color según el estado del servicio
  Color getStatusColor(int estatus) {
    switch (estatus) {
      case 1:
        return Colors.yellow.shade600; // Color para "En espera"
      case 2:
        return Colors.orange; // Color para "En proceso"
      case 3:
        return Colors.green; // Color para "Realizado"
      case 4:
        return Colors.red; // Color para "Cancelado"
      case 5:
        return Colors.grey.shade900; // Color para "Cancelado"
      default:
        return Colors.grey; // Color para "Sin comentarios" u otros
    }
  }

  String getStatusText(int estatus) {
    switch (estatus) {
      case 1:
        return "En espera"; // Text para "En espera"
      case 2:
        return "En proceso"; // Text para "En proceso"
      case 3:
        return "Realizado"; // Text para "Realizado"
      case 4:
        return "Cancelado"; // Text para "Cancelado"
      case 5:
        return "Sin comentarios"; // Text para "Cancelado"
      default:
        return "Error"; // Text para "Sin comentarios" u otros
    }
  }

  final txtDescripcionController = TextEditingController();

  final txtCostoController = TextEditingController();

  final txtComentarioController = TextEditingController();

  var reasonValidation = true;

  File? imagen;

  final double calificacion = 0;

  @override
  Widget build(BuildContext context) {
    txtDescripcionController.text = widget.trabajo.descripcion;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(
              getStatusIcon(widget.trabajo.idEstado!), // Ícono según el estado
              size: 50,
              color: getStatusColor(
                  widget.trabajo.idEstado!), // Color de fondo según el estado
            ),
            const SizedBox(width: 10.0), // Espacio entre el ícono y el texto
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.trabajo.trabajador!.usuario!.oficio![0].oficio!.nombre,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: AppTheme().theme().primaryColor),
                ),
                // const Divider(),

                const SizedBox(height: 5.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 150,
                  child: Wrap(
                    children: [
                      const Text(
                        "Descripción:",
                        style: TextStyle(
                            color: Color.fromARGB(255, 104, 103, 103),
                            fontWeight: FontWeight.w900),
                      ),
                      ReadMoreText(
                        widget.trabajo.descripcion,
                        trimLines: 2,
                        trimExpandedText: ' Leer menos',
                        trimCollapsedText: ' Leer más',
                        moreStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                        ),
                        lessStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                widget.trabajo.idEstado == 1 ||
                        widget.trabajo.idEstado == 2 ||
                        widget.trabajo.idEstado == 4
                    ? const SizedBox()
                    : Text(
                        'Costo: \$${widget.trabajo.costoTotal}', // Mostrar el costo
                        style: const TextStyle(fontSize: 14.0),
                      ),

                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 150,
                      child: Wrap(
                        children: [
                          const Text(
                            'Dirección: ',
                            style: TextStyle(
                              color: Color.fromARGB(255, 104, 103, 103),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            '${widget.trabajo.direccion![0].calle} ${widget.trabajo.direccion![0].numeroExt}, ${widget.trabajo.direccion![0].colonia},${widget.trabajo.direccion![0].cp}, ${widget.trabajo.direccion![0].municipio}',
                            style:
                                const TextStyle(fontWeight: FontWeight.normal),
                            overflow: TextOverflow.clip,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 150,
                      child: Wrap(
                        children: [
                          const Text(
                            'Cliente: ',
                            style: TextStyle(
                              color: Color.fromARGB(255, 104, 103, 103),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            '${widget.trabajo.usuario!.nombre} ${widget.trabajo.usuario!.apePat} ${widget.trabajo.usuario!.apeMat}',
                            style:
                                const TextStyle(fontWeight: FontWeight.normal),
                            overflow: TextOverflow.clip,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    const Text(
                      'Estado: ', // Mostrar el estado
                      style: TextStyle(
                          color: Color.fromARGB(255, 104, 103, 103),
                          fontWeight: FontWeight.w900),
                    ),
                    Text(getStatusText(widget.trabajo.idEstado!)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                widget.trabajo.idEstado == 5
                    ? Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    SmartDialog.dismiss();
                                    SmartDialog.showLoading(msg: "Cargando...");

                                    await Future.delayed(
                                        const Duration(seconds: 2));
                                    SmartDialog.dismiss();
                                    calificarTrabajador(
                                        context, "Calificar al trabajador");
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        AppTheme().theme().primaryColor,
                                    shape: const StadiumBorder(),
                                  ),
                                  child: const Text("Agregar comentario",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future SeleccionarImagenGaleria() async {
    final picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picture == null) return;
    setState(() {
      imagen = File(picture.path);
    });
  }

  calificarTrabajador(BuildContext context, String mensaje) {
    SmartDialog.show(
      builder: (_) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 420,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      mensaje,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    StarsReview(size: 50),
                    const Text(
                      "Comentario",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    TextArea(
                      borderRadius: 10,
                      borderColor: const Color(0xFFCFD6FF),
                      textEditingController: txtComentarioController,
                      suffixIcon: Icons.attach_file_rounded,
                      onSuffixIconPressed: () => {},
                      validation: reasonValidation,
                      errorText: 'No puede dejar el campo vacío!',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () async {
                          await SeleccionarImagenGaleria();
                          setState(
                              () {}); // Actualiza el estado dentro del diálogo
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme().theme().primaryColor,
                          shape: const StadiumBorder(),
                        ),
                        child: imagen == null
                            ? const Text("Subir Evidencia",
                                style: TextStyle(color: Colors.white))
                            : const Icon(Icons.check_circle,
                                color: Colors.green),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        SmartDialog.dismiss();
                        SmartDialog.showLoading(msg: "Cargando...");
                        if (txtComentarioController.text.isNotEmpty) {
                          final trabajoFinalizado = Trabajo(
                            id: widget.trabajo.id,
                            descripcion: widget.trabajo.descripcion,
                            costoTotal: int.parse(txtCostoController.text),
                            idUsuario: widget.trabajo.idUsuario,
                            idTrabajador: widget.trabajo.idTrabajador,
                            idOficio: widget.trabajo.idOficio,
                            idEstado: 3,
                          );
                          final response = await actualizarTrabajo(
                              trabajoFinalizado, widget.trabajo.id);

                          if (response.codigo == 200) {
                            // Aquí puedes agregar cualquier acción adicional si la actualización es exitosa
                          } else {
                            SmartDialog.dismiss();
                            mostrarDialogo(
                                context,
                                "Error al finalizar el trabajo",
                                Icons.cancel,
                                Colors.red);
                          }
                        }
                        SmartDialog.dismiss();
                      },
                      child: const Text('Finalizar'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

mostrarDialogo(
    BuildContext context, String mensaje, IconData icon, Color color) {
  SmartDialog.show(builder: (_) {
    return Container(
      height: 200,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            mensaje,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: Icon(
              icon,
              color: color,
              size: 60,
            ),
          )
        ],
      ),
    );
  });
}

class StarsReview extends StatelessWidget {
  // double value;
  double size;
  StarsReview({
    // required this.value,
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      initialRating: 5,
      direction: Axis.horizontal,
      allowHalfRating: false,
      // ignoreGestures: true,
      itemCount: 5,
      itemSize: size,

      ratingWidget: RatingWidget(
        full: Icon(
          Icons.star_rate_rounded,
          color: AppTheme().theme().primaryColor,
        ),
        half: Icon(
          Icons.star_half_rounded,
          color: AppTheme().theme().primaryColor,
        ),
        empty: Icon(
          Icons.star_border_rounded,
          color: AppTheme().theme().primaryColor,
        ),
      ),
      itemPadding: EdgeInsets.zero,
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
