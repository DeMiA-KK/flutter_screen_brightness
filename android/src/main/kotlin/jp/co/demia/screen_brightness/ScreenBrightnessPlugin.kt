package jp.co.demia.screen_brightness

import android.app.Activity
import android.content.Context
import android.provider.Settings
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** ScreenBrightnessPlugin */
class ScreenBrightnessPlugin: FlutterPlugin, ActivityAware, MethodCallHandler {
  private lateinit var channel: MethodChannel
  private lateinit var context: Context
  private lateinit var activity: Activity

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "screen_brightness")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "getBrightness" -> {
        val brightness = activity.window.attributes.screenBrightness
        result.success(if (brightness >= 0) {
          brightness
        } else {
          try {
            Settings.System.getInt(context.contentResolver, Settings.System.SCREEN_BRIGHTNESS) / 255f
          } catch (e: Settings.SettingNotFoundException) {
            e.printStackTrace()
            1f
          }
        })
      }
      "setBrightness" -> {
        val brightness: Double? = call.argument("brightness")
        val layoutParams = activity.window.attributes
        if (brightness != null) {
          layoutParams.screenBrightness = brightness.toFloat()
          activity.window.attributes = layoutParams
        }
        result.success(null)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    onAttachedToActivity(binding)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onDetachedFromActivity() {}

  override fun onDetachedFromActivityForConfigChanges() {
    onDetachedFromActivity()
  }
}
