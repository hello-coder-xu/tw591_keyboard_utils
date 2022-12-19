import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tw591_keyboard_utils/listener/tw591_keyboard_listener.dart';
import 'package:tw591_keyboard_utils/model/keyboard_model.dart';

class Tw591KeyboardUtils {
  factory Tw591KeyboardUtils() => _getInstance();

  static Tw591KeyboardUtils get instance => _getInstance();
  static Tw591KeyboardUtils? _instance;

  EventChannel eventChannel = const EventChannel('tw591_keyboard_utils');

  Tw591KeyboardUtils._internal() {
    eventChannel.receiveBroadcastStream().listen(listenerKeyboardChanged);
  }

  static Tw591KeyboardUtils _getInstance() {
    _instance ??= Tw591KeyboardUtils._internal();
    return _instance!;
  }

  /// 监听事件
  final Map<int, Tw591KeyboardListener> listeners = {};

  /// 注册监听
  void registerChanged(Tw591KeyboardListener listener) {
    int tempHashCode = listener.hashCode;
    if (!listeners.containsKey(tempHashCode)) {
      listeners[tempHashCode] = listener;
    }
  }

  /// 注销监听
  void unRegisterChanged(Tw591KeyboardListener listener) {
    int tempHashCode = listener.hashCode;
    if (listeners.containsKey(tempHashCode)) {
      listeners.remove(tempHashCode);
    }
  }

  /// 软键盘变化
  void listenerKeyboardChanged(event) {
    print('test flutter 接收=$event');
    var temp = json.decode(event);
    KeyboardModel keyboardModel = KeyboardModel.fromJson(temp);
    listeners.forEach((key, value) {
      if (keyboardModel.isKeyboardOpen) {
        value.willShowKeyboard?.call(keyboardModel.keyboardHeight);
      } else {
        value.willHideKeyboard?.call();
      }
    });
  }
}
