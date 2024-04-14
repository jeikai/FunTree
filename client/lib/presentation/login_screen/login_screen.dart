import 'package:flutter/material.dart';
import 'package:funtree/backend/backend.dart';
import 'package:funtree/core/SharePref.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/widgets/ToastNoti.dart';
import 'package:funtree/widgets/custom_elevated_button.dart';
import 'package:funtree/widgets/custom_input.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = TextEditingController();

  TextEditingController _password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool obscure = true;

  bool isRuntimered = false;

  Future<void> runTimer(BuildContext context) async {
    if (SharePref.getUserId() != null &&
        SharePref.getUserId() != '' &&
        SharePref.getEmail() != null &&
        SharePref.getEmail() != '' &&
        SharePref.getName() != null &&
        SharePref.getName() != '') {
      print('There are local login data found!');
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return WillPopScope(
                child: Dialog(
                  backgroundColor: Colors.transparent,
                  child: Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                onWillPop: () async => false);
          });
      Navigator.pop(context);
      print('Successfully setup user!');
      Navigator.pushReplacementNamed(context, AppRoutes.navigationMenu);
    } else {
      print("There is no local login data");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isRuntimered) {
      // runTimer(context);
      isRuntimered = true;
    }
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
                              child: Form(
                                  key: _formKey,
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: 222.h,
                                            margin:
                                                EdgeInsets.only(right: 84.h),
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
                                        Text("Email:",
                                            style: theme.textTheme.bodyLarge),
                                        SizedBox(height: 8.v),
                                        Input(
                                          textController: _email,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validate: (phonNumberController) {
                                            return null;
                                          },
                                          obscureText: false,
                                          onDataChanged: (value) => {},
                                          Icon: IconButton(
                                            onPressed: () {
                                              _email.clear();
                                            },
                                            icon: const Icon(Icons.clear),
                                          ),
                                        ),
                                        SizedBox(height: 26.v),
                                        Text("Password:",
                                            style: theme.textTheme.bodyLarge),
                                        SizedBox(height: 10.v),
                                        Input(
                                          textController: _password,
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
                                              // onTapLogin(context);
                                              onPress(context);
                                            }),
                                        SizedBox(height: 49.v),
                                      ]))),
                        )
                      ]))))),
    );
  }

  onPress(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
              child: Dialog(
                backgroundColor: Colors.transparent,
                child: Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              onWillPop: () async => false);
        });
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        "email": _email.text,
        "password": _password.text,
      };
      var response = await Api().postData("user/login", data);
      print(response);
      if (response?["message"] == "Login successfully") {
        await setUpUser(response);
        ToastNoti.show("Đăng nhập thành công");
        Navigator.pop(context);
        onTapLogin(context);
      } else {
        Navigator.pop(context);
        ToastNoti.show("Sai email hoặc mật khẩu");
      }
    } else {
      Navigator.pop(context);
      ToastNoti.show("Có lỗi");
    }
  }

  setUpUser(dynamic response) async {
    if (response != null) {
      await SharePref.setUserId(response["account"]["_id"]);
      await SharePref.setEmail(response["account"]["email"]);
      await SharePref.setName(response["account"]["name"]);
    } else {
      print("Error: Login response is null");
    }
  }

  onTapLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoutes.navigationMenu);
  }
}
