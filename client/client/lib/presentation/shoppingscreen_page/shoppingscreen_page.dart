import '../shoppingscreen_page/widgets/userprofile_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/widgets/custom_icon_button.dart';
import 'package:funtree/widgets/custom_search_view.dart';

// ignore_for_file: must_be_immutable
class ShoppingscreenPage extends StatelessWidget {
  ShoppingscreenPage({Key? key})
      : super(
          key: key,
        );

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: appTheme.green300Bc,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: SizeUtils.width,
          height: SizeUtils.height,
          decoration: BoxDecoration(
            color: appTheme.green300Bc,
            image: DecorationImage(
              image: AssetImage(
                ImageConstant.imgLogin,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            width: double.maxFinite,
            decoration: AppDecoration.fillGreenBc.copyWith(
              image: DecorationImage(
                image: AssetImage(
                  ImageConstant.imgLogin,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                _buildFunTreeSection(context),
                SizedBox(height: 5.v),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 19.h,
                    vertical: 13.v,
                  ),
                  decoration: AppDecoration.fillGreen.copyWith(
                    borderRadius: BorderRadiusStyle.customBorderTL301,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomSearchView(
                        controller: searchController,
                        hintText: "Search",
                      ),
                      SizedBox(height: 32.v),
                      _buildUserProfile(context),
                      SizedBox(height: 32.v),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFunTreeSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 14.h,
        right: 11.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
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
                        margin: EdgeInsets.only(
                          top: 5.v,
                          bottom: 6.v,
                        ),
                      ),
                      Container(
                        width: 88.h,
                        margin: EdgeInsets.only(left: 10.h),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Address: Hanoi\nTemperature: 29° AQI: ",
                                style: CustomTextStyles.bodySmallffffffff,
                              ),
                              TextSpan(
                                text: "112 Humidity: 95%\nWind: 13 km/h",
                                style: CustomTextStyles.bodySmallffff9b57,
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
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 8.v,
              bottom: 5.v,
            ),
            child: Column(
              children: [
                SizedBox(
                  width: 95.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgNotification,
                        height: 27.adaptSize,
                        width: 27.adaptSize,
                      ),
                      Container(
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
                    ],
                  ),
                ),
                SizedBox(height: 11.v),
                Padding(
                  padding: EdgeInsets.only(right: 10.h),
                  child: CustomIconButton(
                    height: 40.adaptSize,
                    width: 40.adaptSize,
                    alignment: Alignment.centerRight,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgCircledUserMale,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildUserProfile(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 9.h),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 174.v,
          crossAxisCount: 2,
          mainAxisSpacing: 22.h,
          crossAxisSpacing: 22.h,
        ),
        physics: NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return UserprofileItemWidget();
        },
      ),
    );
  }
}
