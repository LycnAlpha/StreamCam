import 'package:cam/Widgets/roundedButton.dart';
import 'package:cam/scan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CaptureButton extends GetView<ScanController> {
  const CaptureButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 30,
        child: RoundedButton(
            buttonName: "Start Detection",
            onPressed: () => controller.capture()));
  }
}
