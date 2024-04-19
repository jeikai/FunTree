import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funtree/backend/backend.dart';
import 'package:funtree/core/SharePref.dart';
import 'package:funtree/core/inventory/tree.dart';
import 'package:funtree/core/map/map.dart';
import 'package:funtree/core/utils/image_constant.dart';
import 'package:funtree/core/utils/size_utils.dart';
import 'package:funtree/presentation/homescreen_screen/homescreen_screen.dart';
import 'package:funtree/widgets/ToastNoti.dart';
import 'package:funtree/widgets/custom_icon_button.dart';
import 'package:funtree/widgets/custom_image_view.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';

final ObjectDetector objectDetector = GoogleMlKit.vision.objectDetector(
    options: ObjectDetectorOptions(
        mode: DetectionMode.stream,
        classifyObjects: true,
        multipleObjects: false));
final ImageLabeler imageLabeler = GoogleMlKit.vision.imageLabeler();

onImage(InputImage inputImage) async {
  // final List<DetectedObject> labels = await objectDetector.processImage(inputImage);
  // String result = '';
  // for (DetectedObject object in labels) {
  //   if(!object.labels.every((element) => element.text == 'Plant')) continue;
  //   result = object.labels.map((e) => e.text).join(', ') + '\n';
  //   result += ' - ${object.boundingBox.left}, ${object.boundingBox.top}, ${object.boundingBox.width}, ${object.boundingBox.height} - ${object.trackingId}\n';
  //   break;
  // }
  // print(' [$result]');
}

class CameraView extends StatefulWidget {
  CameraView(
      {Key? key,
      required this.onImage,
      this.onCameraFeedReady,
      this.onDetectorViewModeChanged,
      this.onCameraLensDirectionChanged,
      this.initialCameraLensDirection = CameraLensDirection.back})
      : super(key: key);

  final Function(InputImage inputImage) onImage;
  final VoidCallback? onCameraFeedReady;
  final VoidCallback? onDetectorViewModeChanged;
  final Function(CameraLensDirection direction)? onCameraLensDirectionChanged;
  final CameraLensDirection initialCameraLensDirection;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  ValueNotifier<bool> _isSearch = ValueNotifier<bool>(false);

