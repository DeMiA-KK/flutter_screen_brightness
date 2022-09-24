import 'package:flutter/material.dart';
import 'package:screen_brightness/screen_brightness.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const Center(
          child: ScreenBrightnessSlider(),
        ),
      ),
    );
  }
}

class ScreenBrightnessSlider extends StatefulWidget {
  const ScreenBrightnessSlider({super.key});

  @override
  State<ScreenBrightnessSlider> createState() => _ScreenBrightnessSliderState();
}

class _ScreenBrightnessSliderState extends State<ScreenBrightnessSlider> {
  double _brightness = 0;

  @override
  void initState() {
    super.initState();
    getScreenBrightness().then((value) {
      setState(() {
        _brightness = value ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('current brightness: $_brightness'),
        Slider(
          value: _brightness,
          onChanged: (value) async {
            await setScreenBrightness(_brightness);
            setState(() {
              _brightness = value;
            });
          },
        ),
      ],
    );
  }
}
