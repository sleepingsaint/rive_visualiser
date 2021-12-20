import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class WaterBar extends StatefulWidget {
  const WaterBar({Key? key}) : super(key: key);

  @override
  WaterBarState createState() => WaterBarState();
}

class WaterBarState extends State<WaterBar> {
  SMINumber? _growth;

  void _initRive(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      "State Machine",
    );

    artboard.addController(controller!);

    _growth = controller.inputs.first as SMINumber;
    _growth?.change(0.0);
  }

  final Color _themeColor = const Color(0xFF171C2B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Water Bar"),
        backgroundColor: _themeColor,
      ),
      body: GestureDetector(
        onVerticalDragUpdate: _handleDragUpdate,
        child: SizedBox(
          child: RiveAnimation.asset(
            "assets/rive/water_bar.riv",
            fit: BoxFit.contain,
            onInit: _initRive,
            animations: const ["Low"],
          ),
        ),
      ),
    );
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    double prev = 0.0;
    if (_growth != null) {
      prev = _growth!.value;
    }
    _growth?.change(prev - details.delta.dy);
  }
}
