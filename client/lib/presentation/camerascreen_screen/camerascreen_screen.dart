import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:funtree/backend/backend.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/presentation/homescreen_screen/homescreen_screen.dart';
import 'package:funtree/widgets/app_bar/appbar_leading_image.dart';
import 'package:funtree/widgets/app_bar/appbar_title.dart';
import 'package:funtree/widgets/app_bar/custom_app_bar.dart';
import 'package:funtree/widgets/camera/camera.dart';
import 'package:funtree/widgets/custom_elevated_button.dart';
import 'package:funtree/widgets/custom_icon_button.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
class CamerascreenScreen extends StatefulWidget {
  const CamerascreenScreen({super.key});

  @override
  State<CamerascreenScreen> createState() => _CamerascreenScreenState();
}

class _CamerascreenScreenState extends State<CamerascreenScreen> with SingleTickerProviderStateMixin<CamerascreenScreen> {
  Ticker? _ticker;
  final Duration tickDuration = Duration(microseconds: 500); // Set your desired tick duration here
  Duration lastTick = Duration.zero;

  final listenable = Bound();
  bool isFlashOn = false;
  bool isCameraReady = false;
  late List<CameraDescription> _cameras;

  Future<void> initCamera() async {
  }

  @override
  void initState() {
    super.initState();
    initCamera().then((value) async {
      controller = CameraController(_cameras[0], ResolutionPreset.max);
      await controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              // Handle access errors here.
              break;
            default:
              // Handle other errors here.
              break;
          }
        }
      });
    });
    ;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: _buildAppBar(context),
        body: Material(
          child: controller == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: [
                    SizedBox(
                      height: 800.v,
                      width: 360.h,
                      child: CameraPreview(controller!),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _buildFiftySix(context),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 48.v,
        leadingWidth: 37.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgMultiply,
            margin: EdgeInsets.only(left: 7.h, top: 9.v, bottom: 9.v),
            onTap: () {
              onTapMultiply(context);
            }),
        centerTitle: true,
        title: AppbarTitle(text: "Fun Tree"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isFlashOn = !isFlashOn;
                });
              },
              icon: Icon(
                Icons.flash_on,
                color: isFlashOn ? Colors.blue : Colors.grey,
              ))
        ]);
  }

  Widget _buildFiftySix(BuildContext context) {
    return Container(
        height: 180.v,
        child: Stack(children: [
          Center(
              child: CustomIconButton(
                  height: 80.adaptSize,
                  width: 80.adaptSize,
                  padding: EdgeInsets.all(19.h),
                  child: CustomImageView(
                      imagePath: ImageConstant.imgSearch80x80))),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                  padding: EdgeInsets.only(
                      bottom: 10.adaptSize, right: 10.adaptSize),
                  child: CustomIconButton(
                      height: 40.adaptSize,
                      width: 40.adaptSize,
                      padding: EdgeInsets.all(10.h),
                      child:
                          CustomImageView(imagePath: ImageConstant.imgGroup6))))
        ]));
  }

  onTapMultiply(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homescreenScreen);
  }
}
