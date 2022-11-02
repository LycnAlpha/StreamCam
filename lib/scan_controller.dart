import 'dart:typed_data';
import 'package:tflite/tflite.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;

class ScanController extends GetxController {
  final RxBool _isInitialized = RxBool(false);
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  late CameraImage _cameraImage;
  final RxList<Uint8List> _imageList = RxList([]);
  int _imageCount = 0;

  List<Uint8List> get imageList => _imageList;
  bool get isInitialized => _isInitialized.value;
  CameraController get cameraController => _cameraController;

  @override
  void dispose() {
    _isInitialized.value = false;
    _cameraController.dispose();
    Tflite.close();
    super.dispose();
  }

  Future<void> _initTensorFlow() async {
    String? res = await Tflite.loadModel(
        model: "assets/ssd_mobilenet_v1_1_metadata_1.tflite",
        labels: "assets/labels.txt",
        numThreads: 1, // defaults to 1
        isAsset:
            true, // defaults to true, set to false to load resources outside assets
        useGpuDelegate:
            false // defaults to false, set to true to use GPU delegate
        );

    print(res);
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.high);
    _cameraController.initialize().then((_) {
      _isInitialized.value = true;

      _cameraController.startImageStream((image) {
        _imageCount++;
        if (_imageCount % 20 == 0) {
          _imageCount = 0;
          _gestureDetection(image);
        }
      });

      //  _cameraController.startImageStream((image) => _cameraImage = image);
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  @override
  void onInit() {
    _initCamera();
    _initTensorFlow();
    super.onInit();
  }

  Future<void> _gestureDetection(CameraImage cameraImage) async {
    var recognitions = await Tflite.runModelOnFrame(
        bytesList: cameraImage.planes.map((plane) {
          return plane.bytes;
        }).toList(), // required
        imageHeight: cameraImage.height,
        imageWidth: cameraImage.width,
        imageMean: 127.5, // defaults to 127.5
        imageStd: 127.5, // defaults to 127.5
        rotation: 90, // defaults to 90, Android only
        numResults: 2, // defaults to 5
        threshold: 0.1, // defaults to 0.1
        asynch: true // defaults to true
        );
    print(recognitions);
  }

  void capture() {
    img.Image image = img.Image.fromBytes(
        _cameraImage.width, _cameraImage.height, _cameraImage.planes[0].bytes,
        format: img.Format.bgra);

    Uint8List jpeg = Uint8List.fromList(img.encodeJpg(image));

    //_gestureDetection(_cameraImage);

    print("Image captured");

    _imageList.add(jpeg);
    _imageList.refresh();
  }
}
