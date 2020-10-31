
# Flutter Admob App Open

Flutter bridge to Admob App Open Beta.

Supports using Admob App Open Beta.

![](https://developers.google.com/admob/images/app-open-ad.png)

## Supported platforms

- Android
- iOS comming soon

## Example Usage

```dart
void main() async {

  /// Replace your admob app ID
  final admobAppId = FlutterAdmobAppOpen.testAppId;

  /// Replace your admob app open ad unit id
  final appAppOpenAdUnitId = FlutterAdmobAppOpen.testAppOpenAdId;

  await FlutterAdmobAppOpen.instance.initialize(appId: admobAppId, appAppOpenAdUnitId: appAppOpenAdUnitId,);

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

