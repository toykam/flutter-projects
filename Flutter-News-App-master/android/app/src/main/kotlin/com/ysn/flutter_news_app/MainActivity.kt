package com.ysn.flutter_news_app

import android.os.Bundle
import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
  private val CHANNEL = "com.ysn.flutter_news_app/Printy";
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    MethodChannel(flutterView, CHANNEL).setMethodCallHandler{
      methodCall, result ->
      if (methodCall.method == "Printy") {
        result.success("Hello From Kotlin World")

      }
    }
  }
}
