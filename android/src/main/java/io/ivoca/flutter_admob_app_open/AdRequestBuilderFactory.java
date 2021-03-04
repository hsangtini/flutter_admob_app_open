// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.ivoca.flutter_admob_app_open;

import android.os.Bundle;
import android.util.Log;

import com.google.ads.mediation.admob.AdMobAdapter;
import com.google.android.gms.ads.AdRequest;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

class AdRequestBuilderFactory {

  private static final String TAG = "flutter";
  private final Map<String, Object> targetingInfo;

  AdRequestBuilderFactory(Map<String, Object> targetingInfo) {
    this.targetingInfo = targetingInfo;
  }

  private String getTargetingInfoString(String key, Object value) {
    if (value == null) return null;
    if (!(value instanceof String)) {
      Log.w(TAG, "targeting info " + key + ": expected a String");
      return null;
    }
    String stringValue = (String) value;
    if (stringValue.isEmpty()) {
      Log.w(TAG, "targeting info " + key + ": expected a non-empty String");
      return null;
    }
    return stringValue;
  }

  private Boolean getTargetingInfoBoolean(String key, Object value) {
    if (value == null) return null;
    if (!(value instanceof Boolean)) {
      Log.w(TAG, "targeting info " + key + ": expected a boolean");
      return null;
    }
    return (Boolean) value;
  }

  private Integer getTargetingInfoInteger(String key, Object value) {
    if (value == null) return null;
    if (!(value instanceof Integer)) {
      Log.w(TAG, "targeting info " + key + ": expected an integer");
      return null;
    }
    return (Integer) value;
  }

  private List getTargetingInfoArrayList(String key, Object value) {
    if (value == null) return null;
    if (!(value instanceof ArrayList)) {
      Log.w(TAG, "targeting info " + key + ": expected an ArrayList");
      return null;
    }
    return (List) value;
  }

  AdRequest.Builder createAdRequestBuilder() {
    AdRequest.Builder builder = new AdRequest.Builder();
    if (targetingInfo == null) return builder;

    List testDevices = getTargetingInfoArrayList("testDevices", targetingInfo.get("testDevices"));
    if (testDevices != null) {
      for (Object deviceValue : testDevices) {
        String device = getTargetingInfoString("testDevices element", deviceValue);
        if (device != null) builder.addTestDevice(device);
      }
    }

    List keywords = getTargetingInfoArrayList("keywords", targetingInfo.get("keywords"));
    if (keywords != null) {
      for (Object keywordValue : keywords) {
        String keyword = getTargetingInfoString("keywords element", keywordValue);
        if (keyword != null) builder.addKeyword(keyword);
      }
    }

    String contentUrl = getTargetingInfoString("contentUrl", targetingInfo.get("contentUrl"));
    if (contentUrl != null) builder.setContentUrl(contentUrl);

    Boolean nonPersonalizedAds =
        getTargetingInfoBoolean("nonPersonalizedAds", targetingInfo.get("nonPersonalizedAds"));
    if (nonPersonalizedAds != null && nonPersonalizedAds) {
      Bundle extras = new Bundle();
      extras.putString("npa", "1");
      builder.addNetworkExtrasBundle(AdMobAdapter.class, extras);
    }

    return builder;
  }
}
