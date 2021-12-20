import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';

class FootballTime extends StatefulWidget {
  const FootballTime({Key? key}) : super(key: key);

  @override
  FootballTimeState createState() => FootballTimeState();
}

class FootballTimeState extends State<FootballTime> {
  SMITrigger? _jump;
  bool _locked = false;

  void _initRive(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      "State Machine 1",
      onStateChange: _onStateChange,
    );

    artboard.addController(controller!);
    _jump = controller.inputs.first as SMITrigger;
  }

  void _onStateChange(_, String statename) {
    setState(() {
      _locked = (statename == "Jump");
    });
  }

  final Color _themeColor = const Color(0xFF244B14);
  final Color _secondaryThemeColor = const Color(0xFF3C7423);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Football Time"),
        backgroundColor: _themeColor,
      ),
      body: SizedBox(
        child: RiveAnimation.asset(
          "assets/rive/football_time.riv",
          fit: BoxFit.contain,
          onInit: _initRive,
          animations: const ["Run"],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _locked ? _secondaryThemeColor : _themeColor,
        onPressed: _locked
            ? null
            : () {
                _jump?.change(true);
              },
        child: const FaIcon(
          FontAwesomeIcons.running,
          color: Color(0xFFFFFFFF),
        ),
        disabledElevation: 0.0,
      ),
    );
  }
}
