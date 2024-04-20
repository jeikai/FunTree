import 'package:funtree/core/SharePref.dart';
import 'package:funtree/widgets/Header.dart';

import '../shoppingscreen_page/widgets/userprofile_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/widgets/custom_icon_button.dart';
import 'package:funtree/widgets/custom_search_view.dart';

class ShoppingscreenPage extends StatefulWidget {
  ShoppingscreenPage({Key? key})
      : super(
          key: key,
        );

  @override
  State<ShoppingscreenPage> createState() => _ShoppingscreenPageState();
}

double latitude = 0.0;
double longitude = 0.0;
int AQI = 0;
int humidity = 0;
double wind = 0.00;
double temp = 0.0;
String currentAddress = "";
String image = "";

class _ShoppingscreenPageState extends State<ShoppingscreenPage> {
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> getInfor() async {
    latitude = (await SharePref.getTemp()!);
    longitude = (await SharePref.getLongtitude()!);
    temp = (await SharePref.getTemp())!;
    AQI = (await SharePref.getAqi()!);
    humidity = (await SharePref.getHumidity()!);
    wind = (await SharePref.getWind()!);
    currentAddress = (await SharePref.getAdress())!;
    image = (await SharePref.getWeatherImage()!);
  }

  Future<void> _fetchData() async {
    await getInfor();
    setState(() {
      isLoading = false;
    });
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
            image: image,
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
                  CustomSearchView(
                    controller: searchController,
                    hintText: "Search",
                  ),
                  SizedBox(height: 32.v),
                  _buildUserProfile(context),
                  SizedBox(height: 32.v),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 9.h),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 174.v,
          crossAxisCount: 2,
          mainAxisSpacing: 22.h,
          crossAxisSpacing: 22.h,
        ),
        physics: NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return UserprofileItemWidget();
        },
      ),
    );
  }
}
