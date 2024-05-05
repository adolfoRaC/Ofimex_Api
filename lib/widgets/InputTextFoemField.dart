import 'package:flutter/material.dart';

class InputTexFormtField extends StatefulWidget {
  final String label;
  final bool? obscureText;
  final bool? esPwd;
  final TextEditingController textController;
  final IconData icon;
  final TextInputType inputType;

  const InputTexFormtField({
    Key? key,
    required this.label,
    this.obscureText = false,
    this.esPwd = false,
    required this.textController,
    required this.icon,
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
    _obscureText = widget.obscureText!;
    _iconPwd = Icons.visibility;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   widget.label,
        //   style: const TextStyle(
        //     fontSize: 15,
        //     fontWeight: FontWeight.w400,
        //     color: Colors.black87,
        //   ),
        // ),
        // const SizedBox(height: 5),
        TextFormField(
          controller: widget.textController,
          keyboardType: widget.inputType,
          obscureText: _obscureText,
          decoration: InputDecoration(
            hintText: widget.label,
            suffixIcon: widget.esPwd!
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                        _iconPwd = _obscureText
                            ? Icons.visibility
                            : Icons.visibility_off;
                      });
                    },
                    icon: Icon(_iconPwd),
                  )
                : null,
            prefixIcon:  Icon(widget.icon) ,
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
