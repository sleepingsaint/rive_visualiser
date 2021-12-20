import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class GrowTree extends StatefulWidget {
  const GrowTree({Key? key}) : super(key: key);

  @override
  GrowTreeState createState() => GrowTreeState();
}

class GrowTreeState extends State<GrowTree> {
  SMINumber? _growth;

  void _initRive(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      "State Machine 1",
    );

    artboard.addController(controller!);

    _growth = controller.inputs.first as SMINumber;
    _growth?.change(0.0);
  }

  final Color _themeColor = const Color(0xFF4D4C61);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grow Tree"),
        backgroundColor: _themeColor,
      ),
      body: GestureDetector(
        onVerticalDragUpdate: _handleDragUpdate,
        child: SizedBox(
          child: RiveAnimation.asset(
            "assets/rive/tree.riv",
            fit: BoxFit.contain,
            onInit: _initRive,
            animations: const ["in"],
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
    _growth?.change(prev - (details.delta.dy));
  }
}
