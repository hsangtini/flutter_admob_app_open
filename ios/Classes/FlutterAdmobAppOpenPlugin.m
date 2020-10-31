#import "FlutterAdmobAppOpenPlugin.h"
#if __has_include(<flutter_admob_app_open/flutter_admob_app_open-Swift.h>)
#import <flutter_admob_app_open/flutter_admob_app_open-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_admob_app_open-Swift.h"
#endif

@implementation FlutterAdmobAppOpenPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterAdmobAppOpenPlugin registerWithRegistrar:registrar];
}
@end
