# Flutter Admob App Open

[![pub package](https://img.shields.io/pub/v/flutter_admob_app_open.svg)](https://pub.dev/packages/flutter_admob_app_open)

#Discontinued

Project discontinued because google mobile ads has support App Open Ads. Please using google plugin.
https://pub.dev/packages/google_mobile_ads

Flutter bridge to Admob App Open Beta.

Supports using Admob App Open Beta. See https://developers.google.com/admob/android/app-open-ads for more information about Admob App Open.

<img src="https://developers.google.com/admob/images/app-open-ad.png" alt="drawing" height="400"/>

## Supported platforms

- Android
- iOS

## AndroidManifest changes

AdMob 17 requires the App ID to be included in the `AndroidManifest.xml`. Failure
to do so will result in a crash on launch of your app.  The line should look like:

```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="[ADMOB_APP_ID]"/>
```

where `[ADMOB_APP_ID]` is your App ID.  You must pass the same value when you
initialize the plugin in your Dart code.

See https://goo.gl/fQ2neu for more information about configuring `AndroidManifest.xml`
and setting up your App ID.

## Info.plist changes

Admob 7.42.0 requires the App ID to be included in `Info.plist`. Failure to do so will result in a crash on launch of your app. The lines should look like:

```xml
<key>GADApplicationIdentifier</key>
<string>[ADMOB_APP_ID]</string>
```

where `[ADMOB_APP_ID]` is your App ID.  You must pass the same value when you initialize the plugin in your Dart code.

See https://developers.google.com/admob/ios/quick-start#update_your_infoplist for more information about configuring `Info.plist` and setting up your App ID.

## Example Usage

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Replace your admob app open ad unit id
  final appAppOpenAdUnitId = FlutterAdmobAppOpen.testAppOpenAdId;


  /// Init MobileAds and more configs
  await MobileAds.instance.initialize().then((value) {
    MobileAds.instance.updateRequestConfiguration(
      //Add more configs
      RequestConfiguration(testDeviceIds: []),
    );
  });

  AdRequestAppOpen targetingInfo = AdRequestAppOpen(
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    nonPersonalizedAds: true,
  );

  /// Init App Open Ads
  await FlutterAdmobAppOpen.instance.initialize(
    appAppOpenAdUnitId: appAppOpenAdUnitId,
    targetingInfo: targetingInfo,
  );


  runApp(MyApp());
}
```

## Pause and Resume

```dart
if (condition) {
  FlutterAdmobAppOpen.instance.pause();
} else {
  FlutterAdmobAppOpen.instance.resume();
}
```

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.