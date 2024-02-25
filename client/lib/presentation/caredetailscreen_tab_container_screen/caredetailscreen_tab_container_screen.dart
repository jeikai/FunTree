import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/presentation/caredetailscreen_page/caredetailscreen_page.dart';
import 'package:funtree/presentation/remiderdetailscreen_page/remiderdetailscreen_page.dart';
import 'package:funtree/widgets/app_bar/appbar_leading_image.dart';
import 'package:funtree/widgets/app_bar/appbar_trailing_image.dart';
import 'package:funtree/widgets/app_bar/custom_app_bar.dart';

int treeIndex = 0;

class CaredetailscreenTabContainerScreen extends StatefulWidget {
  const CaredetailscreenTabContainerScreen({Key? key}) : super(key: key);

  @override
  CaredetailscreenTabContainerScreenState createState() =>
      CaredetailscreenTabContainerScreenState();
}

// ignore_for_file: must_be_immutable
class CaredetailscreenTabContainerScreenState
    extends State<CaredetailscreenTabContainerScreen>
    with TickerProviderStateMixin {
  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                height: SizeUtils.height,
                width: double.maxFinite,
                child: Stack(alignment: Alignment.bottomCenter, children: [
                  _buildPicShopFortyFive(context),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          decoration: AppDecoration.fillGreen.copyWith(
                              borderRadius: BorderRadiusStyle.customBorderTL20),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Container(
                              margin: EdgeInsets.all(5.adaptSize),
                                height: 21.v,
                                width: 278.h,
                                decoration: BoxDecoration(
                                    color: appTheme.blueGray200,
                                    borderRadius: BorderRadius.circular(10.h)),
                                child: TabBar(
                                    controller: tabviewController,
                                    labelPadding: EdgeInsets.zero,
                                    labelColor: appTheme.green60001,
                                    labelStyle: TextStyle(
                                        fontSize: 10.fSize,
                                        fontFamily: 'Itim',
                                        fontWeight: FontWeight.w400),
                                    unselectedLabelColor: appTheme.green60001,
                                    unselectedLabelStyle: TextStyle(
                                        fontSize: 10.fSize,
                                        fontFamily: 'Itim',
                                        fontWeight: FontWeight.w400),
                                    indicatorPadding: EdgeInsets.all(1.5.h),
                                    indicator: BoxDecoration(
                                        color: theme.colorScheme.onError,
                                        borderRadius:
                                            BorderRadius.circular(9.h)),
                                    tabs: [
                                      Tab(child: Text("Care")),
                                      Tab(child: Text("Notes")),
                                      Tab(child: Text("History")),
                                      Tab(child: Text("Reminder"))
                                    ])),
                            SizedBox(
                                height: 438.v,
                                child: ColoredBox(
                                    color: appTheme.green50,
                                    child: TabBarView(
                                        controller: tabviewController,
                                        children: [
                                          CaredetailscreenPage(),
                                          CaredetailscreenPage(),
                                          CaredetailscreenPage(),
                                          RemiderdetailscreenPage()
                                        ]
                                )))
                          ])))
                ]))));
  }

  /// Section Widget
  Widget _buildPicShopFortyFive(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
            height: 367.v,
            width: double.maxFinite,
            child: Stack(alignment: Alignment.topCenter, children: [
              CustomImageView(
                fit: BoxFit.cover,
                  imagePath: ImageConstant.imgPicShop45,
                  height: 367.v,
                  width: 360.h,
                  alignment: Alignment.center),
              Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                      padding:
                          EdgeInsets.only(left: 4.h, top: 11.v, right: 7.h),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        CustomAppBar(
                            leadingWidth: 24.h,
                            leading: AppbarLeadingImage(
                                imagePath: ImageConstant.imgBack,
                                margin: EdgeInsets.only(
                                    left: 4.h, top: 2.v, bottom: 3.v),
                                onTap: () {
                                  onTapBack(context);
                                }),
                            actions: [
                              AppbarTrailingImage(
                                  imagePath: ImageConstant.imgCreate,
                                  margin: EdgeInsets.symmetric(horizontal: 7.h))
                            ]),
                      ]))),
              Align(
                alignment: Alignment(0.0, 0.4),
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 5.v),
                      child: Stack(
                        children: [
                          Text("Cactus", style: theme.textTheme.headlineLarge?.copyWith(
                            fontSize: 60.adaptSize,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 5.adaptSize
                              ..color = Colors.green[700]!,
                          )),
                          Text("Cactus", style: theme.textTheme.headlineLarge?.copyWith(
                            fontSize: 60.adaptSize,
                          ))
                        ],
                      ))
              )
            ])));
  }

  /// Navigates to the homescreenScreen when the action is triggered.
  onTapBack(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homescreenScreen);
  }
}
