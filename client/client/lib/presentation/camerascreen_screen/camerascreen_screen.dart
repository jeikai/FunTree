import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/widgets/app_bar/appbar_leading_image.dart';
import 'package:funtree/widgets/app_bar/appbar_title.dart';
import 'package:funtree/widgets/app_bar/appbar_trailing_image.dart';
import 'package:funtree/widgets/app_bar/custom_app_bar.dart';
import 'package:funtree/widgets/custom_elevated_button.dart';
import 'package:funtree/widgets/custom_icon_button.dart';

class CamerascreenScreen extends StatelessWidget {
  const CamerascreenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: _buildAppBar(context),
            body: Container(
                width: SizeUtils.width,
                height: SizeUtils.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(ImageConstant.imgCamerascreen),
                        fit: BoxFit.cover)),
                child: Container(
                    width: double.maxFinite,
                    padding:
                        EdgeInsets.symmetric(horizontal: 17.h, vertical: 45.v),
                    child: Column(children: [
                      Spacer(flex: 51),
                      Container(
                          height: 243.v,
                          width: 299.h,
                          decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      color: theme.colorScheme.onError,
                                      width: 3.h),
                                  right: BorderSide(
                                      color: theme.colorScheme.onError,
                                      width: 3.h)))),
                      Spacer(flex: 48),
                      CustomElevatedButton(
                          height: 43.v,
                          text: "Snake plant",
                          margin: EdgeInsets.only(left: 19.h, right: 18.h),
                          buttonStyle: CustomButtonStyles.fillPrimary,
                          buttonTextStyle:
                              CustomTextStyles.bodyMediumOnError14),
                      SizedBox(height: 18.v),
                      _buildFiftySix(context)
                    ])))));
  }

  /// Section Widget
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
          AppbarTrailingImage(
              imagePath: ImageConstant.imgFlashAuto,
              margin: EdgeInsets.symmetric(horizontal: 7.h, vertical: 9.v))
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

  /// Navigates to the homescreenScreen when the action is triggered.
  onTapMultiply(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homescreenScreen);
  }
}
