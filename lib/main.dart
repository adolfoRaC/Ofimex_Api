import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:ofimex/pages/auth/authMenu.dart';

import 'package:ofimex/pages/auth/login.dart';
import 'package:ofimex/pages/auth/signUp.dart';
import 'package:ofimex/pages/contrataciones/historialContrataciones.dart';

import 'package:ofimex/pages/contrataciones/pago_screen.dart';
import 'package:ofimex/home.dart';
import 'package:ofimex/pages/map_pruebas.dart';
import 'package:ofimex/pages/map_screen.dart';
import 'package:ofimex/pages/profile/detailProfile.dart';
import 'package:ofimex/pages/profile/profile_screen.dart';
import 'package:ofimex/pages/profile/registroTrabajador.dart';
import 'package:ofimex/pages/profile/updateProfile.dart';
import 'package:ofimex/mobile/pages/DetailTrabajadorMobile.dart';
import 'package:ofimex/pages/prueba/prueba1.dart';
import 'package:ofimex/pages/services/review_screem.dart';
import 'package:ofimex/pages/welcome.dart';
import 'package:ofimex/provider/globales.dart';
import 'package:ofimex/theme/theme.dart';
import 'package:ofimex/web/pages/DetailTrabajadorWeb.dart';
import 'package:ofimex/web/pages/map_screen_web.dart';
import 'package:ofimex/widgets/bottomNavBar.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => Globales(),
    ),
    
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
        '/signUp': (context) => const SignUpPage(),
        '/welcome': (context) => const WelcomePage(),
        '/inicio': (context) => const HomePage(),
        '/profileConfig': (context) => const ProfileScreen(),
        '/updateProfile': (context) =>  UpdateProfileScreen(),
        '/home': (context) =>  const BottomNavBar(),
        '/datailTrabajadorMobile': (context) =>  const DetailTrabajadorMobile(),
        '/datailTrabajadorWeb': (context) =>  const DetailTrabajadorWeb(),
        '/detailProfile': (context) => const DetailProfile(),
        // '/pago': (context)=> const PagoScreen(),
        '/review': (context)=> const ReviewScreen(),
        '/map': (context) => const MapScreen(),
        '/mapPruena': (context) => const MapScreenPruebas(),
        '/mapWeb': (context)=> const MapScreenWeb(),
        '/registroTrabajador': (context)=> const RegistrarTrabajador(),
        '/historial': (context)=> const HistorialContratacionesPage(),
        '/p':(context) => const Prueba1()

      },
      initialRoute: '/',
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
    );
  }
}
