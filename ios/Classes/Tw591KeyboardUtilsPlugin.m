#import "Tw591KeyboardUtilsPlugin.h"
#if __has_include(<tw591_keyboard_utils/tw591_keyboard_utils-Swift.h>)
#import <tw591_keyboard_utils/tw591_keyboard_utils-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "tw591_keyboard_utils-Swift.h"
#endif

@implementation Tw591KeyboardUtilsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTw591KeyboardUtilsPlugin registerWithRegistrar:registrar];
}
@end
