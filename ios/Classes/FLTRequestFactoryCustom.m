// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "FLTRequestFactoryCustom.h"
#import "GoogleMobileAds/GADExtras.h"
#import "GoogleMobileAds/GoogleMobileAds.h"

@implementation FLTRequestFactoryCustom {
  NSDictionary *_targetingInfo;
}

- (instancetype)initWithTargetingInfo:(NSDictionary *)targetingInfo {
  self = [super init];
  if (self) {
    _targetingInfo = targetingInfo;
  }
  return self;
}

- (NSArray *)targetingInfoArrayForKey:(NSString *)key info:(NSDictionary *)info {
  NSObject *value = info[key];
  if (value == NULL) {
    return nil;
  }
  if (![value isKindOfClass:[NSArray class]]) {
    NSLog(@"targeting info %@: expected an array (MobileAd %@)", key, self);
    return nil;
  }
  return (NSArray *)value;
}

- (NSString *)targetingInfoStringForKey:(NSString *)key info:(NSDictionary *)info {
  NSObject *value = info[key];
  if (value == NULL) {
    return nil;
  }
  if (![value isKindOfClass:[NSString class]]) {
    NSLog(@"targeting info %@: expected a string (MobileAd %@)", key, self);
    return nil;
  }
  NSString *stringValue = (NSString *)value;
  if ([stringValue length] == 0) {
    NSLog(@"targeting info %@: expected a non-empty string (MobileAd %@)", key, self);
    return nil;
  }
  return stringValue;
}

- (NSNumber *)targetingInfoBoolForKey:(NSString *)key info:(NSDictionary *)info {
  NSObject *value = info[key];
  if (value == NULL) {
    return nil;
  }
  if (![value isKindOfClass:[NSNumber class]]) {
    NSLog(@"targeting info %@: expected a boolean, (MobileAd %@)", key, self);
    return nil;
  }
  return (NSNumber *)value;
}

- (GADRequest *)createRequest {
  GADRequest *request = [GADRequest request];
  if (_targetingInfo == nil) {
    return request;
  }

  NSArray *keywords = [self targetingInfoArrayForKey:@"keywords" info:_targetingInfo];
  if (keywords != nil) {
    request.keywords = keywords;
  }

  NSString *contentURL = [self targetingInfoStringForKey:@"contentUrl" info:_targetingInfo];
  if (contentURL != nil) {
    request.contentURL = contentURL;
  }

  NSNumber *nonPersonalizedAds = [self targetingInfoBoolForKey:@"nonPersonalizedAds"
                                                          info:_targetingInfo];
  if (nonPersonalizedAds != nil && [nonPersonalizedAds boolValue]) {
    GADExtras *extras = [[GADExtras alloc] init];
    extras.additionalParameters = @{@"npa" : @"1"};
    [request registerAdNetworkExtras:extras];
  }

  return request;
}

@end
