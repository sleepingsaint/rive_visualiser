import 'package:rive_visualiser/aboutme.dart';
import 'package:rive_visualiser/credits.dart';
import 'package:flutter/material.dart';
import 'package:rive_visualiser/rive/rive_widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rive Visualisations',
      // theme: ThemeData.dark(),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/credits": (context) => const Credits(),
        "/about": (context) => const AboutMe(),
        "/grow_tree": (context) => const GrowTree(),
        "/piggy_bank": (context) => const PiggyBank(),
        "/safe_box": (context) => const SafeBox(),
        "/lumberjack_squats": (context) => const LumberjackSquats(),
        "/football_time": (context) => const FootballTime(),
        "/zombie": (context) => const Zombie(),
        "/donnie_the_dino": (context) => const DonnieTheDino(),
        "/water_bar": (context) => const WaterBar(),
      },
    );
  }
}
