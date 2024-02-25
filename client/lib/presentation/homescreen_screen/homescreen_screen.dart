import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:funtree/widgets/custom_search_view.dart';
import 'package:funtree/widgets/home_screen/home_map.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../backend/backend.dart';

class HomescreenScreen extends StatefulWidget {
  const HomescreenScreen({super.key});

  @override
  State<HomescreenScreen> createState() => _HomescreenScreenState();
}

class _HomescreenScreenState extends State<HomescreenScreen> {
  TextEditingController searchController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  double latitude = 0.0;
  double longitude = 0.0;
  double AQI = 0.0;
  double humidity = 0.0;
  double wind = 0.0;
  double temp = 0.0;
  String currentAddress = "";
  bool isLoading = true;

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }
    Position position = await Geolocator.getCurrentPosition();
    latitude = position.latitude;
    longitude = position.longitude;
    List<Placemark> placemarks =
        await placemarkFromCoordinates(52.2165157, 6.9437819);
    print(placemarks[0]);
    Placemark place = placemarks[0];
    currentAddress = "${place.locality}, ${place.country}";
  }

  Future<void> getWeather() async {
    try {
      final api = Api();
      final response =
          await api.getData("weather/current?lat=${latitude}&lng=${longitude}");
      if (response != null) {
        print(response["data"]["airQuality"]["aqi"]);
        print(response["data"]["weather"]);
        AQI = response["data"]["airQuality"]["aqi"];
        humidity = response["data"]["weather"]["humidity"];
        wind = response["data"]["weather"]["wind_speed"];
        temp = response["data"]["weather"]["temp"];
      } else {
        print("Failed to fetch weather data: Response is null.");
      }
    } catch (e) {
      print("An error occurred while fetching weather data: $e");
    }
  }

  Future<void> _fetchData() async {
    await _determinePosition().then((_) {
       getWeather();
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading ? _buildLoadingScreen() : _buildMainScreen(),
      ),
    );
  }

  Widget _buildMainScreen() {
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
              width: 220.h,
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
                              width: 150.h,
                              margin: EdgeInsets.only(left: 10.h),
                              child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: "Address: ${currentAddress}\n",
                                        style:
                                            CustomTextStyles.bodySmallffffffff),
                                    TextSpan(
                                        text: "Temperature: ${temp}°\n",
                                        style:
                                            CustomTextStyles.bodySmallffffffff),
                                    TextSpan(
                                        text: "AQI: ${AQI.toString()}\n",
                                        style:
                                            CustomTextStyles.bodySmallffffffff),
                                    TextSpan(
                                        text: "Humidity: ${humidity} %\n",
                                        style:
                                            CustomTextStyles.bodySmallffffffff),
                                    TextSpan(
                                        text: "Wind: ${wind} km/h",
                                        style:
                                            CustomTextStyles.bodySmallffffffff),
                                  ]),
                                  textAlign: TextAlign.left))
                        ]))
              ])),
          Padding(
              padding: EdgeInsets.only(top: 8.v, bottom: 5.v),
              child: Column(children: [
                SizedBox(
                    width: 90.h,
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
