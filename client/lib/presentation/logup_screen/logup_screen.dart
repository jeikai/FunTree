import 'package:flutter/material.dart';
import 'package:funtree/backend/backend.dart';
import 'package:funtree/core/SharePref.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/routes/app_routes.dart';
import 'package:funtree/theme/custom_text_style.dart';
import 'package:funtree/theme/theme_helper.dart';
import 'package:funtree/widgets/ToastNoti.dart';
import 'package:funtree/widgets/custom_elevated_button.dart';
import 'package:funtree/widgets/custom_input.dart';

class LogupScreen extends StatefulWidget {
  const LogupScreen({super.key});

  @override
  State<LogupScreen> createState() => _LogupScreenState();
}

class _LogupScreenState extends State<LogupScreen> {
  TextEditingController _email = TextEditingController();

  TextEditingController _password = TextEditingController();

  TextEditingController _confirmPassword = TextEditingController();

  TextEditingController _username = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool obscure = true;

  bool cfobscure = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
    _username.dispose();
    _confirmPassword.dispose();
  }

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
                                                      text: "Fun Tree\n",
                                                      style: theme.textTheme
                                                          .displayMedium),
                                                  TextSpan(
                                                      text:
                                                          "Please enter your information",
                                                      style: CustomTextStyles
                                                          .bodyMediumff445d48)
                                                ]),
                                                textAlign: TextAlign.left)),
                                        SizedBox(height: 8.v),
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
                                        SizedBox(height: 10.v),
                                        Text("Username:",
                                            style: theme.textTheme.bodyLarge),
                                        SizedBox(height: 8.v),
                                        Input(
                                          textController: _username,
                                          keyboardType: TextInputType.name,
                                          validate: (phonNumberController) {
                                            return null;
                                          },
                                          obscureText: false,
                                          onDataChanged: (value) => {},
                                          Icon: IconButton(
                                            onPressed: () {
                                              _username.clear();
                                            },
                                            icon: const Icon(Icons.clear),
                                          ),
                                        ),
                                        SizedBox(height: 10.v),
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
                                        SizedBox(height: 10.v),
                                        Text("Confirm password:",
                                            style: theme.textTheme.bodyLarge),
                                        SizedBox(height: 10.v),
                                        Input(
                                          textController: _confirmPassword,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validate: (phonNumberController) {
                                            return null;
                                          },
                                          obscureText: cfobscure,
                                          onDataChanged: (value) => {},
                                          Icon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                cfobscure =
                                                    !cfobscure; // Toggle the password visibility
                                              });
                                            },
                                            icon: Icon(
                                              cfobscure
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 11.v),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () => Navigator.pushNamed(
                                                context, AppRoutes.loginScreen),
                                            child: Text(
                                              "Already have an account.",
                                              style:
                                                  CustomTextStyles.bodyMedium14,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 17.v),
                                        CustomElevatedButton(
                                            text: "Logup",
                                            onPressed: () {
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
      if (_password.text == _confirmPassword.text) {
        if (_email.text.isNotEmpty &&
            _password.text.isNotEmpty &&
            _username.text.isNotEmpty) {
          Map<String, dynamic> data = {
            "email": _email.text,
            "password": _password.text,
            "name": _username.text
          };
          var response = await Api().postData("user/register", data);
          print(response);
          if (response?["message"] == "Register successfully") {
            await setUpUser(response);
            ToastNoti.show("Đăng ký thành công");
            Navigator.pop(context);
            onTapLogin(context);
          } else {
            Navigator.pop(context);
            ToastNoti.show("Kiểm tra lại email!");
          }
        } else {
          Navigator.pop(context);
          ToastNoti.show("Vui lòng điền đầy đủ thông tin!");
        }
      } else {
        Navigator.pop(context);
        ToastNoti.show("Mật khẩu không khớp!");
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
