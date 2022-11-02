import 'package:cam/scan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopLable extends GetView {
  const TopLable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 50,
        child: TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Enter Name',
              hintText: 'Enter Your Name'),
        ));
  }
}
