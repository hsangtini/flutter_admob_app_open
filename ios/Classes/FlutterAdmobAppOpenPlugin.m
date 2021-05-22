#import "FlutterAdmobAppOpenPlugin.h"
#import "FLTRequestFactoryCustom.h"

@implementation FlutterAdmobAppOpenPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
        methodChannelWithName:@"flutter_admob_app_open"
              binaryMessenger:[registrar messenger]];
    FlutterAdmobAppOpenPlugin* instance = [[FlutterAdmobAppOpenPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    [registrar addApplicationDelegate:instance];
    
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    
    
    
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS "
                stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else if ([@"initialize" isEqualToString:call.method]) {

        NSString *appId = (NSString *)call.arguments[@"appId"];
        NSString *appAppOpenAdUnitId = (NSString *)call.arguments[@"appAppOpenAdUnitId"];
        NSDictionary *targetingInfo = (NSDictionary *)call.arguments[@"targetingInfo"];


        self.appId = appId;
        self.appAppOpenAdUnitId = appAppOpenAdUnitId;
        self.targetingInfo = targetingInfo;
        self.pause = NO;

        if (appId == nil || [appId  isEqual: @""]) {
            result([FlutterError errorWithCode:@"no_app_id" message:@"a null or empty AdMob appId was provided" details:nil]);
            return;
        }
        [[GADMobileAds sharedInstance] startWithCompletionHandler:nil];
        [self requestAppOpenAd];
        result([NSNumber numberWithBool:YES]);
    }else if ([@"pause" isEqualToString:call.method]) {

        self.pause = YES;

        result([NSNumber numberWithBool:YES]);
    }else if ([@"resume" isEqualToString:call.method]) {

        self.pause = NO;

        result([NSNumber numberWithBool:YES]);
    } else if ([@"setTestDevices" isEqualToString:call.method]) {
       GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers = call.arguments;
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self tryToPresentAd:application.keyWindow];
}

- (void)requestAppOpenAd {

    NSString *appAppOpenAdUnitId = (NSString *) self.appAppOpenAdUnitId;
    
    if(appAppOpenAdUnitId == nil) {
        return;
    }
    
    self.appOpenAd = nil;

    FLTRequestFactoryCustom *factory = [[FLTRequestFactoryCustom alloc] initWithTargetingInfo:(NSDictionary *) self.targetingInfo];
  [GADAppOpenAd loadWithAdUnitID:appAppOpenAdUnitId
                         request:[factory createRequest]
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

- (void)tryToPresentAd:(UIWindow *)window {
    if(self.pause == NO) {
          GADAppOpenAd *ad = self.appOpenAd;
          self.appOpenAd = nil;
          if (ad && [self wasLoadTimeLessThanNHoursAgo:4]) {
            UIViewController *rootController = window.rootViewController;
            [ad presentFromRootViewController:rootController];

          } else {
            // If you don't have an ad ready, request one.
            [self requestAppOpenAd];
          }
    }
}

@end
