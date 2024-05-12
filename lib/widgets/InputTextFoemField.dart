import 'package:flutter/material.dart';

class InputTexFormtField extends StatefulWidget {
  final String label;
  final bool? obscureText;
  final bool? esPwd;
  final TextEditingController textController;
  final IconData? icon;
  final TextInputType inputType;

  const InputTexFormtField({
    Key? key,
    required this.label,
    this.obscureText = false,
    this.esPwd = false,
    required this.textController,
    this.icon,
    required this.inputType,
  }) : super(key: key);

  @override
  State<InputTexFormtField> createState() => _InputTexFormtFieldState();
}

class _InputTexFormtFieldState extends State<InputTexFormtField> {
  late bool _obscureText;
  late IconData _iconPwd;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText ?? false; // Inicializamos con el valor proporcionado, o falso si no se proporciona
    _iconPwd = Icons.visibility;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.textController,
          keyboardType: widget.inputType,
          obscureText: _obscureText, // Usamos la variable local _obscureText
          decoration: InputDecoration(
            hintText: widget.label,
            suffixIcon: widget.esPwd!
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText; // Cambiamos el valor de _obscureText
                        _iconPwd = _obscureText ? Icons.visibility : Icons.visibility_off;
                      });
                    },
                    icon: Icon(_iconPwd),
                  )
                : null,
            prefixIcon: Icon(widget.icon),
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Campo repetido";
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
