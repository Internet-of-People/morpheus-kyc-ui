#import "NativeSdkPlugin.h"
#if __has_include(<native_sdk/native_sdk-Swift.h>)
#import <native_sdk/native_sdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "native_sdk-Swift.h"
#endif

@implementation NativeSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNativeSdkPlugin registerWithRegistrar:registrar];
}
@end
