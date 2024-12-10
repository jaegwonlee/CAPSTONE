import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_application_2/ui/pages/splash.dart';

void main() {
  runApp(const WePetApp());
}

class WePetApp extends StatelessWidget {
  const WePetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const WePetMainPage(title: 'WePet'),
      );
    });
  }
}

class WePetMainPage extends StatefulWidget {
  const WePetMainPage({super.key, required this.title});

  final String title;

  @override
  State<WePetMainPage> createState() => _WePetMainPageState();
}

class _WePetMainPageState extends State<WePetMainPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashScreen(),
    );
  }
}
