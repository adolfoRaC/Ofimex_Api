import 'package:flutter/material.dart';
import 'package:ofimex/theme/theme.dart';

class MenuStatus extends StatefulWidget {
  final String text;
  final VoidCallback callback;

  const MenuStatus({Key? key, required this.text, required this.callback})
      : super(key: key);

  @override
  _MenuStatusState createState() => _MenuStatusState();
}

class _MenuStatusState extends State<MenuStatus> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      splashColor: AppTheme().theme().primaryColor.withOpacity(0.2),
       
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
        widget.callback(); // Llama a la función de retorno de llamada
      },
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.white,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     spreadRadius: 0.5,
          //     blurRadius: 2,
          //     // offset: const Offset(0, 2),
          //   ),
          // ],
          borderRadius: BorderRadius.circular(20),
          border: const Border(
            bottom: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.text,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Icon(
                _isExpanded ? Icons.arrow_drop_down : Icons.arrow_right,
                size: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
