import 'dart:async';

import 'package:android_gamepad_flutter/gamepad_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Gamepad extends StatefulWidget {
  const Gamepad({Key? key}) : super(key: key);

  @override
  State<Gamepad> createState() => _GamepadState();
}

class _GamepadState extends State<Gamepad> {
  final _leftAxis = _Axis();
  final _gamePadService = AndroidGamepadService();
  StreamSubscription? _gamepadSub;
  String key = '';
  String value = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
            child: Text('Value: $value', style: const TextStyle(fontSize: 15))),
      ],
    )));
  }

  @override
  void initState() {
    _listenToGamepad();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    _gamepadSub?.cancel();
    super.dispose();
  }

  _listenToGamepad() {
    _gamepadSub = _gamePadService.events().listen((event) {
      setState(() {
        value = event.toString();
      });
    });
  }
}

class _Axis {
  String x = '0';
  String y = '0';
}
