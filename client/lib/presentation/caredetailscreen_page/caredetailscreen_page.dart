import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class CaredetailscreenPage extends StatefulWidget {
  const CaredetailscreenPage({Key? key})
      : super(
          key: key,
        );

  @override
  CaredetailscreenPageState createState() => CaredetailscreenPageState();
}

class CaredetailscreenPageState extends State<CaredetailscreenPage>
    with AutomaticKeepAliveClientMixin<CaredetailscreenPage> {
  TextEditingController measurementController = TextEditingController();

  TextEditingController weightController = TextEditingController();

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillGreen,
          child: Column(
            children: [
              SizedBox(height: 19.v),
              _buildUserProfile(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildUserProfile(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 13.h),
            child: Text(
              "Next in: 14 days",
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ),
        SizedBox(height: 10.v),
        Container(
          margin: EdgeInsets.only(
            left: 12.h,
            right: 20.h,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 5.h,
            vertical: 6.v,
          ),
          decoration: AppDecoration.fillOnError1.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder10,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgWater,
                height: 20.adaptSize,
                width: 20.adaptSize,
                margin: EdgeInsets.only(
                  left: 3.h,
                  top: 2.v,
                  bottom: 2.v,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 3.h,
                  top: 3.v,
                  bottom: 3.v,
                ),
                child: Text(
                  "Water: 100-150ml",
                  style: CustomTextStyles.bodyMediumGreen600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 13.v),
        Container(
          margin: EdgeInsets.only(
            left: 12.h,
            right: 20.h,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 5.h,
            vertical: 6.v,
          ),
          decoration: AppDecoration.fillOnError1.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder10,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgSolidFertilizer,
                height: 20.adaptSize,
                width: 20.adaptSize,
                margin: EdgeInsets.only(
                  left: 3.h,
                  top: 2.v,
                  bottom: 2.v,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 3.h,
                  top: 3.v,
                  bottom: 3.v,
                ),
                child: Text(
                  "Fertilizer: 5-10g",
                  style: CustomTextStyles.bodyMediumGreen600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 17.v),
        Divider(),
        SizedBox(height: 12.v),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 13.h),
            child: Text(
              "Today",
              style: CustomTextStyles.bodyMediumBluegray700,
            ),
          ),
        ),
        SizedBox(height: 10.v),
        Container(
          margin: EdgeInsets.only(
            left: 12.h,
            right: 20.h,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 5.h,
            vertical: 6.v,
          ),
          decoration: AppDecoration.fillOnError1.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder10,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgUncheckedCheckbox,
                height: 25.adaptSize,
                width: 25.adaptSize,
              ),
              CustomImageView(
                imagePath: ImageConstant.imgWater,
                height: 20.adaptSize,
                width: 20.adaptSize,
                margin: EdgeInsets.only(
                  left: 3.h,
                  top: 2.v,
                  bottom: 2.v,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 3.h,
                  top: 3.v,
                  bottom: 3.v,
                ),
                child: Text(
                  "Water: 100-150ml",
                  style: CustomTextStyles.bodyMediumGreen600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
