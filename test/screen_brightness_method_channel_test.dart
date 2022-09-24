import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:screen_brightness/screen_brightness_method_channel.dart';

void main() {
  MethodChannelScreenBrightness platform = MethodChannelScreenBrightness();
  const MethodChannel channel = MethodChannel('screen_brightness');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'getBrightness':
          return Future.value(0.0);
        case 'setBrightness':
          return;
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getBrightness', () async {
    expect(await platform.getBrightness(), 0.0);
  });

  test('setBrightness', () async {
    expect(platform.setBrightness(0), isA<Future<void>>());
  });
}
