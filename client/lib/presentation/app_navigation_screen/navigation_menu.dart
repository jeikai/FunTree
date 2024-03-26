import 'package:flutter/material.dart';
import 'package:funtree/presentation/camerascreen_screen/camerascreen_screen.dart';
import 'package:funtree/presentation/chattingscreen_screen/chattingscreen_screen.dart';
import 'package:funtree/presentation/communityscreen_screen/communityscreen_screen.dart';
import 'package:funtree/presentation/homescreen_screen/homescreen_screen.dart';
import 'package:funtree/presentation/shoppingscreen_page/shoppingscreen_page.dart';
import 'package:get/get.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home, color: Color.fromARGB(255, 73, 136, 85)),
              label: 'My garden',
            ),
            NavigationDestination(
                icon: Icon(Icons.shopping_cart,
                    color: Color.fromARGB(255, 73, 136, 85)),
                label: 'Shopping'),
            NavigationDestination(
                icon: Icon(Icons.camera_alt_rounded,
                    color: Color.fromARGB(255, 73, 136, 85)),
                label: 'Camera'),
            NavigationDestination(
                icon: Icon(Icons.people_rounded,
                    color: Color.fromARGB(255, 73, 136, 85)),
                label: 'Community'),
            NavigationDestination(
                icon: Icon(Icons.chat_bubble,
                    color: Color.fromARGB(255, 73, 136, 85)),
                label: 'Chat AI'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    HomescreenScreen(),
    ShoppingscreenPage(),
    CamerascreenScreen(),
    CommunityscreenScreen(),
    ChattingscreenScreen()
  ];
}
