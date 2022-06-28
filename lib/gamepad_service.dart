import 'package:flutter/services.dart';

class AndroidGamepadService {
  static const eventChannel =
      EventChannel('com.example.flutter_gamepad_android/gamepad_channel');

  Stream<dynamic> events() {
    return eventChannel.receiveBroadcastStream().map(_formatter);
  }

  Map<String, dynamic> _formatter(dynamic event) {
    final eventParameters = <String, dynamic>{};
    if (event != null && event is String) {
      event.split(',~').forEach((e) {
        var createPairList = e.split('=');
        eventParameters[createPairList[0]] = createPairList[1];
      });
    }
    return eventParameters;
  }
}
