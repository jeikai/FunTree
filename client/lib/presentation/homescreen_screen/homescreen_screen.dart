import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';
import 'package:geolocator/geolocator.dart';
import 'package:funtree/widgets/custom_search_view.dart';
import 'package:funtree/widgets/home_screen/home_map.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
class HomescreenScreen extends StatefulWidget {
  const HomescreenScreen({super.key});

  @override
  State<HomescreenScreen> createState() => _HomescreenScreenState();
}
class _HomescreenScreenState extends State<HomescreenScreen> {

  TextEditingController searchController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  @override
  void initState() {
    super.initState();

  }
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
                            HomeMap(
                              key: Key("homemap"),
                            ),
                            SizedBox(height: 13.v)
                          ]))
                    ]))),
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

  /// Navigates to the askingscreenScreen when the action is triggered.
  onTapFrameSix(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.askingscreenScreen);
  }

  onTapBedroom(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.caredetailscreenPage);
  }
}
