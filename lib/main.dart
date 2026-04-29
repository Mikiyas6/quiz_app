import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:quiz_app/start_screen.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        home: Scaffold(body: StartScreen()),
      ),
    ),
  );
}
