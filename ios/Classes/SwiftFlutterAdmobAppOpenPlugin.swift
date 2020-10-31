import Flutter
import UIKit

public class SwiftFlutterAdmobAppOpenPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_admob_app_open", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterAdmobAppOpenPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
