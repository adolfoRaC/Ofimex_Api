import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:ofimex/theme/theme.dart';
import 'package:ofimex/widgets/InputTextFoemField.dart';
import 'package:text_area/text_area.dart';

// Widget que muestra información sobre un trabajador, servicio, costo y fecha
class WorkerServiceCard extends StatelessWidget {
  final String workerName; // Nombre del trabajador
  final String serviceName; // Nombre del servicio
  final double cost; // Costo del servicio
  final DateTime date; // Fecha del servicio
  final String status; // Estado del servicio

  // Constructor para inicializar la tarjeta
  WorkerServiceCard({
    required this.workerName,
    required this.serviceName,
    required this.cost,
    required this.date,
    required this.status,
  });

  // Método para obtener el ícono según el estado del servicio
  IconData getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'en proceso':
        return Icons.timelapse; // Ícono para "En proceso"
      case 'en espera':
        return Icons.hourglass_empty; // Ícono para "En espera"
      case 'realizado':
        return Icons.check_circle; // Ícono para "Realizado"
      case 'cancelado':
        return Icons.cancel; // Ícono para "Cancelado"
      default:
        return Icons.help_outline; // Ícono para "Sin comentarios" u otros
    }
  }

  // Método para obtener el color según el estado del servicio
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'en proceso':
        return Colors.orange; // Color para "En proceso"
      case 'en espera':
        return Colors.yellow; // Color para "En espera"
      case 'realizado':
        return Colors.green; // Color para "Realizado"
      case 'cancelado':
        return Colors.red; // Color para "Cancelado"
      default:
        return Colors.grey; // Color para "Sin comentarios" u otros
    }
  }

  // Formatear la fecha como un string amigable
  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  final txtDescripcionController = TextEditingController();
  final txtCostoController = TextEditingController();
  final txtComentarioController = TextEditingController();
  var reasonValidation = true;
  @override
  Widget build(BuildContext context) {
    txtDescripcionController.text = "Instalación de una grifería";
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // Borde redondeado
      ),
      elevation: 3.0, // Sombra de la tarjeta
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(
                getStatusIcon(status), // Ícono según el estado
                size: 50,
                color: getStatusColor(status), // Color de fondo según el estado
              ),
              SizedBox(width: 10.0), // Espacio entre el ícono y el texto
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trabajador: $workerName', // Mostrar el nombre del trabajador
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'Servicio: $serviceName', // Mostrar el servicio
                    style: TextStyle(fontSize: 14.0),
                  ),
                  status.toLowerCase() == "en espera" ||
                          status.toLowerCase() == "en proceso" ||
                          status.toLowerCase() == "cancelado"
                      ? SizedBox()
                      : Text(
                          'Costo: \$$cost', // Mostrar el costo
                          style: TextStyle(fontSize: 14.0),
                        ),
                  Text(
                    'Fecha: ${formatDate(date)}', // Mostrar la fecha
                    style: TextStyle(fontSize: 14.0),
                  ),
                  Text(
                    'Estado: $status', // Mostrar el estado
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  status.toLowerCase() == "en espera"
                      ? Column(
                          children: [
                            const Text("¿Deseas desbloquear el trabajo?"),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.red,
                                    )),
                              ],
                            ),
                          ],
                        )
                      : SizedBox(),
                  status.toLowerCase() == "en proceso"
                      ? Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      SmartDialog.dismiss();
                                      SmartDialog.showLoading(
                                          msg: "Cargando...");
                                      await Future.delayed(
                                          const Duration(seconds: 2));
                                      SmartDialog.dismiss();

                                      mostrarDesc(context, "Trabajo");
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          AppTheme().theme().primaryColor,
                                      shape: const StadiumBorder(),
                                    ),
                                    child: const Text("Finalizar",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  mostrarDesc(BuildContext context, String mensaje) {
    SmartDialog.show(builder: (_) {
      return Container(
        height: 420,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
              const SizedBox(
                height: 10,
              ),
              const Text("Descripción del trabajo",
                  style: TextStyle(fontWeight: FontWeight.w600)),
              TextArea(
                borderRadius: 10,
                borderColor: const Color(0xFFCFD6FF),
                textEditingController: txtDescripcionController,
                suffixIcon: Icons.attach_file_rounded,
                onSuffixIconPressed: () => {},
                validation: reasonValidation,
                errorText: 'No puede dejar el campo vacío!',
              ),
              const SizedBox(height: 15),
              const Text(
                "Costo total",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              InputTexFormtField(
                label: "Costo",
                textController: txtCostoController,
                icon: Icons.money_rounded,
                inputType: TextInputType.number,
                obscureText: false,
              ),
              ElevatedButton(
                onPressed: () async {
                  SmartDialog.dismiss();
                  SmartDialog.showLoading(msg: "Cargando...");
                  await Future.delayed(const Duration(seconds: 2));
                  SmartDialog.dismiss();
                  otro(context, "Calificar al cliente");
                },
                child: const Text('Siguiente'),
              ),
            ],
          ),
        ),
      );
    });
  }

  otro(BuildContext context, String mensaje) {
    SmartDialog.show(builder: (_) {
      return Container(
        height: 420,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
              ElevatedButton(
                onPressed: () async {
                  SmartDialog.dismiss();
                  SmartDialog.showLoading(msg: "Cargando...");
                  await Future.delayed(const Duration(seconds: 2));
                  SmartDialog.dismiss();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/home", (route) => false);
                  // ignore: use_build_context_synchronously
                },
                child: const Text('Finalizar'),
              ),
            ],
          ),
        ),
      );
    });
  }
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
      initialRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
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
