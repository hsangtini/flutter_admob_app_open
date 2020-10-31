#import <Flutter/Flutter.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface FlutterAdmobAppOpenPlugin : NSObject<FlutterPlugin>
@property(strong, nonatomic) UIWindow* window;
@property(nonatomic) GADAppOpenAd* appOpenAd;
@property(weak, nonatomic) NSDate *loadTime;
@property(weak, nonatomic) NSString *appId;
@property(weak, nonatomic) NSString *appAppOpenAdUnitId;

- (void)requestAppOpenAd;
- (void)tryToPresentAd;
@end
