import 'package:flutter/material.dart';
import 'package:funtree/core/SharePref.dart';
import 'package:funtree/routes/app_routes.dart';

import 'components/profile_menu.dart';
import 'components/profile_pic.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    String username = SharePref.getName()!;
    String email = SharePref.getEmail()!;
    String id = SharePref.getUserId()!;
    return Scaffold(
      appBar: AppBar(
        title: username.isNotEmpty ? Text(username, style: TextStyle(color: Colors.black),) : const Text("Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            ProfileMenu(
              text: id,
              iconData: Icons.perm_identity,
              press: () => {},
            ),
            ProfileMenu(
              text: email,
              iconData: Icons.person,
              press: () => {},
            ),
            ProfileMenu(
              text: "Log Out",
              iconData: Icons.output_outlined,
              press: () async {
                await SharePref.setEmail("");
                await SharePref.setName("");
                await SharePref.setUserId("");
                Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}