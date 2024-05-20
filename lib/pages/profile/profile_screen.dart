import 'package:flutter/material.dart';
import 'package:ofimex/provider/globales.dart';
import 'package:ofimex/theme/theme.dart';
import 'package:ofimex/widgets/profileMenuWidget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final globales = context.watch<Globales>();
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWeb = screenWidth > 500;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: isWeb ? 700 : double.infinity,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                /// -- IMAGE
                Stack(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(globales.usuario.imagen!,fit: BoxFit.cover),
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
                Text(
                    "${globales.usuario.nombre} ${globales.usuario.apePat} ${globales.usuario.apeMat} ${globales.usuario.id}",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge), // Reemplazar con el nombre del usuario
                Text(globales.usuario.correo,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium), // Reemplazar con el subtítulo del perfil
                const SizedBox(height: 20),

                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/updateProfile");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme().theme().primaryColor,
                      shape: const StadiumBorder(),
                    ),
                    child: const Text("Editar perfil",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 10),

                ProfileMenuWidget(
                    title: "Configuración",
                    icon: Icons.settings,
                    onPress: () {}),
                ProfileMenuWidget(
                    title: "Información personal",
                    icon: Icons.account_balance_wallet,
                    onPress: () {
                      Navigator.of(context).pushNamed("/detailProfile");
                    }),
                ProfileMenuWidget(
                    title: "Gestión de trabajador",
                    icon: Icons.group,
                    onPress: () {
                      Navigator.of(context).pushNamed("/registroTrabajador");
                    }),
                const Divider(),
                const SizedBox(height: 10),
                ProfileMenuWidget(
                    title: "Acerca de..", icon: Icons.info, onPress: () {}),
                ProfileMenuWidget(
                  title: "Cerrar sesión",
                  icon: Icons.logout,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("/", (route) => false);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
