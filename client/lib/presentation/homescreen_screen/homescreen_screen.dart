import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funtree/backend/backend.dart';
import 'package:funtree/core/SharePref.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/widgets/Header.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:funtree/widgets/custom_search_view.dart';
import 'package:funtree/widgets/home_screen/home_map.dart';
import 'package:get/get.dart';

class HomescreenScreen extends StatefulWidget {
  const HomescreenScreen({Key? key}) : super(key: key);

  @override
  State<HomescreenScreen> createState() => _HomescreenScreenState();
}

double latitude = 0.0;
double longitude = 0.0;
int AQI = 0;
int humidity = 0;
double wind = 0.00;
double temp = 0.0;
String image = "";
bool isWeatherFetched = false;

String currentAddress = "";

bool isCurrentAddressFetched = false;

class _HomescreenScreenState extends State<HomescreenScreen> {
  TextEditingController searchController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  bool isLoading = true;

  Future<void> _determinePosition() async {
    if (currentAddress != "") {
      return;
    }
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
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    currentAddress = "${place.locality}, ${place.country}";
    SharePref.setLangtitude(latitude);
    SharePref.setLongtitude(longitude);
    SharePref.setAddress(currentAddress);
    isCurrentAddressFetched = true;
  }

  Future<void> getWeather() async {
    if (AQI != 0 && humidity != 0 && wind != 0.00 && temp != 0.0) {
      return;
    }
    try {
      final response =
          await Api().getData("weather/current?lat=${latitude}&lng=${longitude}");
      if (response != null) {
        AQI = response["data"]["airQuality"]["aqi"] ?? 0.0;
        humidity = response["data"]["weather"]["humidity"]!;
        wind = response["data"]["weather"]["wind_kph"];
        temp = response["data"]["weather"]["temp_c"].toDouble();
        image = response["data"]["weather"]["condition"]["icon"];
        await SharePref.setTemp(temp);
        await SharePref.setAqi(AQI);
        await SharePref.setHumidity(humidity);
        await SharePref.setWind(wind);
        await SharePref.setWeatherImage(image);
        isWeatherFetched = true;
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
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: SizeUtils.height,
              maxWidth: SizeUtils.width,
            ),
            decoration: BoxDecoration(
              color: appTheme.green300Bc,
              image: DecorationImage(
                image: AssetImage(ImageConstant.imgLogin),
                fit: BoxFit.cover,
              ),
            ),
            child: getCurrentPage(),
          ),
        ),
      ),
    );
  }

  Widget getCurrentPage() {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Header(
            temp: temp,
            aqi: AQI,
            humidity: humidity,
            wind: wind,
            currentAddress: currentAddress,
            image: image
          ),
          SizedBox(height: 5.v),
          Expanded(
            child: Container(
              height: 570.v,
              padding: EdgeInsets.symmetric(horizontal: 13.h, vertical: 13.v),
              decoration: AppDecoration.fillGreen.copyWith(
                borderRadius: BorderRadiusStyle.customBorderTL30,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HomeMap(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void onTapBedroom(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.caredetailscreenPage);
}
