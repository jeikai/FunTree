import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';

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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillOnError1,
          child: Column(
            children: [
              SizedBox(height: 21.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 21.h),
                child: Column(
                  children: [
                    _buildWeatherSection(context),
                    SizedBox(height: 13.v),
                    _buildFunTreeSection(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildWeatherSection(BuildContext context) {
    return Container(
      width: 317.h,
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
              CustomImageView(
                imagePath: ImageConstant.imgSunBehindSmall,
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
                        text: "Temperature: 29° AQI: ",
                        style: CustomTextStyles.bodySmallff445d48,
                      ),
                      TextSpan(
                        text: "112 Humidity: 95%\nWind: 13 km/h",
                        style: CustomTextStyles.bodySmallffff9b57,
                      ),
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
            width: 303.h,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Weather: ",
                    style: CustomTextStyles.titleLargeff445d48,
                  ),
                  TextSpan(
                    text:
                        "Bad for health Air Quality:\nAn AQI of 112 indicates \"unhealthy\" air quality,\n so it's advisable to limit opening windows to \nprevent dust and pollutants from entering the \nroom.Use an air purifier to improve air quality \nindoors.Grow additional indoor plants with air \npurifying capabilities.\nHumidity:\nA humidity level of 95% is relatively high and \ncan cause discomfort and health issues. It's \nrecommended to use a dehumidifier to reduce \nhumidity levels indoors.Open windows during \nsunny weather to ventilate the room.Avoid \ndrying clothes indoors in the bedroom.",
                    style: CustomTextStyles.titleLargeffff9b57,
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
