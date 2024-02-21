import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/presentation/shoppingscreen_page/shoppingscreen_page.dart';
import 'package:funtree/widgets/custom_bottom_app_bar.dart';
import 'package:funtree/widgets/custom_floating_button.dart';
import 'package:funtree/widgets/custom_search_view.dart';

// ignore_for_file: must_be_immutable
class HomescreenScreen extends StatelessWidget {
  HomescreenScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            backgroundColor: appTheme.green300Bc,
            resizeToAvoidBottomInset: false,
            body: Container(
                constraints: BoxConstraints(
                  maxHeight: SizeUtils.height,
                  maxWidth: SizeUtils.width,
                ),
                decoration: BoxDecoration(
                    color: appTheme.green300Bc,
                    image: DecorationImage(
                        image: AssetImage(ImageConstant.imgLogin),
                        fit: BoxFit.cover)),
                child: SizedBox(
                    width: double.maxFinite,
                    child: Column(children: [
                      _buildPlaylist(context),
                      SizedBox(height: 5.v),
                      Container(
                          height: 675.v,
                          padding: EdgeInsets.symmetric(
                              horizontal: 13.h, vertical: 13.v),
                          decoration: AppDecoration.fillGreen.copyWith(
                              borderRadius: BorderRadiusStyle.customBorderTL30),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            CustomSearchView(
                                controller: searchController,
                                hintText: "Search my plants"),
                            SizedBox(
                                height: 456.v,
                                width: 300.h,
                                child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          print("tab");
                                          onTapBedroom(context);
                                        },
                                        child: CustomImageView(
                                            imagePath: ImageConstant.imgBedroom,
                                            height: 400.v,
                                            width: 300.h,
                                            alignment: Alignment.bottomCenter),
                                      ),
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                              height: 76.adaptSize,
                                              width: 76.adaptSize,
                                              margin:
                                                  EdgeInsets.only(right: 52.h),
                                              child: Stack(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  children: [
                                                    CustomImageView(
                                                        imagePath: ImageConstant
                                                            .imgTopic,
                                                        height: 76.adaptSize,
                                                        width: 76.adaptSize,
                                                        alignment:
                                                            Alignment.center),
                                                    Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 24.v),
                                                            child: Text(
                                                                "Cactus",
                                                                style: CustomTextStyles
                                                                    .bodyMediumOnError_1)))
                                                  ])))
                                    ])),
                            SizedBox(height: 13.v),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CustomImageView(
                                      imagePath: ImageConstant.imgNextPage,
                                      height: 33.adaptSize,
                                      width: 33.adaptSize,
                                      margin: EdgeInsets.only(top: 5.v)),
                                  Padding(
                                      padding: EdgeInsets.only(left: 12.h),
                                      child: Text("Bedroom",
                                          style: CustomTextStyles
                                              .headlineLargeGreen60001)),
                                  CustomImageView(
                                      imagePath: ImageConstant.imgNextPage33x33,
                                      height: 33.adaptSize,
                                      width: 33.adaptSize,
                                      margin:
                                          EdgeInsets.only(left: 13.h, top: 5.v))
                                ]),
                            SizedBox(height: 13.v)
                          ]))
                    ]))),
            bottomNavigationBar: _buildBottomAppBar(context),
            floatingActionButton: CustomFloatingButton(
                height: 48,
                width: 48,
                backgroundColor: appTheme.green600,
                child: CustomImageView(imagePath: ImageConstant.imgFrame9)),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked));
  }

  /// Section Widget
  Widget _buildPlaylist(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 14.h, right: 11.h),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
              height: 92.v,
              width: 158.h,
              child: Stack(alignment: Alignment.topCenter, children: [
                Align(
                    alignment: Alignment.bottomLeft,
                    child:
                        Text("Fun Tree", style: theme.textTheme.headlineSmall)),
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
                              margin: EdgeInsets.only(top: 5.v, bottom: 6.v)),
                          Container(
                              width: 88.h,
                              margin: EdgeInsets.only(left: 10.h),
                              child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text:
                                            "Address: Hanoi\nTemperature: 29° AQI: ",
                                        style:
                                            CustomTextStyles.bodySmallffffffff),
                                    TextSpan(
                                        text:
                                            "112 Humidity: 95%\nWind: 13 km/h",
                                        style:
                                            CustomTextStyles.bodySmallffff9b57)
                                  ]),
                                  textAlign: TextAlign.left))
                        ]))
              ])),
          Padding(
              padding: EdgeInsets.only(top: 8.v, bottom: 5.v),
              child: Column(children: [
                SizedBox(
                    width: 97.h,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomImageView(
                              imagePath: ImageConstant.imgNotification,
                              height: 27.adaptSize,
                              width: 27.adaptSize),
                          GestureDetector(
                              onTap: () {
                                onTapFrameSix(context);
                              },
                              child: Container(
                                  height: 27.v,
                                  width: 61.h,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 19.h, vertical: 2.v),
                                  decoration: AppDecoration.fillLightGreen
                                      .copyWith(
                                          borderRadius: BorderRadiusStyle
                                              .roundedBorder15),
                                  child: CustomImageView(
                                      imagePath:
                                          ImageConstant.imgTreePlanting23x23,
                                      height: 23.adaptSize,
                                      width: 23.adaptSize,
                                      alignment: Alignment.center)))
                        ])),
                SizedBox(height: 11.v),
                CustomImageView(
                    imagePath: ImageConstant.imgCircledUserMale,
                    height: 40.adaptSize,
                    width: 40.adaptSize,
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 8.h))
              ]))
        ]));
  }

  /// Section Widget
  Widget _buildBottomAppBar(BuildContext context) {
    return CustomBottomAppBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
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

  /// Navigates to the askingscreenScreen when the action is triggered.
  onTapFrameSix(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.askingscreenScreen);
  }

  onTapBedroom(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.caredetailscreenPage);
  }
}
