import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';

class AppNavigationScreen extends StatelessWidget {
  const AppNavigationScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFFFFFFF),
        body: SizedBox(
          width: 375.h,
          child: Column(
            children: [
              _buildAppNavigation(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0XFFFFFFFF),
                    ),
                    child: Column(
                      children: [
                        _buildScreenTitle(
                          context,
                          screenTitle: "Login",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.loginScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "careDetailScreen - Tab Container",
                          onTapScreenTitle: () => onTapScreenTitle(context,
                              AppRoutes.caredetailscreenTabContainerScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "remiderDetailScreen - Tab Container",
                          onTapScreenTitle: () => onTapScreenTitle(context,
                              AppRoutes.remiderdetailscreenTabContainerScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "homescreen",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.homescreenScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "cameraScreen",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.camerascreenScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "shoppingScreen - Container",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.shoppingscreenContainerScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "askingScreen",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.askingscreenScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "communityScreen",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.communityscreenScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "chattingScreen",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.chattingscreenScreen),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAppNavigation(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFFFFFFFF),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                "App Navigation",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFF000000),
                  fontSize: 20.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.h),
              child: Text(
                "Check your app's UI from the below demo screens of your app.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFF888888),
                  fontSize: 16.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.v),
          Divider(
            height: 1.v,
            thickness: 1.v,
            color: Color(0XFF000000),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildScreenTitle(
    BuildContext context, {
    required String screenTitle,
    Function? onTapScreenTitle,
  }) {
    return GestureDetector(
      onTap: () {
        onTapScreenTitle!.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0XFFFFFFFF),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.v),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Text(
                  screenTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0XFF000000),
                    fontSize: 20.fSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.v),
            SizedBox(height: 5.v),
            Divider(
              height: 1.v,
              thickness: 1.v,
              color: Color(0XFF888888),
            ),
          ],
        ),
      ),
    );
  }

  /// Common click event
  void onTapScreenTitle(
    BuildContext context,
    String routeName,
  ) {
    Navigator.pushNamed(context, routeName);
  }
}
