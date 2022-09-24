import 'package:flutter_test/flutter_test.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:screen_brightness/screen_brightness_platform_interface.dart';
import 'package:screen_brightness/screen_brightness_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockScreenBrightnessPlatform
    with MockPlatformInterfaceMixin
    implements ScreenBrightnessPlatform {
  @override
  Future<double?> getBrightness() => Future.value(1.0);

  @override
  Future<void> setBrightness(double brightness) async {}
}

void main() {
  final ScreenBrightnessPlatform initialPlatform =
      ScreenBrightnessPlatform.instance;

  test('$MethodChannelScreenBrightness is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelScreenBrightness>());
  });

  test('getScreenBrightness', () async {
    MockScreenBrightnessPlatform fakePlatform = MockScreenBrightnessPlatform();
    ScreenBrightnessPlatform.instance = fakePlatform;

    expect(await getScreenBrightness(), 1.0);
  });

  test('setScreenBrightness', () async {
    MockScreenBrightnessPlatform fakePlatform = MockScreenBrightnessPlatform();
    ScreenBrightnessPlatform.instance = fakePlatform;
    expect(setScreenBrightness(0), isA<Future<void>>());
  });
}
