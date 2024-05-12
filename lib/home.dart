import 'package:flutter/material.dart';
import 'package:ofimex/mobile/home_Mobile.dart';
import 'package:ofimex/web/home_web.dart';
import 'package:ofimex/responsive.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: const HomePageMobile(), webScaffold: const HomePageWeb());
  }
}