import 'package:flutter/material.dart';

class ListButtons extends StatelessWidget {
  String? text;
  IconData? icon;
  final Color color;
  final Color backgroundColor;
  double size;
  final Color borderColor;
  bool? isIcon;
  ListButtons(
      {super.key,
      this.text="1",
      this.icon,
      this.isIcon = false,
      required this.color,
      required this.backgroundColor,
      required this.borderColor,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1.0),
        borderRadius: BorderRadius.circular(15),
        color: backgroundColor,
      ),
      child: isIcon == false ? Center(child: Text(text!,style:  TextStyle(color: color),)) : Center(child: Icon(icon,color: color,)),
      
    );
  }
}
