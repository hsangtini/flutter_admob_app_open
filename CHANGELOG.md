## 1.1.0

* dependencies google_mobile_ads (https://pub.dev/packages/google_mobile_ads) for the same.
* Removed testDevices, using updateRequestConfiguration from google_mobile_ads (https://pub.dev/packages/google_mobile_ads)
* Fix some errors.
* Thank you mattcianna (github) for fixed PR.

## 1.0.5

* Error version - don't using it !!! Upgrade to 1.1.0

## 1.0.3

* Working with updated google_mobile_ads (https://pub.dev/packages/google_mobile_ads).

* Fixed typo iOs, sorry :(

## 1.0.0

* [BREAKING] We now support flutter version 2.0 (null-safety), check out the [migration guide](https://dart.dev/null-safety/migration-guide).
* [BREAKING] Remove MobileAdTargetingInfo from firebase_admob because it will be deprecated in April 2021 (https://github.com/FirebaseExtended/flutterfire/tree/master/packages/firebase_admob).
* [BREAKING] Write new AdRequestAppOpen base from AdRequest from google_mobile_ads (https://pub.dev/packages/google_mobile_ads).

* Support pause and resume like that:
```dart
if (condition) {
  FlutterAdmobAppOpen.instance.pause();
} else {
  FlutterAdmobAppOpen.instance.resume();
}
```

## 0.0.6

* Update admob package

## 0.0.5

* Support MobileAdTargetingInfo from firebase_admob. You can use MobileAdTargetingInfo to target adslike keywords, childDirected, testDevices, ...
* Fixed duplicate ads on android.

## 0.0.4

* Support iOS.

## 0.0.3

* Added document.

## 0.0.1

* Initial release Admob app open beta.
