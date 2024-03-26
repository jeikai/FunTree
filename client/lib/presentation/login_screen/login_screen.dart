import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/widgets/custom_elevated_button.dart';
import 'package:funtree/widgets/custom_input.dart';
import 'package:funtree/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
              child: Container(
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
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 27.h, vertical: 29.v),
                                decoration: AppDecoration.fillOnError.copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.customBorderTL30),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: 222.h,
                                          margin: EdgeInsets.only(right: 84.h),
                                          child: RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text: "WELCOME\n",
                                                    style: theme.textTheme
                                                        .displayMedium),
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
                                      Input(
                                        textController: phoneNumberController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validate: (phonNumberController) {
                                          return null;
                                        },
                                        obscureText: false,
                                        onDataChanged: (value) => {},
                                        Icon: IconButton(
                                          onPressed: () {
                                            phoneNumberController.clear();
                                          },
                                          icon: const Icon(Icons.clear),
                                        ),
                                      ),
                                      SizedBox(height: 26.v),
                                      Text("Password:",
                                          style: theme.textTheme.bodyLarge),
                                      SizedBox(height: 10.v),
                                      Input(
                                        textController: passwordController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validate: (phonNumberController) {
                                          return null;
                                        },
                                        obscureText: obscure,
                                        onDataChanged: (value) => {},
                                        Icon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              obscure =
                                                  !obscure; // Toggle the password visibility
                                            });
                                          },
                                          icon: Icon(
                                            obscure
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 11.v),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Text("Don’t have account?",
                                              style: CustomTextStyles
                                                  .bodyMedium14)),
                                      SizedBox(height: 17.v),
                                      CustomElevatedButton(
                                          text: "Login",
                                          onPressed: () {
                                            onTapLogin(context);
                                          }),
                                      SizedBox(height: 49.v),
                                    ])))
                      ]))))),
    );
  }

  onTapLogin(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homescreenScreen);
  }
}
