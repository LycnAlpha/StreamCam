import 'package:cam/Camera/cameraScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'global_bindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const CameraScreen(),
      title: "Camera App",
      initialBinding: GlobalBindings(),
      debugShowCheckedModeBanner: false,
    );
  }
}
