import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class TeddyLogin extends StatefulWidget {
  const TeddyLogin({Key? key}) : super(key: key);

  @override
  TeddyLoginState createState() => TeddyLoginState();
}

class TeddyLoginState extends State<TeddyLogin> {
  SMITrigger? _success, _fail;
  SMIBool? _check, _handsup;
  SMINumber? _look;

  bool isLocked = false;

  void _initRive(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      "State Machine 1",
      onStateChange: _onStateChange,
    );

    artboard.addController(controller!);
    _check = controller.inputs.elementAt(0) as SMIBool;
    _look = controller.inputs.elementAt(1) as SMINumber;
    _success = controller.inputs.elementAt(2) as SMITrigger;
    _fail = controller.inputs.elementAt(3) as SMITrigger;
    _handsup = controller.inputs.elementAt(4) as SMIBool;
  }

  void _onStateChange(_, String state) {
    if (state == "idle") {
      setState(() {
        isLocked = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Teddy Login")),
      body: SizedBox(
        child: RiveAnimation.asset(
          "assets/rive/teddy_login.riv",
          fit: BoxFit.contain,
          onInit: _initRive,
          animations: const ["look_idle"],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: isLocked
                ? null
                : () {
                    _success?.change(true);
                    setState(() {
                      isLocked = true;
                    });
                  },
            child: const Icon(Icons.done),
          ),
          FloatingActionButton(
            onPressed: isLocked
                ? null
                : () {
                    _fail?.change(true);
                    setState(() {
                      isLocked = true;
                    });
                  },
            child: const Icon(Icons.error),
          ),
          FloatingActionButton(
            onPressed: isLocked
                ? null
                : () {
                    _handsup?.change(true);
                    setState(() {
                      isLocked = true;
                    });
                  },
            child: const Icon(Icons.remove_red_eye),
          )
        ],
      ),
    );
  }
}
