
# Flutter Admob App Open

Flutter bridge to Admob App Open Beta.

Supports using Admob App Open Beta.

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

  /// Replace your admob app ID
  final admobAppId = FlutterAdmobAppOpen.testAppId;

  /// Replace your admob app open ad unit id
  final appAppOpenAdUnitId = FlutterAdmobAppOpen.testAppOpenAdId;

  await FlutterAdmobAppOpen.instance.initialize(
    appId: admobAppId,
    appAppOpenAdUnitId: appAppOpenAdUnitId,
  );

  runApp(MyApp());
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

