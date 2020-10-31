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

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS "
                stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else if ([@"initialize" isEqualToString:call.method]) {
        NSString *appId = myArgs["appId"] as? String,
        NSString *appAppOpenAdUnitId = myArgs["appAppOpenAdUnitId"] as? String,
        self.appId = appId
        self.appAppOpenAdUnitId = appAppOpenAdUnitId
        if (appId == null || appId.isEmpty()) {
            result(FlutterError(code: "no_app_id", message: "a null or empty AdMob appId was provided", details: nil))
            return
        }
        [GADMobileAds configureWithApplicationID:appId];
        result(true)
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  [self tryToPresentAd];
}

- (void)requestAppOpenAd {
  self.appOpenAd = nil;
  [GADAppOpenAd loadWithAdUnitID:self.appAppOpenAdUnitId
                         request:[GADRequest request]
                     orientation:UIInterfaceOrientationPortrait
               completionHandler:^(GADAppOpenAd *_Nullable appOpenAd, NSError *_Nullable error) {
                 if (error) {
                   NSLog(@"Failed to load app open ad: %@", error);
                   return;
                 }
                 self.appOpenAd = appOpenAd;
                 self.appOpenAd.fullScreenContentDelegate = self;
                 self.loadTime = [NSDate date];
               }];
}

#pragma mark - GADFullScreenContentDelegate

/// Tells the delegate that the ad failed to present full screen content.
- (void)ad:(nonnull id<GADFullScreenPresentingAd>)ad
    didFailToPresentFullScreenContentWithError:(nonnull NSError *)error {
  NSLog(@"didFailToPresentFullSCreenCContentWithError");
  [self requestAppOpenAd];

}

/// Tells the delegate that the ad presented full screen content.
- (void)adDidPresentFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
  NSLog(@"adDidPresentFullScreenContent");
}

/// Tells the delegate that the ad dismissed full screen content.
- (void)adDidDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
  NSLog(@"adDidDismissFullScreenContent");
  [self requestAppOpenAd];
}

- (BOOL)wasLoadTimeLessThanNHoursAgo:(int)n {
  NSDate *now = [NSDate date];
  NSTimeInterval timeIntervalBetweenNowAndLoadTime = [now timeIntervalSinceDate:self.loadTime];
  double secondsPerHour = 3600.0;
  double intervalInHours = timeIntervalBetweenNowAndLoadTime / secondsPerHour;
  return intervalInHours < n;
}

- (void)tryToPresentAd {
  GADAppOpenAd *ad = self.appOpenAd;
  self.appOpenAd = nil;
  if (ad && [self wasLoadTimeLessThanNHoursAgo:4]) {
    UIViewController *rootController = self.window.rootViewController;
    [ad presentFromRootViewController:rootController];

  } else {
    // If you don't have an ad ready, request one.
    [self requestAppOpenAd];
  }
}

@end
