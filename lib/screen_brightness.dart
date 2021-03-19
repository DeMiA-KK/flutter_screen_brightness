import 'dart:async';

import 'package:flutter/services.dart';

class ScreenBrightness {
  static const _channel = MethodChannel('screen_brightness');

  static Future<double?> get brightness =>
      _channel.invokeMethod('getBrightness');

  static Future<void> setBrightness(double brightness) async {
    return _channel.invokeMethod('setBrightness', {'brightness': brightness});
  }
}

Future<double?> getScreenBrightness() => ScreenBrightness.brightness;

Future<void> setScreenBrightness(double brightness) =>
    ScreenBrightness.setBrightness(brightness);
