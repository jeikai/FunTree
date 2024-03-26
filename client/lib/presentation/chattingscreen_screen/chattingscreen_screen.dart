import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/widgets/app_bar/appbar_subtitle.dart';
import 'package:funtree/widgets/app_bar/appbar_title_image.dart';
import 'package:funtree/widgets/app_bar/custom_app_bar.dart';
import 'package:funtree/widgets/custom_text_form_field.dart';
import 'chatmessage.dart';

class ChattingscreenScreen extends StatefulWidget {
  const ChattingscreenScreen({super.key});

  @override
  State<ChattingscreenScreen> createState() => _ChattingscreenScreenState();
}

class _ChattingscreenScreenState extends State<ChattingscreenScreen> {
  TextEditingController messageController = TextEditingController();
  final List<ChatMessage> _message = [];
  final _formKey = GlobalKey<FormState>();
  bool _isTyping = false;

  @override
  void dispose() {
    super.dispose();
  }

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

                ),
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
