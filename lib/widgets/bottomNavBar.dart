import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ofimex/pages/profile/profile_screen.dart';
import 'package:ofimex/pages/home.dart';
import 'package:ofimex/pages/services/select_service.dart';
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex =0;
  List<Widget> body = const [
    
    // Prueba1(),
    // HomeServicesPage(),
    HomePage(),
    SelectService(),
    ProfileScreen(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(children: [body[_currentIndex]],),
      // Center(child: body[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(currentIndex: _currentIndex,onTap: (int newIndex){
        setState(() {
          _currentIndex = newIndex;
        });
      },items: const [
        BottomNavigationBarItem(icon: Icon(Ionicons.home_outline), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Ionicons.menu),label: "Menu"),
        BottomNavigationBarItem(icon: Icon(Ionicons.person_outline),label: "Profile"),

        ],),
      
    );
  }
}