import 'package:tw591_keyboard_utils/model/safe_convert.dart';

class KeyboardModel {
  final bool isKeyboardOpen;
  final double keyboardHeight;

  KeyboardModel({
    this.isKeyboardOpen = false,
    this.keyboardHeight = 0,
  });

  factory KeyboardModel.fromJson(Map<String, dynamic>? json) => KeyboardModel(
        isKeyboardOpen: asBool(json, 'isKeyboardOpen'),
        keyboardHeight: asDouble(json, 'keyboardHeight'),
      );

  Map<String, dynamic> toJson() => {
        'isKeyboardOpen': isKeyboardOpen,
        'keyboardHeight': keyboardHeight,
      };
}
