import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SafeBox extends StatefulWidget {
  const SafeBox({Key? key}) : super(key: key);

  @override
  SafeBoxState createState() => SafeBoxState();
}

class SafeBoxState extends State<SafeBox> {
  SMITrigger? _pressed;
  bool _closed = true;

  void _initRive(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      "State Machine 1",
    );

    artboard.addController(controller!);
    _pressed = controller.inputs.first as SMITrigger;
  }

  final Color _themeColor = const Color(0xFF2F1E3E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Safe Box"),
        backgroundColor: _themeColor,
      ),
      body: SizedBox(
        child: RiveAnimation.asset(
          "assets/rive/safe_box.riv",
          fit: BoxFit.contain,
          onInit: _initRive,
          animations: const ["Idle"],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _themeColor,
        onPressed: () {
          _pressed?.change(true);

          setState(() {
            _closed = !_closed;
          });
        },
        child: Icon(
          _closed ? Icons.lock : Icons.lock_open,
          color: const Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}
