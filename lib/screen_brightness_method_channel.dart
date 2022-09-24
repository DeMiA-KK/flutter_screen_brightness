import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'screen_brightness_platform_interface.dart';

/// An implementation of [ScreenBrightnessPlatform] that uses method channels.
class MethodChannelScreenBrightness extends ScreenBrightnessPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('screen_brightness');

  @override
  Future<double?> getBrightness() {
    return methodChannel.invokeMethod('getBrightness');
  }

  @override
  Future<void> setBrightness(double brightness) async {
    final arguments = {'brightness': brightness};
    await methodChannel.invokeMethod('setBrightness', arguments);
  }
}
