import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_admob_app_open/ad_request_app_open.dart';

export 'ad_request_app_open.dart';

class FlutterAdmobAppOpen {
  static final FlutterAdmobAppOpen _instance = FlutterAdmobAppOpen._();

  static FlutterAdmobAppOpen get instance => _instance;

  static const MethodChannel _channel = const MethodChannel('flutter_admob_app_open');

  /// {@macro firebase_admob.testAdUnitId}
  static final String testAppId = Platform.isAndroid ? 'ca-app-pub-3940256099942544~3347511713' : 'ca-app-pub-3940256099942544~1458002511';

  /// {@macro firebase_admob.testAdUnitId}
  static final String testAppOpenAdId = Platform.isAndroid ? 'ca-app-pub-3940256099942544/1033173712' : 'ca-app-pub-3940256099942544/5662855259';

  FlutterAdmobAppOpen._();

  /// Initialize this plugin for the AdMob app specified by `appId`.
  /// If appAppOpenAdUnitId null, App Open ads will disable
  Future<bool?> initialize({
    required String appId,
    String? appAppOpenAdUnitId,
    AdRequestAppOpen? targetingInfo,
  }) {
    assert(appId.isNotEmpty);

    return _channel.invokeMethod<bool>(
      'initialize',
      <String, dynamic>{
        'appId': appId,
        'appAppOpenAdUnitId': appAppOpenAdUnitId,
        'targetingInfo': targetingInfo?.toJson(),
      },
    );
  }

  Future<bool?> pause() {
    return _channel.invokeMethod<bool>('pause');
  }

  Future<bool?> resume() {
    return _channel.invokeMethod<bool>('resume');
  }
}
