import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/presentation/shoppingscreen_page/shoppingscreen_page.dart';
import 'package:funtree/widgets/custom_bottom_app_bar.dart';
import 'package:funtree/widgets/custom_floating_button.dart';
import 'package:readmore/readmore.dart';

class CommunityscreenScreen extends StatelessWidget {
  CommunityscreenScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: appTheme.green300Bc,
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
          child: SizedBox(
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
          ),
        ),
        bottomNavigationBar: _buildBottomAppBarSection(context),
        floatingActionButton: CustomFloatingButton(
          height: 48,
          width: 48,
          backgroundColor: appTheme.green600,
          child: CustomImageView(
            imagePath: ImageConstant.imgFrame9,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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

  /// Section Widget
  Widget _buildBottomAppBarSection(BuildContext context) {
    return CustomBottomAppBar(
      onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(
            navigatorKey.currentContext!, getCurrentRoute(type));
      },
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Mygarden:
        return AppRoutes.shoppingscreenPage;
      case BottomBarEnum.Shop:
        return "/";
      case BottomBarEnum.Community:
        return "/";
      case BottomBarEnum.Ai:
        return "/";
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.shoppingscreenPage:
        return ShoppingscreenPage();
      default:
        return DefaultWidget();
    }
  }
}
