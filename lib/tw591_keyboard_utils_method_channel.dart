import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tw591_keyboard_utils/keyboard_listener.dart';

import 'tw591_keyboard_utils_platform_interface.dart';

/// An implementation of [Tw591KeyboardUtilsPlatform] that uses method channels.
class MethodChannelTw591KeyboardUtils extends Tw591KeyboardUtilsPlatform {
  /// The method channel used to interact with the native platform.

  final eventChannel = const EventChannel('tw591_keyboard_utils');

  @override
  void addKeyboardChanged(KeyboardListener keyboardListener) async {
    eventChannel.receiveBroadcastStream().listen((event) {
      print('test flutter 接收=$event');
      var temp = json.decode(event);
      bool open = temp['isKeyboardOpen'];
      print('test flutter 接收 open=$open');
      int keyboardHeight = temp['keyboardHeight'];
      if (open) {
        keyboardListener.willShowKeyboard?.call(keyboardHeight * 1.0);
      } else {
        keyboardListener.willHideKeyboard?.call();
      }
    });
  }
}
