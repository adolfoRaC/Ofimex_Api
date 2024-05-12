import 'package:flutter/material.dart';
import 'package:ofimex/theme/theme.dart';
import 'package:ofimex/widgets/InputTextFoemField.dart';

class UpdateProfileScreen extends StatelessWidget {
   UpdateProfileScreen({Key? key}) : super(key: key);
  final txtNombreController = TextEditingController();
  final txtCorreoController = TextEditingController();

  final txtNumeroTelefonicoController = TextEditingController();
  final txtPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWeb = screenWidth > 500;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Editar perfil",),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: isWeb ? 500 : double.infinity,
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                // -- IMAGE with ICON
                Stack(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset("assets/profile_image.jpg"), // Reemplazar con la ruta correcta de la imagen de perfil
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
                          color: AppTheme().theme().primaryColor, // Cambiar a tu color preferido
                        ),
                        child: const Icon(Icons.camera_alt, color: Colors.white, size: 20), // Usar el icono predeterminado de Flutter para la cámara
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
          
                // -- Form Fields
                Form(
                  child: Column(
                    children: [
                      InputTexFormtField(label: "Nombre", textController: txtNombreController, icon:Icons.person, inputType: TextInputType.text),
                      InputTexFormtField(label: "Correo", textController: txtCorreoController, icon:Icons.email, inputType: TextInputType.emailAddress),
                      InputTexFormtField(label: "Teléfono", textController: txtNombreController, icon:Icons.phone, inputType: TextInputType.phone),
                      InputTexFormtField(label: "Contraseña", textController: txtPasswordController, icon:Icons.password, inputType: TextInputType.text,obscureText: true,esPwd: true,),
                      
          
                      // -- Form Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Lógica para actualizar el perfil
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme().theme().primaryColor, // Cambiar a tu color preferido
                            shape: const StadiumBorder(),
                          ),
                          child: const Text("Guardar cambios", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 20),
          
                      // -- Created Date and Delete Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text.rich(
                            TextSpan(
                              text: "Se unió el ",
                              style: TextStyle(fontSize: 12),
                              children: [
                                TextSpan(
                                  text: "01/01/2022", // Reemplazar con la fecha de unión real
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Lógica para eliminar el perfil
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent.withOpacity(0.1),
                              elevation: 0,
                              foregroundColor: Colors.red,
                              shape: const StadiumBorder(),
                            ),
                            child: const Text("Eliminar perfil"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
