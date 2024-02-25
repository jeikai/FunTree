import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/widgets/app_bar/appbar_leading_image.dart';
import 'package:funtree/widgets/app_bar/appbar_title.dart';
import 'package:funtree/widgets/app_bar/custom_app_bar.dart';
import 'package:funtree/widgets/custom_elevated_button.dart';
import 'package:funtree/widgets/custom_icon_button.dart';

class CamerascreenScreen extends StatefulWidget {
  const CamerascreenScreen({super.key});

  @override
  State<CamerascreenScreen> createState() => _CamerascreenScreenState();
}

class _CamerascreenScreenState extends State<CamerascreenScreen> {
  bool isFlashOn = false;
  late CameraController controller;
  late List<CameraDescription> _cameras;
  Future<void> initCamera() async {
    _cameras = await availableCameras();
  }
  @override
  void initState() {
    super.initState();
    initCamera();
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
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
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: _buildAppBar(context),
        body: MaterialApp(
          home: CameraPreview(controller),
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

  /// Section Widget
  Widget _buildFiftySix(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 2.h),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomImageView(
                  imagePath: ImageConstant.imgPicShop44,
                  height: 40.v,
                  width: 50.h,
                  margin: EdgeInsets.only(top: 53.v)),
              Spacer(flex: 46),
              Padding(
                  padding: EdgeInsets.only(bottom: 13.v),
                  child: CustomIconButton(
                      height: 80.adaptSize,
                      width: 80.adaptSize,
                      padding: EdgeInsets.all(19.h),
                      child: CustomImageView(
                          imagePath: ImageConstant.imgSearch80x80))),
              Spacer(flex: 53),
              Padding(
                  padding: EdgeInsets.only(top: 53.v),
                  child: CustomIconButton(
                      height: 40.adaptSize,
                      width: 40.adaptSize,
                      padding: EdgeInsets.all(10.h),
                      child:
                      CustomImageView(imagePath: ImageConstant.imgGroup6)))
            ]));
  }

  onTapMultiply(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homescreenScreen);
  }
}