  static List<CameraDescription> _cameras = [];
  CameraController? _controller;
  int _cameraIndex = -1;
  double _currentZoomLevel = 1.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _currentExposureOffset = 0.0;
  bool _changingCameraLens = false;

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  void _initialize() async {
    if (_cameras.isEmpty) {
      _cameras = await availableCameras();
    }
    for (var i = 0; i < _cameras.length; i++) {
      if (_cameras[i].lensDirection == widget.initialCameraLensDirection) {
        _cameraIndex = i;
        break;
      }
    }
    if (_cameraIndex != -1) {
      _startLiveFeed();
    }
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 800.v,
          width: 360.h,
          child: _liveFeedBody(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _buildFiftySix(context),
        ),
      ],
    );
  }

  Widget _liveFeedBody() {
    final Loading = Center(
      child: CircularProgressIndicator(),
    );
    if (_cameras.isEmpty) return Container();
    if (_controller == null) return Loading;
    if (_controller?.value.isInitialized == false) return Loading;
    return Stack(
      children: [
        SizedBox(
          height: 800.v,
          width: 360.h,
          child: CameraPreview(_controller!),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _buildFiftySix(context),
        ),
        ValueListenableBuilder(
            valueListenable: _isSearch,
            builder: (context, value, child) {
              return value
                  ? Container(
                      color: Colors.white.withOpacity(0.5),
                      height: 800.v,
                      width: 360.h,
                      child: Loading)
                  : SizedBox();
            }),
      ],
    );
  }

  /// Section Widget
  Widget _buildFiftySix(BuildContext context) {
    return Container(
        height: 180.v,
        child: Stack(children: [
          Center(
              child: CustomIconButton(
                  height: 80.adaptSize,
                  width: 80.adaptSize,
                  padding: EdgeInsets.all(19.h),
                  child:
                      CustomImageView(imagePath: ImageConstant.imgSearch80x80),
                  onTap: () {
                    onSearch();
                  })),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                  padding: EdgeInsets.only(
                      bottom: 10.adaptSize, right: 10.adaptSize),
                  child: CustomIconButton(
                      height: 40.adaptSize,
                      width: 40.adaptSize,
                      padding: EdgeInsets.all(10.h),
                      child: CustomImageView(
                          imagePath: ImageConstant.imgGroup6)))),
        ]));
  }

  onSearch() async {
    try {
      final image = await _controller?.takePicture();
      _controller?.pausePreview();
      _isSearch.value = true;
      final bytes = await image?.readAsBytes();
      print("Before call api");
      final response = await sendToApi(Uint8List.fromList(bytes!));
      if (response != null) {
        print(response);
        final data = response['data'];
        final tree = data['tree'];
        final t = Tree(
            id: tree['id'], name: tree['name'], imagePath: tree['imageUrl']);
        treeList.add(t);
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        ToastNoti.show("No plant detected");
      }
      _isSearch.value = false;
      _controller?.resumePreview();
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> sendToApi(Uint8List bytes) async {
    final data = <String, dynamic>{};
    data['images'] = bytes;
    data['lat'] = (await SharePref.getLangtitude()!);
    data['lng'] = (await SharePref.getLongtitude()!);
    print(data);
    var response = Api().postData("plant/identification", data);
    return response;
  }

  Future _startLiveFeed() async {
    final camera = _cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      // Set to ResolutionPreset.high. Do NOT set it to ResolutionPreset.max because for some phones does NOT work.
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller?.getMinZoomLevel().then((value) {
        _currentZoomLevel = value;
        _minAvailableZoom = value;
      });
      _controller?.getMaxZoomLevel().then((value) {
        _maxAvailableZoom = value;
      });
      _currentExposureOffset = 0.0;
      _controller?.getMinExposureOffset().then((value) {
        _minAvailableExposureOffset = value;
      });
      _controller?.getMaxExposureOffset().then((value) {
        _maxAvailableExposureOffset = value;
      });
      _controller?.startImageStream(_processCameraImage).then((value) {
        if (widget.onCameraFeedReady != null) {
          widget.onCameraFeedReady!();
        }
        if (widget.onCameraLensDirectionChanged != null) {
          widget.onCameraLensDirectionChanged!(camera.lensDirection);
        }
      });
      setState(() {});
    });
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  void _processCameraImage(CameraImage image) {
    final inputImage = _inputImageFromCameraImage(image);
    if (inputImage == null) return;
    widget.onImage(inputImage);
  }

  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    if (_controller == null) return null;

    // get image rotation
    // it is used in android to convert the InputImage from Dart to Java: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/google_mlkit_commons/android/src/main/java/com/google_mlkit_commons/InputImageConverter.java
    // `rotation` is not used in iOS to convert the InputImage from Dart to Obj-C: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/google_mlkit_commons/ios/Classes/MLKVisionImage%2BFlutterPlugin.m
    // in both platforms `rotation` and `camera.lensDirection` can be used to compensate `x` and `y` coordinates on a canvas: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/example/lib/vision_detector_views/painters/coordinates_translator.dart
    final camera = _cameras[_cameraIndex];
    final sensorOrientation = camera.sensorOrientation;
    // print(
    //     'lensDirection: ${camera.lensDirection}, sensorOrientation: $sensorOrientation, ${_controller?.value.deviceOrientation} ${_controller?.value.lockedCaptureOrientation} ${_controller?.value.isCaptureOrientationLocked}');
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation =
          _orientations[_controller!.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        // front-facing
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        // back-facing
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
      // print('rotationCompensation: $rotationCompensation');
    }
    if (rotation == null) return null;
    // print('final rotation: $rotation');

    // get image format
    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    // validate format depending on platform
    // only supported formats:
    // * nv21 for Android
    // * bgra8888 for iOS
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

    // since format is constraint to nv21 or bgra8888, both only have one plane
    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    // compose InputImage using bytes
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation, // used only in Android
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
  }
}
