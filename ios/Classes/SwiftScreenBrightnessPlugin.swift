import Flutter
import UIKit

public class SwiftScreenBrightnessPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "screen_brightness", binaryMessenger: registrar.messenger())
    let instance = SwiftScreenBrightnessPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "getBrightness" {
      result(NSNumber(value: UIScreen.main.brightness.native))
    } else if call.method == "setBrightness" {
      if let args = call.arguments as? Dictionary<String, Any>,
         let brightness = args["brightness"] as? NSNumber {
        UIScreen.main.brightness = CGFloat.init(truncating: brightness)
      }
      result(nil)
    }
  }
}
