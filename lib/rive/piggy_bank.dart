import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';
import 'package:flutter/src/painting/gradient.dart' as MaterialGradient;
import 'package:rive/src/rive_core/shapes/paint/linear_gradient.dart'
    as RiveGradient;

class PiggyBank extends StatefulWidget {
  const PiggyBank({Key? key}) : super(key: key);

  @override
  PiggyBankState createState() => PiggyBankState();
}

class PiggyBankState extends State<PiggyBank> {
  SMITrigger? _pressed;
  bool _locked = false;

  void _initRive(Artboard artboard, BuildContext context) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      "State Machine 1",
      onStateChange: _onStateChange,
    );

    artboard.addController(controller!);
    _pressed = controller.inputs.first as SMITrigger;
  }

  void _onStateChange(_, String statename) {
    setState(() {
      _locked = (statename == "Coin");
    });
  }

  final Color _themeColor = const Color(0xFF6F21AA);
  final Color _secondaryThemeColor = const Color(0xAA6F21AA);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Piggy Bank"),
        backgroundColor: _themeColor,
      ),
      body: SizedBox(
        child: RiveAnimation.asset(
          "assets/rive/piggy_bank.riv",
          fit: BoxFit.contain,
          alignment: Alignment.center,
          onInit: (Artboard artboard) => _initRive(artboard, context),
          animations: const ["Idle"],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _locked ? _secondaryThemeColor : _themeColor,
        onPressed: _locked
            ? null
            : () {
                _pressed?.change(true);
              },
        child: const FaIcon(
          FontAwesomeIcons.dollarSign,
          color: Color(0xFFFFFFFF),
        ),
        disabledElevation: 0.0,
      ),
    );
  }
}
