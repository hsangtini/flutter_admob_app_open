package io.ivoca.flutter_admob_app_open;

import android.app.Activity;
import android.app.Application;
import android.content.Context;

import androidx.annotation.NonNull;

import com.google.android.gms.ads.MobileAds;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterAdmobAppOpenPlugin */
public class FlutterAdmobAppOpenPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;


  private Context applicationContext;
  private AppOpenManager appOpenManager;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_admob_app_open");
    channel.setMethodCallHandler(this);

    applicationContext = flutterPluginBinding.getApplicationContext();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("initialize")) {

      String appId = call.argument("appId");
      String appAppOpenAdUnitId = call.argument("appAppOpenAdUnitId");
      if (appId == null || appId.isEmpty()) {
        result.error("no_app_id", "a null or empty AdMob appId was provided", null);
        return;
      }
      
      MobileAds.initialize(applicationContext, appId);

      if(appAppOpenAdUnitId != null && appOpenManager == null) {
        this.appOpenManager = new AppOpenManager((Application) applicationContext, appAppOpenAdUnitId);
      }

      result.success(Boolean.TRUE);

    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }


}
