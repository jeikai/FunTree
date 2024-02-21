import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/widgets/app_bar/appbar_trailing_button.dart';
import 'package:funtree/widgets/app_bar/custom_app_bar.dart';

class AskingscreenScreen extends StatelessWidget {
  const AskingscreenScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray600,
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 29.h,
            vertical: 16.v,
          ),
          child: Column(
            children: [
              Container(
                width: 260.h,
                margin: EdgeInsets.symmetric(horizontal: 21.h),
                child: Text(
                  "How would you like to go \nabout planting your tree?",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.headlineSmallLightgreen100,
                ),
              ),
              SizedBox(height: 32.v),
              _buildHowWouldYouLike(context),
              SizedBox(height: 21.v),
              _buildSeventyFour(context),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 52.v,
      title: Row(
        children: [
          Container(
            height: 40.adaptSize,
            width: 40.adaptSize,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  ImageConstant.imgTreePlanting40x40,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 26.adaptSize,
            width: 26.adaptSize,
            margin: EdgeInsets.only(top: 14.v),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  ImageConstant.imgPottedPlant,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 40.adaptSize,
            width: 40.adaptSize,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  ImageConstant.imgOakTree,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 40.adaptSize,
            width: 40.adaptSize,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  ImageConstant.imgOakTree40x40,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      actions: [
        AppbarTrailingButton(
          margin: EdgeInsets.fromLTRB(9.h, 13.v, 9.h, 12.v),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildHowWouldYouLike(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 6.h,
        vertical: 7.v,
      ),
      decoration: AppDecoration.fillLightGreen.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 3.h,
              top: 2.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recommendation",
                  style: CustomTextStyles.bodyMediumOnError,
                ),
                SizedBox(height: 4.v),
                Text(
                  "Automatically with your GPS",
                  style: CustomTextStyles.bodyMediumGray600,
                ),
              ],
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgForward,
            height: 15.adaptSize,
            width: 15.adaptSize,
            margin: EdgeInsets.symmetric(vertical: 11.v),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildSeventyFour(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 7.h,
        vertical: 6.v,
      ),
      decoration: AppDecoration.fillLightGreen.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 4.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Special floras",
                    style: CustomTextStyles.bodyMediumGray600,
                  ),
                  SizedBox(height: 3.v),
                  Text(
                    "(themes, regions, parks and protected areas, etc)",
                    style: CustomTextStyles.bodyMediumGray600,
                  ),
                ],
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgForward,
            height: 15.adaptSize,
            width: 15.adaptSize,
            margin: EdgeInsets.symmetric(vertical: 12.v),
          ),
        ],
      ),
    );
  }
}
