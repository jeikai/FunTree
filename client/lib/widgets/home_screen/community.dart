import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funtree/core/utils/image_constant.dart';
import 'package:funtree/core/utils/size_utils.dart';
import 'package:funtree/theme/app_decoration.dart';
import 'package:funtree/theme/custom_text_style.dart';
import 'package:funtree/theme/theme_helper.dart';
import 'package:funtree/widgets/custom_image_view.dart';
import 'package:readmore/readmore.dart';

class Community extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 717.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30.v),
              decoration: AppDecoration.fillGreen,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildFunTreeSection(context),
                  Divider(),
                  Spacer(),
                  SizedBox(height: 52.v),
                  CustomImageView(
                    imagePath: ImageConstant.imgCreate32x32,
                    height: 32.adaptSize,
                    width: 32.adaptSize,
                    margin: EdgeInsets.only(right: 12.h),
                  ),
                ],
              ),
            ),
          ),
          _buildFemaleProfileSection(context),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFunTreeSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Fun Tree",
                  style: CustomTextStyles.headlineLargeBluegray700,
                ),
                Text(
                  "Community",
                  style: CustomTextStyles.bodyMediumBluegray700,
                ),
              ],
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgGarden,
            height: 67.adaptSize,
            width: 67.adaptSize,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFemaleProfileSection(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 123.v),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgFemaleProfile,
              height: 30.adaptSize,
              width: 30.adaptSize,
              margin: EdgeInsets.only(bottom: 302.v),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Phúc Trần 3h  My plant is dying. Pls help!",
                      style: CustomTextStyles.bodyMediumPrimary,
                    ),
                    SizedBox(height: 5.v),
                    SizedBox(
                      height: 257.v,
                      width: 315.h,
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              width: 314.h,
                              child: ReadMoreText(
                                "As I glance over at my once vibrant green plant sitting sadly in the corner, I feel a pang of \ndistress. Its leaves, once lush and full of life, now droop limply, and its stems appear brittle and weak. Despite my efforts to nurture it, ... ",
                                trimLines: 6,
                                colorClickableText: appTheme.blue400,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: "Read more",
                                moreStyle: CustomTextStyles.bodyMediumPrimary,
                                lessStyle: CustomTextStyles.bodyMediumPrimary,
                              ),
                            ),
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgPicShop43,
                            height: 150.adaptSize,
                            width: 150.adaptSize,
                            radius: BorderRadius.circular(
                              20.h,
                            ),
                            alignment: Alignment.bottomLeft,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.v),
                    Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgChatBubble,
                          height: 25.adaptSize,
                          width: 25.adaptSize,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 7.h,
                            top: 3.v,
                            bottom: 3.v,
                          ),
                          child: Text(
                            "2",
                            style: CustomTextStyles.bodyMediumGreen600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}