import 'package:flutter/material.dart';
import 'package:funtree/backend/backend.dart';
import 'package:funtree/core/SharePref.dart';
import 'package:funtree/core/app_export.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

// ignore_for_file: must_be_immutable
class RemiderdetailscreenPage extends StatefulWidget {
  const RemiderdetailscreenPage({Key? key})
      : super(
          key: key,
        );

  @override
  RemiderdetailscreenPageState createState() => RemiderdetailscreenPageState();
}

class RemiderdetailscreenPageState extends State<RemiderdetailscreenPage>
    with AutomaticKeepAliveClientMixin<RemiderdetailscreenPage> {
  @override
  bool get wantKeepAlive => true;

  double latitude = 0.0;
  double longitude = 0.0;
  int AQI = 0;
  int humidity = 0;
  double wind = 0.0;
  double temp = 0.0;
  String currentAddress = "";
  bool isLoading = true;
  String recommendation = "Dracaena trifasciata is a species of flowering plant in the family Asparagaceae, native to tropical West Africa from Nigeria east to the Congo. It is most commonly known as the snake plant, Saint George's sword, mother-in-law's tongue, and viper's bowstring hemp, among other names. Until 2017, it was known under the synonym Sansevieria trifasciata.";
  String image = "";
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
    currentAddress = (await SharePref.getAdress()!);
    temp = (await SharePref.getTemp())!;
    AQI = (await SharePref.getAqi()!);
    humidity = (await SharePref.getHumidity()!);
    wind = (await SharePref.getWind()!);
    currentAddress = (await SharePref.getAdress())!;
    image = (await SharePref.getWeatherImage()!);
  }

  Future<void> _fetchData() async {
    await _determinePosition();
    await getWeather();
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
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillGreen,
          child: ClipRRect(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 22.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 21.h),
                      child: Column(
                        children: [
                          _buildWeatherSection(context),
                          SizedBox(height: 13.v),
                          _buildFunTreeSection(context),
                          SizedBox(height: 13.v),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60.h),
                topRight: Radius.circular(60.h),
              )),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildWeatherSection(BuildContext context) {
    return Container(
      width: 400.h,
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      decoration: AppDecoration.fillOnError1.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 4.v),
          Row(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgWeather,
                height: 20.adaptSize,
                width: 20.adaptSize,
              ),
              Padding(
                padding: EdgeInsets.only(left: 3.h),
                child: Text(
                  "Weather",
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Image(
                image: NetworkImage('http:' + image),
                height: 60.adaptSize,
                width: 60.adaptSize,
              ),
              Container(
                width: 88.h,
                margin: EdgeInsets.only(
                  left: 8.h,
                  top: 2.v,
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text:
                          "Address: ${currentAddress}\n",
                          style:
                          CustomTextStyles.bodySmallff445d48),
                      TextSpan(
                          text: "AQI: ${AQI}\n",
                          style:
                          CustomTextStyles.bodySmallff445d48),
                      TextSpan(
                          text: "Humidity: ${humidity} %\n",
                          style:
                          CustomTextStyles.bodySmallff445d48),
                      TextSpan(
                          text: "Wind: ${wind} km/h",
                          style:
                          CustomTextStyles.bodySmallff445d48),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFunTreeSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 7.h,
        vertical: 4.v,
      ),
      decoration: AppDecoration.fillOnError1.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 3.h),
            child: Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgBot,
                  height: 20.adaptSize,
                  width: 20.adaptSize,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3.h),
                  child: Text(
                    "Fun Tree",
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 7.v),
          SizedBox(
            width: 400.h,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Weather: ",
                    style: CustomTextStyles.titleLargeff445d48,
                  ),
                  TextSpan(
                    text:
                        "${recommendation}",
                    style: CustomTextStyles.titleLargeff445d48,
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: 2.v),
        ],
      ),
    );
  }
}
