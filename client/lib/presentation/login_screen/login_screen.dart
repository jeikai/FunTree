import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/widgets/custom_elevated_button.dart';
import 'package:funtree/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: false,
            body: Container(
                constraints: BoxConstraints(
                  maxHeight: SizeUtils.height,
                  maxWidth: SizeUtils.width,
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(ImageConstant.imgLogin),
                        fit: BoxFit.cover)),
                child: SizedBox(
                    width: double.maxFinite,
                    child: Column(children: [
                      SizedBox(height: 73.v),
                      CustomImageView(
                          imagePath: ImageConstant.imgTreePlanting,
                          height: 90.adaptSize,
                          width: 90.adaptSize),
                      SizedBox(height: 1.v),
                      Text("FUN TREE",
                          style: CustomTextStyles.displayMediumLightgreen100),
                      SizedBox(height: 40.v),
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 27.h, vertical: 29.v),
                          decoration: AppDecoration.fillOnError.copyWith(
                              borderRadius: BorderRadiusStyle.customBorderTL30),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: 222.h,
                                    margin: EdgeInsets.only(right: 84.h),
                                    child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: "WELCOME\n",
                                              style: theme
                                                  .textTheme.displayMedium),
                                          TextSpan(
                                              text:
                                                  "Please enter your information",
                                              style: CustomTextStyles
                                                  .bodyMediumff445d48)
                                        ]),
                                        textAlign: TextAlign.left)),
                                SizedBox(height: 10.v),
                                Text("Email/phonenumber:",
                                    style: theme.textTheme.bodyLarge),
                                SizedBox(height: 8.v),
                                CustomTextFormField(
                                    controller: phoneNumberController,
                                    suffix: Container(
                                        margin: EdgeInsets.only(
                                            left: 30.h, bottom: 7.v),
                                        child: CustomImageView(
                                            imagePath: ImageConstant.imgPerson,
                                            height: 25.adaptSize,
                                            width: 25.adaptSize)),
                                    suffixConstraints:
                                        BoxConstraints(maxHeight: 32.v),
                                    borderDecoration: TextFormFieldStyleHelper
                                        .underLinePrimary,
                                    filled: false),
                                SizedBox(height: 26.v),
                                Text("Password:",
                                    style: theme.textTheme.bodyLarge),
                                SizedBox(height: 10.v),
                                CustomTextFormField(
                                    controller: passwordController,
                                    textInputAction: TextInputAction.done,
                                    suffix: Container(
                                        margin: EdgeInsets.only(
                                            left: 30.h, bottom: 7.v),
                                        child: CustomImageView(
                                            imagePath: ImageConstant.imgHide,
                                            height: 25.adaptSize,
                                            width: 25.adaptSize)),
                                    suffixConstraints:
                                        BoxConstraints(maxHeight: 32.v),
                                    obscureText: true,
                                    borderDecoration: TextFormFieldStyleHelper
                                        .underLinePrimary,
                                    filled: false),
                                SizedBox(height: 11.v),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Text("Don’t have account?",
                                        style: CustomTextStyles.bodyMedium14)),
                                SizedBox(height: 17.v),
                                CustomElevatedButton(
                                    text: "Login",
                                    onPressed: () {
                                      onTapLogin(context);
                                    }),
                                SizedBox(height: 49.v),
                                CustomImageView(
                                    imagePath: ImageConstant.imgGoogle,
                                    height: 54.adaptSize,
                                    width: 54.adaptSize,
                                    alignment: Alignment.center),
                                SizedBox(height: 20.v)
                              ]))
                    ])))));
  }

  onTapLogin(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homescreenScreen);
  }
}
