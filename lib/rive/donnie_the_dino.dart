import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';

class DonnieTheDino extends StatefulWidget {
  const DonnieTheDino({Key? key}) : super(key: key);

  @override
  DonnieTheDinoState createState() => DonnieTheDinoState();
}

class DonnieTheDinoState extends State<DonnieTheDino> {
  SMITrigger? _break;
  bool _locked = false;

  void _initRive(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      "State Machine 1",
      onStateChange: _onStateChange,
    );

    artboard.addController(controller!);
    _break = controller.inputs.first as SMITrigger;
  }

  void _onStateChange(_, String statename) {
    setState(() {
      _locked = (statename == "Open Idle" || statename == "Egg Open");
    });
  }

  final Color _themeColor = const Color(0xFF4FB1B8);
  final Color _secondaryThemeColor = const Color(0xAA4FB1B8);
  final Color _accentColor = const Color(0xFF8719C4);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donnie The Dino"),
        backgroundColor: _themeColor,
      ),
      body: SizedBox(
        child: RiveAnimation.asset(
          "assets/rive/donnie_the_dino.riv",
          fit: BoxFit.contain,
          onInit: _initRive,
          animations: const ["Intro Idle"],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _locked ? _secondaryThemeColor : _themeColor,
        onPressed: _locked
            ? null
            : () {
                _break?.change(true);
              },
        child: const FaIcon(FontAwesomeIcons.egg),
        disabledElevation: 0.0,
      ),
    );
  }
}
