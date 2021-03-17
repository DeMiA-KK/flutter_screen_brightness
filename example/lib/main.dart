import 'package:flutter/material.dart';
import 'package:screen_brightness/screen_brightness.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _brightness = 0;

  @override
  void initState() {
    super.initState();
    getScreenBrightness().then((value) {
      setState(() {
        _brightness = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Slider(
            value: _brightness,
            onChanged: (value) {
              setState(() {
                _brightness = value;
                setScreenBrightness(_brightness);
              });
            },
          ),
        ),
      ),
    );
  }
}
