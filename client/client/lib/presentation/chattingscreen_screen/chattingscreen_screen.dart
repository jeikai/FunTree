import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/widgets/app_bar/appbar_subtitle.dart';
import 'package:funtree/widgets/app_bar/appbar_title_image.dart';
import 'package:funtree/widgets/app_bar/custom_app_bar.dart';
import 'package:funtree/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class ChattingscreenScreen extends StatelessWidget {
  ChattingscreenScreen({Key? key}) : super(key: key);

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.green50,
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 20.v),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                              height: 56.v,
                              width: 238.h,
                              child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                            margin:
                                                EdgeInsets.only(right: 16.h),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.h,
                                                vertical: 10.v),
                                            decoration: AppDecoration
                                                .fillGreen60001
                                                .copyWith(
                                                    borderRadius:
                                                        BorderRadiusStyle
                                                            .roundedBorder10),
                                            child: Text(
                                                "The ways to recycle lead-acid batteries?",
                                                style: CustomTextStyles
                                                    .bodySmallOnError_1))),
                                    CustomImageView(
                                        imagePath: ImageConstant.imgArrowUp,
                                        height: 40.v,
                                        width: 39.h,
                                        alignment: Alignment.bottomRight)
                                  ]))),
                      SizedBox(height: 5.v),
                      Container(
                          height: 427.v,
                          width: 308.h,
                          margin: EdgeInsets.only(left: 13.h),
                          child:
                              Stack(alignment: Alignment.bottomLeft, children: [
                            Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                    margin: EdgeInsets.only(left: 14.h),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.h, vertical: 3.v),
                                    decoration: AppDecoration.fillGreen60001
                                        .copyWith(
                                            borderRadius: BorderRadiusStyle
                                                .roundedBorder10),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 4.v),
                                          Container(
                                              width: 273.h,
                                              margin:
                                                  EdgeInsets.only(right: 2.h),
                                              child: Text(
                                                  "Lead-acid batteries are commonly used in vehicles, \nuninterruptible power supplies (UPS), and various\nother applications. Recycling these batteries is crucial \nbecause they contain hazardous materials such as \nlead and sulfuric acid. Here are the typical steps \ninvolved in recycling lead-acid batteries:\nCollection: Used lead-acid batteries are collected \nfrom various sources, including automotive repair \nshops, recycling centers, and battery retailers. Many \njurisdictions have specific regulations governing the \ncollection and transportation of these batteries due \nto their hazardous nature.\nTransportation: Once collected, the batteries are \ntransported to specialized recycling facilities. During \ntransportation, it's essential to prevent any spills or leaks \nof the battery acid, as it can cause environmental damage.\nDraining: At the recycling facility, the batteries are \ntypically drained of any remaining sulfuric acid. This acid \ncan be neutralized and treated to make it safe for disposal \nor reuse in other industrial processes.\nBreaking: The batteries are mechanically crushed or \nbroken apart to separate the plastic casing, lead plates, \nand other components. This process is usually done in a \ncontrolled environment to minimize the release of \nhazardous materials.\nSorting: The broken battery components are sorted \ninto different materials, primarily lead, plastic, and lead \noxide (a byproduct of the recycling process). Magnets may \nbe used to separate the lead plates from other materials, \nas lead is highly magnetic.",
                                                  maxLines: 30,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: CustomTextStyles
                                                      .bodySmallOnError_1))
                                        ]))),
                            CustomImageView(
                                imagePath: ImageConstant.imgThumbsUp,
                                height: 41.v,
                                width: 37.h,
                                alignment: Alignment.bottomLeft)
                          ]))
                    ])),
            bottomNavigationBar: _buildMessage(context)));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 56.v,
        centerTitle: true,
        title: Column(children: [
          Padding(
              padding: EdgeInsets.only(left: 7.h, right: 249.h),
              child: Row(children: [
                AppbarTitleImage(
                    imagePath: ImageConstant.imgBack20x20,
                    onTap: () {
                      onTapBack(context);
                    }),
                AppbarTitleImage(
                    imagePath: ImageConstant.imgSettings,
                    margin: EdgeInsets.only(left: 11.h)),
                AppbarSubtitle(
                    text: "Tree AI", margin: EdgeInsets.only(left: 5.h))
              ])),
          SizedBox(height: 14.v),
          Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                  width: double.maxFinite,
                  child: Divider(
                      color: theme.colorScheme.primary.withOpacity(0.29))))
        ]),
        styleType: Style.bgFill);
  }

  /// Section Widget
  Widget _buildMessage(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 15.h, right: 16.h, bottom: 20.v),
        child: CustomTextFormField(
            controller: messageController,
            hintText: "Message...",
            textInputAction: TextInputAction.done,
            suffix: Container(
                margin: EdgeInsets.fromLTRB(30.h, 7.v, 9.h, 6.v),
                child: CustomImageView(
                    imagePath: ImageConstant.imgEmailSend,
                    height: 20.adaptSize,
                    width: 20.adaptSize)),
            suffixConstraints: BoxConstraints(maxHeight: 33.v),
            contentPadding: EdgeInsets.only(left: 9.h, top: 9.v, bottom: 9.v)));
  }

  /// Navigates to the homescreenScreen when the action is triggered.
  onTapBack(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homescreenScreen);
  }
}
