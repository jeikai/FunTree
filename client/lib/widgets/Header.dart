import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/core/utils/image_constant.dart';

import 'custom_image_view.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.temp,
    required this.aqi,
    required this.humidity,
    required this.wind,
}) : super(key: key);
  final double temp;
  final int aqi;
  final int humidity;
  final double wind;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 14.h, right: 11.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start, // Align top elements
        children: [
          _buildLeftSide(context),
          _buildRightSide(context),
        ],
      ),
    );
  }
  Widget _buildLeftSide(BuildContext context) {
    return SizedBox(
      height: 92.v,
      width: 158.h,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              "Fun Tree",
              style: theme.textTheme.headlineSmall,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgSunBehindSmall,
                  height: 60.adaptSize,
                  width: 60.adaptSize,
                  margin: EdgeInsets.only(top: 5.v, bottom: 6.v),
                ),
                Container(
                  width: 88.h,
                  margin: EdgeInsets.only(left: 10.h),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Temp: ${temp}\n",
                          style: CustomTextStyles.bodySmallffffffff,
                        ),
                        TextSpan(
                          text: "AQI: ${aqi}\n",
                          style: CustomTextStyles.bodySmallffffffff,
                        ),
                        TextSpan(
                          text: "Humidity: ${humidity} %\n",
                          style: CustomTextStyles.bodySmallffffffff,
                        ),
                        TextSpan(
                          text: "Wind: ${wind} km/h",
                          style: CustomTextStyles.bodySmallffffffff,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRightSide(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.v, bottom: 5.v),
      child: Column(
        children: [
          SizedBox(
            width: 97.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgNotification,
                  height: 27.adaptSize,
                  width: 27.adaptSize,
                ),
                GestureDetector(
                  onTap: () {
                    onTapFrameSix(context);
                  },
                  child: Container(
                    height: 27.v,
                    width: 61.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 19.h,
                      vertical: 2.v,
                    ),
                    decoration: AppDecoration.fillLightGreen.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder15,
                    ),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgTreePlanting23x23,
                      height: 23.adaptSize,
                      width: 23.adaptSize,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 11.v),
          CustomImageView(
            imagePath: ImageConstant.imgCircledUserMale,
            height: 40.adaptSize,
            width: 40.adaptSize,
            alignment: Alignment.centerRight,
          ),
        ],
      ),
    );
  }
}

void onTapFrameSix(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.askingscreenScreen);
}