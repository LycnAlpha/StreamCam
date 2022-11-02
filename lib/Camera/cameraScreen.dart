import 'package:cam/Camera/cameraViewer.dart';
import 'package:cam/Camera/captureButton.dart';
import 'package:cam/Camera/topImageViewer.dart';
import 'package:cam/Camera/topLable.dart';
import 'package:cam/scan_controller.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('Learning Centre'),
            backgroundColor: Colors.blue,
            automaticallyImplyLeading: false,
            leading: new IconButton(
                onPressed: () {},
                icon: new Icon(Icons.arrow_back, color: Colors.black)),
          ),
        ),

        CameraViewer(), CaptureButton(), //TopLable()
        //TopImageViewer()
      ],
    );
  }
}
