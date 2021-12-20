import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';

class LumberjackSquats extends StatefulWidget {
  const LumberjackSquats({Key? key}) : super(key: key);

  @override
  LumberjackSquatsState createState() => LumberjackSquatsState();
}

class LumberjackSquatsState extends State<LumberjackSquats> {
  SMITrigger? _squat;
  bool _locked = false;
  final Color _themeColor = const Color(0xFFB9F08E);
  final Color _secondaryThemeColor = const Color(0xAAB9F08E);
  final Color _accentColor = const Color(0xFF2D2D2D);

  void _initRive(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      "Don't Skip Leg Day",
      onStateChange: _onStateChange,
    );

    artboard.addController(controller!);
    _squat = controller.inputs.first as SMITrigger;
  }

  void _onStateChange(_, String statename) {
    setState(() {
      _locked = (statename == "Squat");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lumberjack Squats"),
        backgroundColor: _themeColor,
        foregroundColor: _accentColor,
      ),
      body: SizedBox(
        child: RiveAnimation.asset(
          "assets/rive/lumberjack_squats.riv",
          fit: BoxFit.contain,
          onInit: _initRive,
          animations: const ["Idle"],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _locked ? _secondaryThemeColor : _themeColor,
        onPressed: _locked
            ? null
            : () {
                _squat?.change(true);
              },
        child: const FaIcon(
          FontAwesomeIcons.dumbbell,
          color: Color(0xFF2D2D2D),
        ),
        disabledElevation: 0.0,
      ),
    );
  }
}
