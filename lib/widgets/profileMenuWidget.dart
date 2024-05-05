import 'package:flutter/material.dart';
import 'package:ofimex/theme/theme.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppTheme().theme().primaryColor.withOpacity(0.1),
        ),
        child: Icon(icon,
            color: AppTheme().theme().primaryColor), // Puedes cambiar a tu color preferido
      ),
      title: Text(
        title,
      ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: const Icon(Icons.arrow_forward_ios,
                  size: 18.0,
                  color: Colors.grey), // Icono predeterminado de Flutter
            )
          : const SizedBox(), // Usamos un SizedBox para crear un espacio vacío si endIcon es false
    );
  }
}
