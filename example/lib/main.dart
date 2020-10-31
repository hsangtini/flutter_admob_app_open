import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_admob_app_open/flutter_admob_app_open.dart';

void main() async {

  /// Replace your admob app ID
  final admobAppId = FlutterAdmobAppOpen.testAppId;

  /// Replace your admob app open ad unit id
  final appAppOpenAdUnitId = FlutterAdmobAppOpen.testAppOpenAdId;

  await FlutterAdmobAppOpen.instance.initialize(appId: admobAppId, appAppOpenAdUnitId: appAppOpenAdUnitId,);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on'),
        ),
      ),
    );
  }
}
