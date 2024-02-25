import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/presentation/shoppingscreen_page/shoppingscreen_page.dart';
import 'package:funtree/widgets/custom_bottom_app_bar.dart';
import 'package:funtree/widgets/custom_floating_button.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
            bottomNavigationBar: Container(
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20),
                    child: GNav(
                      padding: EdgeInsets.all(16),
                      color: Color.fromRGBO(73, 136, 85, 1),
                      activeColor: Color.fromRGBO(73, 136, 85, 1),
                      backgroundColor: Colors.white,
                      tabBackgroundColor: Colors.grey.withOpacity(0.1),
                      gap: 8,
                      onTabChange: (index) {
                        switch (index) {
                          case 0:
                            Navigator.pushNamed(
                                context, AppRoutes.homescreenScreen);
                            break;
                          case 1:
                            Navigator.pushNamed(context,
                                AppRoutes.shoppingscreenContainerScreen);
                            break;
                          case 2:
                            Navigator.pushNamed(
                                context, AppRoutes.camerascreenScreen);
                            break;
                          case 3:
                            Navigator.pushNamed(
                                context, AppRoutes.communityscreenScreen);
                            break;
                          case 4:
                            Navigator.pushNamed(
                                context, AppRoutes.chattingscreenScreen);
                            break;
                        }
                      },
                      tabs: const [
                        GButton(
                          icon: Icons.home,
                          text: 'My garden',
                        ),
                        GButton(
                          icon: Icons.shopping_cart,
                          text: 'Shopping',
                        ),
                        GButton(
                          icon: Icons.camera_alt,
                          text: 'Camera',
                        ),
                        GButton(
                          icon: Icons.people,
                          text: 'Community',
                        ),
                        GButton(
                          icon: Icons.chat_bubble_outlined,
                          text: 'AI',
                        ),
                      ],
                    )))));
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
