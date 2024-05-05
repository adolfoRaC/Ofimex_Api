import 'package:flutter/material.dart';
import 'package:ofimex/models/servicioIconTypeModel.dart';

class ServicioTypeMenu extends StatefulWidget {

  const ServicioTypeMenu({
    Key? key,
  }) : super(key: key);

  @override
  _ServicioTypeMenuState createState() => _ServicioTypeMenuState();
}

class _ServicioTypeMenuState extends State<ServicioTypeMenu> {
    void ServicioTypeMenuSelected(int index) {
    setState(() {
      for(int i = 0; i<touristPlaces.length; i++){
        touristPlaces[i].isSelected = false;
      }
      touristPlaces[index].isSelected = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              setState(() {
                ServicioTypeMenuSelected(index);
              });
            },
            child: Chip(
              label: Text(touristPlaces[index].name,style: TextStyle(color: touristPlaces[index].isSelected == false ? Colors.black: Colors.white),),
              avatar: CircleAvatar(
                backgroundImage: AssetImage(touristPlaces[index].image),
              ),
              backgroundColor: touristPlaces[index].isSelected == false ? Colors.white: Colors.black,
              elevation: 0.4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) =>
            const Padding(padding: EdgeInsets.only(right: 10)),
        itemCount: touristPlaces.length,
      ),
    );
  }
}


    // GestureDetector(
    //   onTap: onTap,
    //   child: Padding(
    //     padding: const EdgeInsets.only(left: 25.0),
    //     child: Text(
    //       servicioType,
    //       style: TextStyle(
    //         fontSize: 18,
    //         fontWeight: FontWeight.bold,
    //         color: isSelected ? Colors.blue : Colors.blue[200],
    //       ),
    //     ),
    //   ),
    // );