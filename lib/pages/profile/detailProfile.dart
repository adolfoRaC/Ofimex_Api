import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ofimex/provider/globales.dart';
import 'package:ofimex/theme/theme.dart';
import 'package:ofimex/widgets/text_profile.dart';
import 'package:provider/provider.dart';

class DetailProfile extends StatelessWidget {
  const DetailProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final globales = context.watch<Globales>();
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWeb = screenWidth > 700;
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Perfil",
        style: TextStyle(),
      )),
      body: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: SizedBox(
                width: isWeb ? 500 : double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                width: 120,
                                height: 120,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: const Image(
                                      image: AssetImage(
                                          "assets/profile_image.jpg")), // Reemplazar con la ruta correcta de la imagen de perfil
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: AppTheme()
                                        .theme()
                                        .primaryColor, // Cambiar a tu color preferido
                                  ),
                                  child: const Icon(
                                    Icons
                                        .edit, // Usar el icono predeterminado de Flutter para editar
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Text("Adolfo Ramos Cruz",
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .titleLarge), // Reemplazar con el nombre del usuario
                          // Text("adolfoxd6@gmail.com",
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .titleMedium), // Reemplazar con el subtítulo del perfil
                          // const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    const Divider(),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Información del perfil",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    TextProfile(
                        title: "Usuario:", value: globales.usuario.usuario, onPressed: () {}),
                    TextProfile(
                        title: "Correo:",
                        value: globales.usuario.correo,
                        onPressed: () {}),
                    const Divider(),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Text(
                            "Información personal",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    TextProfile(
                        title: "Nombre:",
                        value: globales.usuario.nombre,
                        onPressed: () {}),
                    TextProfile(title: "Apellido Paterno:", value: globales.usuario.apePat, onPressed: () {}),
                    TextProfile(title: "Apellido Materno:", value: globales.usuario.apeMat, onPressed: () {}),
                    
                    TextProfile(title: "Genero:", value: globales.usuario.sexo, onPressed: () {}),
                    // TextProfile(
                    //     title: "Edad",
                    //     value: "23",
                    //     onPressed: () {}),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
