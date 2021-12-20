import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';

class Zombie extends StatefulWidget {
  const Zombie({Key? key}) : super(key: key);

  @override
  ZombieState createState() => ZombieState();
}

class ZombieState extends State<Zombie> {
  SMITrigger? _hit, _in;
  bool _walking = true;

  void _initRive(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      "State Machine 1",
    );

    artboard.addController(controller!);
    _hit = controller.inputs.first as SMITrigger;
    _in = controller.inputs.last as SMITrigger;
  }

  final Color _themeColor = const Color(0xFF422F3C);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Zombie"),
        backgroundColor: _themeColor,
      ),
      body: SizedBox(
        child: RiveAnimation.asset(
          "assets/rive/zombie.riv",
          fit: BoxFit.contain,
          onInit: _initRive,
          animations: const ["Low"],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _themeColor,
        onPressed: () {
          if (_walking) {
            _hit?.change(true);
          } else {
            _in?.change(true);
          }

          setState(() {
            _walking = !_walking;
          });
        },
        child: FaIcon(
          _walking
              ? FontAwesomeIcons.skullCrossbones
              : FontAwesomeIcons.walking,
          color: const Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}
