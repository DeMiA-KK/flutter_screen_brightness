import 'screen_brightness_platform_interface.dart';

ScreenBrightnessPlatform get _platform => ScreenBrightnessPlatform.instance;

Future<double?> getScreenBrightness() => _platform.getBrightness();

Future<void> setScreenBrightness(double brightness) =>
    _platform.setBrightness(brightness);
