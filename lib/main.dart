import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:ofimex/pages/auth/login.dart';
import 'package:ofimex/pages/auth/signUp.dart';
import 'package:ofimex/pages/auth/authMenu.dart';
import 'package:ofimex/pages/contrataciones/pago_screen.dart';
import 'package:ofimex/pages/home.dart';
import 'package:ofimex/pages/map_pruebas.dart';
import 'package:ofimex/pages/map_screen.dart';
import 'package:ofimex/pages/profile/detailProfile.dart';
import 'package:ofimex/pages/profile/profile_screen.dart';
import 'package:ofimex/pages/profile/updateProfile.dart';
import 'package:ofimex/pages/services/DetailServicio.dart';
import 'package:ofimex/pages/services/review_screem.dart';
import 'package:ofimex/pages/welcome.dart';
import 'package:ofimex/provider/globales.dart';
import 'package:ofimex/theme/theme.dart';
import 'package:ofimex/widgets/bottomNavBar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => Globales(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ofimex',
      theme: AppTheme().theme(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const AuthMenu(),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/welcome': (context) => const WelcomePage(),
        '/inicio': (context) => const HomePage(),
        '/profileConfig': (context) => const ProfileScreen(),
        '/updateProfile': (context) =>  UpdateProfileScreen(),
        '/nav': (context) =>  const BottomNavBar(),
        '/datailServicio': (context) =>  const DetailServicio(),
        '/detailProfile': (context) => const DetailProfile(),
        '/pago': (context)=> const PagoScreen(),
        '/review': (context)=> const ReviewScreen(),
        '/map': (context) => const MapScreen(),
        '/mapPruena': (context) => const MapScreenPruebas(),





      },
      initialRoute: '/',
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
    );
  }
}
