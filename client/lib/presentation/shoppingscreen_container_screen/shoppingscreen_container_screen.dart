import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/presentation/shoppingscreen_page/shoppingscreen_page.dart';
import 'package:funtree/widgets/custom_bottom_app_bar.dart';
import 'package:funtree/widgets/custom_floating_button.dart';

// ignore_for_file: must_be_immutable
class ShoppingscreenContainerScreen extends StatelessWidget {
  ShoppingscreenContainerScreen({Key? key}) : super(key: key);

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
                        image: AssetImage(ImageConstant.imgLogin),
                        fit: BoxFit.cover)),
                child: Navigator(
                    key: navigatorKey,
                    initialRoute: AppRoutes.shoppingscreenPage,
                    onGenerateRoute: (routeSetting) => PageRouteBuilder(
                        pageBuilder: (ctx, ani, ani1) =>
                            getCurrentPage(routeSetting.name!),
                        transitionDuration: Duration(seconds: 0)))),
            bottomNavigationBar: _buildBottomAppBarSection(context),
            floatingActionButton: CustomFloatingButton(
                height: 48,
                width: 48,
                backgroundColor: appTheme.green600,
                child: CustomImageView(imagePath: ImageConstant.imgFrame9)),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked));
  }

  /// Section Widget
  Widget _buildBottomAppBarSection(BuildContext context) {
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
}
