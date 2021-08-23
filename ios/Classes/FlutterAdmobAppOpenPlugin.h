#import <Flutter/Flutter.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface FlutterAdmobAppOpenPlugin : NSObject<FlutterPlugin>
@property(strong, nonatomic) UIWindow* window;
@property(nonatomic) GADAppOpenAd* appOpenAd;
@property(nonatomic) NSDate *loadTime;
@property(nonatomic, retain) NSString *appAppOpenAdUnitId;
@property(nonatomic, retain) NSDictionary *targetingInfo;
@property(nonatomic) BOOL *pause;


- (void)requestAppOpenAd;
- (void)tryToPresentAd;
@end
