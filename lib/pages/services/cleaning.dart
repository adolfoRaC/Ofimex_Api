// import 'package:design/animations/FadeAnimation.dart';

import 'package:flutter/material.dart';
import 'package:ofimex/pages/services/date_time.dart';

class CleaningPage extends StatefulWidget {
  const CleaningPage({super.key});

  @override
  State<CleaningPage> createState() => _CleaningPageState();
}

class _CleaningPageState extends State<CleaningPage> {
  // Rooms to clean
  final List<dynamic> _rooms =[
    ['Sala de estar', 'https://img.icons8.com/officel/2x/living-room.png', Colors.red, 0],
    ['Dormitorio', 'https://img.icons8.com/fluency/2x/bedroom.png', Colors.orange, 1],
    ['Balo', 'https://img.icons8.com/color/2x/bath.png', Colors.blue, 1],
    ['Cocina', 'https://img.icons8.com/dusk/2x/kitchen.png', Colors.purple, 0],
    ['Oficina', 'https://img.icons8.com/color/2x/office.png', Colors.green, 0]
  ];

  final List<int> _selectedRooms = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: _selectedRooms.isNotEmpty ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DateAndTime()
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${_selectedRooms.length}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(width: 2),
            const Icon(Icons.arrow_forward_ios, size: 18,color: Colors.white,),
          ],
        ),
      ) : null,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child:  Padding(
                padding: const EdgeInsets.only(top: 120.0, right: 20.0, left: 20.0),
                child: Text(
                  'Donde quieres \nlimpiar?',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _rooms.length,
            itemBuilder: (BuildContext context, int index) {
              return ( room(_rooms[index], index));
            }
          ),
        ),
      )
    );
  }
  
  room(List room, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedRooms.contains(index)) {
            _selectedRooms.remove(index);
          } else {
            _selectedRooms.add(index);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        margin: const EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: _selectedRooms.contains(index) ? room[2].shade50.withOpacity(0.5) : Colors.grey.shade100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    Image.network(room[1], width: 35, height: 35,),
                    const SizedBox(width: 10.0,),
                    Text(room[0], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                  ],
                ),
                const Spacer(),
                _selectedRooms.contains(index) ? 
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.shade100.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Icon(Icons.check, color: Colors.green, size: 20,)
                  ) : 
                  const SizedBox()
              ],
            ),
            (_selectedRooms.contains(index) && room[3] >= 1) ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0,),
                Text("How many ${room[0]}s?", style: const TextStyle(fontSize: 15),),
                const SizedBox(height: 10.0,),
                SizedBox(
                  height: 45,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            room[3] = index + 1;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10.0),
                          padding: const EdgeInsets.all(10.0),
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: room[3] == index + 1 ? room[2].withOpacity(0.5) : room[2].shade200.withOpacity(0.5),
                          ),
                          child: Center(child: Text((index + 1).toString() , style: const TextStyle(fontSize: 22, color: Colors.white),)),
                        ),
                      );
                    }
                  ),
                )
              ],
            ) : const SizedBox()
          ],
        )
      ),
    );
  }
}