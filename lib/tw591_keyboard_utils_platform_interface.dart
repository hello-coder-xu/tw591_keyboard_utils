import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:tw591_keyboard_utils/keyboard_listener.dart';

import 'tw591_keyboard_utils_method_channel.dart';

abstract class Tw591KeyboardUtilsPlatform extends PlatformInterface {
  /// Constructs a Tw591KeyboardUtilsPlatform.
  Tw591KeyboardUtilsPlatform() : super(token: _token);

  static final Object _token = Object();

  static Tw591KeyboardUtilsPlatform _instance =
      MethodChannelTw591KeyboardUtils();

  /// The default instance of [Tw591KeyboardUtilsPlatform] to use.
  ///
  /// Defaults to [MethodChannelTw591KeyboardUtils].
  static Tw591KeyboardUtilsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [Tw591KeyboardUtilsPlatform] when
  /// they register themselves.
  static set instance(Tw591KeyboardUtilsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  void addKeyboardChanged(KeyboardListener keyboardListener) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
