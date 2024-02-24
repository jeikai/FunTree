import 'package:flutter/material.dart';
import 'package:funtree/presentation/caredetailscreen_page/caredetailscreen_page.dart';
import 'package:funtree/presentation/homescreen_screen/mapeditorscreen_screen/mapeditorscreen_screen.dart';
import 'package:funtree/presentation/login_screen/login_screen.dart';
import 'package:funtree/presentation/caredetailscreen_tab_container_screen/caredetailscreen_tab_container_screen.dart';
import 'package:funtree/presentation/remiderdetailscreen_tab_container_screen/remiderdetailscreen_tab_container_screen.dart';
import 'package:funtree/presentation/homescreen_screen/homescreen_screen.dart';
import 'package:funtree/presentation/camerascreen_screen/camerascreen_screen.dart';
import 'package:funtree/presentation/shoppingscreen_container_screen/shoppingscreen_container_screen.dart';
import 'package:funtree/presentation/askingscreen_screen/askingscreen_screen.dart';
import 'package:funtree/presentation/communityscreen_screen/communityscreen_screen.dart';
import 'package:funtree/presentation/chattingscreen_screen/chattingscreen_screen.dart';
import 'package:funtree/presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String loginScreen = '/login_screen';

  static const String caredetailscreenPage = '/caredetailscreen_page';

  static const String caredetailscreenTabContainerScreen =
      '/caredetailscreen_tab_container_screen';

  static const String remiderdetailscreenPage = '/remiderdetailscreen_page';

  static const String remiderdetailscreenTabContainerScreen =
      '/remiderdetailscreen_tab_container_screen';

  static const String homescreenScreen = '/homescreen_screen';

  static const String camerascreenScreen = '/camerascreen_screen';

  static const String shoppingscreenPage = '/shoppingscreen_page';

  static const String shoppingscreenContainerScreen =
      '/shoppingscreen_container_screen';

  static const String askingscreenScreen = '/askingscreen_screen';

  static const String communityscreenScreen = '/communityscreen_screen';

  static const String chattingscreenScreen = '/chattingscreen_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String mapEditorScreen = '/map_editor_screen';

  static Map<String, WidgetBuilder> routes = {
    loginScreen: (context) => LoginScreen(),
    caredetailscreenPage: (context) => CaredetailscreenPage(),
    caredetailscreenTabContainerScreen: (context) =>
        CaredetailscreenTabContainerScreen(),
    remiderdetailscreenTabContainerScreen: (context) =>
        RemiderdetailscreenTabContainerScreen(),
    homescreenScreen: (context) => HomescreenScreen(),
    camerascreenScreen: (context) => CamerascreenScreen(),
    shoppingscreenContainerScreen: (context) => ShoppingscreenContainerScreen(),
    askingscreenScreen: (context) => AskingscreenScreen(),
    communityscreenScreen: (context) => CommunityscreenScreen(),
    chattingscreenScreen: (context) => ChattingscreenScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    mapEditorScreen: (context) => MapEditorScreen(),
  };
}
