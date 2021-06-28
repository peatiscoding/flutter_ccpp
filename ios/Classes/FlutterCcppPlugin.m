#import "FlutterCcppPlugin.h"
#if __has_include(<flutter_ccpp/flutter_ccpp-Swift.h>)
#import <flutter_ccpp/flutter_ccpp-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_ccpp-Swift.h"
#endif

@implementation FlutterCcppPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterCcppPlugin registerWithRegistrar:registrar];
}
@end
