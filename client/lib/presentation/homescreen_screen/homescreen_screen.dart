import 'package:flutter/material.dart';
import 'package:funtree/backend/backend.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/presentation/chattingscreen_screen/chattingscreen_screen.dart';
import 'package:funtree/presentation/communityscreen_screen/communityscreen_screen.dart';
import 'package:funtree/presentation/shoppingscreen_page/shoppingscreen_page.dart';
import 'package:funtree/widgets/custom_bottom_app_bar.dart';
import 'package:funtree/widgets/custom_floating_button.dart';
import 'package:funtree/widgets/home_screen/community.dart';
import 'package:funtree/widgets/home_screen/shop.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:funtree/widgets/custom_search_view.dart';
import 'package:funtree/widgets/home_screen/home_map.dart';

class HomescreenScreen extends StatefulWidget {
  const HomescreenScreen({super.key});

  @override
  State<HomescreenScreen> createState() => _HomescreenScreenState();
}

class _HomescreenScreenState extends State<HomescreenScreen> {
  late Widget mainWidget;

  String cr = AppRoutes.homescreenScreen;

  TextEditingController searchController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  double latitude = 0.0;
  double longitude = 0.0;
  int AQI = 0;
  int humidity = 0;
  double wind = 0.00;
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
        print(AQI);
      } else {
        print("Failed to fetch weather data: Response is null.");
      }
    } catch (e) {
      print("An error occurred while fetching weather data: $e");
    }
  }

  Future<void> _fetchData() async {
    await _determinePosition();
    await getWeather();
    setState(() {
      isLoading = false;
      mainWidget = getCurrentPage(cr);
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
                child: mainWidget),
            bottomNavigationBar: _buildBottomAppBar(context),
            floatingActionButton: CustomFloatingButton(
                height: 48,
                width: 48,
                backgroundColor: appTheme.green600,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.camerascreenScreen);
                },
                child: CustomImageView(imagePath: ImageConstant.imgFrame9)),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked));
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
                                            "Address: Hanoi\n",
                                        style:
                                            CustomTextStyles.bodySmallffffffff),
                                    TextSpan(
                                        text: "AQI: ${AQI}\n",
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
      var currentRoute = getCurrentRoute(type);
      if (currentRoute != "/") {
        setState(() {
          cr = currentRoute;
          mainWidget = getCurrentPage(currentRoute);
        });
      }
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    String temp = "/";
    switch (type) {
      case BottomBarEnum.Mygarden:
        temp = AppRoutes.homescreenScreen;
      case BottomBarEnum.Shop:
        temp = AppRoutes.shoppingscreenPage;
      case BottomBarEnum.Community:
        temp = AppRoutes.communityscreenScreen;
      case BottomBarEnum.Ai:
        temp = AppRoutes.chattingscreenScreen;
      default:
        temp = "/";
    }
    if (temp == cr) {
      return "/";
    }
    return temp;
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.shoppingscreenPage:
        return SizedBox(
            width: double.maxFinite,
            child: Column(children: [
              _buildPlaylist(context),
              SizedBox(height: 5.v),
              Container(
                  height: 675.v,
                  padding:
                      EdgeInsets.symmetric(horizontal: 13.h, vertical: 13.v),
                  decoration: AppDecoration.fillGreen.copyWith(
                      borderRadius: BorderRadiusStyle.customBorderTL30),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    CustomSearchView(
                        controller: searchController,
                        hintText: "Search my plants"),
                    Shop()
                  ]))
            ]));
      case AppRoutes.homescreenScreen:
        return SizedBox(
            width: double.maxFinite,
            child: Column(children: [
              _buildPlaylist(context),
              SizedBox(height: 5.v),
              Container(
                  height: 675.v,
                  padding:
                      EdgeInsets.symmetric(horizontal: 13.h, vertical: 13.v),
                  decoration: AppDecoration.fillGreen.copyWith(
                      borderRadius: BorderRadiusStyle.customBorderTL30),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    CustomSearchView(
                        controller: searchController,
                        hintText: "Search my plants"),
                    HomeMap()
                  ]))
            ]));
      case AppRoutes.communityscreenScreen:
        return Community();
      case AppRoutes.chattingscreenScreen:
        Navigator.pushNamed(context, AppRoutes.chattingscreenScreen);
        return DefaultWidget();
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
