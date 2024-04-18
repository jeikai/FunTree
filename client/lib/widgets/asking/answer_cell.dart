import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/widgets/asking/asking_util.dart';

class AnswerCell extends StatelessWidget {
  final String answer;
  final Function(String) onTap;

  const AnswerCell({super.key, required this.answer, required this.onTap});

  @override
  Widget build(BuildContext context) {
    List<String> lines = AskingUtil.splitString(answer);
    List<Widget> widgets = [];
    for (var line in lines) {
      var (isR, text) = AskingUtil.isRecommended(line);
      widgets.add(Text(
        text,
        style: isR
            ? CustomTextStyles.bodyMediumOnError
            : CustomTextStyles.bodyMediumGray600,
      ));
      widgets.add(SizedBox(height: 4.v));
    }
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 6.h,
        vertical: 7.v,
      ),
      decoration: AppDecoration.fillLightGreen.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: InkWell(
        onTap: () {
          onTap(answer);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 3.h,
                top: 2.v,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [...widgets],
              ),
            ),
            CustomImageView(
              imagePath: ImageConstant.imgForward,
              height: 15.adaptSize,
              width: 15.adaptSize,
              margin: EdgeInsets.symmetric(vertical: 11.v),
            ),
          ],
        ),
      ),
    );
  }
}