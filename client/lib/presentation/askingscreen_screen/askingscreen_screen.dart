import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/core/question.dart';
import 'package:funtree/widgets/app_bar/appbar_trailing_button.dart';
import 'package:funtree/widgets/app_bar/custom_app_bar.dart';

class AskingscreenScreen extends StatefulWidget {

  const AskingscreenScreen({Key? key})
      : super(
    key: key,
  );

  @override
  State<StatefulWidget> createState() => AskingscreenScreenState();
}

class AskingscreenScreenState extends State<AskingscreenScreen> {

  AbQuestion question = q0;
  Map<String, Object> data = {};

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray600,
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 29.h,
            vertical: 16.v,
          ),
          child: Column(
            children: [
              Container(
                width: 260.h,
                margin: EdgeInsets.symmetric(horizontal: 21.h),
                child: Text(
                  "How would you like to go \nabout planting your tree?",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.headlineSmallLightgreen100,
                ),
              ),
              SizedBox(height: 32.v),
              // _buildHowWouldYouLike(context),
              // SizedBox(height: 21.v),
              // _buildSeventyFour(context),
              // SizedBox(height: 5.v),
              ..._buildAnswers(context),
            ],
          ),
        ),
      ),
    );
  }

  void _onTap(Object answer) {
    print("onTap: $answer");
    data[question.id] = answer;
    if(question is Question) {
      setState(() {
        question = (question as Question).answers[answer]!;
      });
    } else if(question is InputQuestion && (question as InputQuestion).nextQuestion != null) {
      setState(() {
        question = (question as InputQuestion).nextQuestion!;
      });
    } else {
      print("data: $data");
    }
  }

  List<Widget> _buildAnswers(BuildContext context) {
    List<Widget> widgets = [];
    if(question is Question) {
      (question as Question).answers.forEach((key, value) {
        widgets.add(_buildAnswerCell(context, key));
        widgets.add(SizedBox(height: 21.v));
      });
    } else if (question is InputQuestion) {
      widgets.add(_buildInputAnswerCell(context, (question as InputQuestion).inputType));
    }
    return widgets;
  }

  /// Section Widget
  Widget _buildAnswerCell(BuildContext context, String answer) {
    if(question is Question) {
      return AnswerCell(
        answer: answer,
        onTap: _onTap,
      );
    } else if (question is InputQuestion) {
      return _buildInputAnswerCell(context, (question as InputQuestion).inputType);
    } else {
      return Container();
    }
  }

  Widget _buildInputAnswerCell(BuildContext context, InputType inputType) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 6.h,
        vertical: 7.v,
      ),
      decoration: AppDecoration.fillLightGreen.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: _buildInputCell(context, inputType),
    );
  }

  Widget _buildInputCell(BuildContext context, InputType inputType) {
    switch (inputType) {
      case InputType.text:
        return TextField(
          style: CustomTextStyles.bodyMediumGray600,
          decoration: InputDecoration(
            hintText: (question as InputQuestion).placeholder ?? "Enter your answer",
            hintStyle: CustomTextStyles.bodyMediumGray600,
          ),
          onSubmitted: (value) {
            _onTap(value);
          },
          onChanged: (value) {
            data[question.id] = value;
          },
        );
      case InputType.number:
        return TextField(
          style: CustomTextStyles.bodyMediumGray600,
          decoration: InputDecoration(
            hintText: (question as InputQuestion).placeholder ?? "Enter your answer",
            hintStyle: CustomTextStyles.bodyMediumGray600,
          ),
          keyboardType: TextInputType.number,
          onSubmitted: (value) {
            _onTap(value);
          },
          onChanged: (value) {
            data[question.id] = value;
          },
        );
      case InputType.date:
        return TextField(
          style: CustomTextStyles.bodyMediumGray600,
          decoration: InputDecoration(
            hintText: (question as InputQuestion).placeholder ?? "Enter your answer",
            hintStyle: CustomTextStyles.bodyMediumGray600,
          ),
          keyboardType: TextInputType.datetime,
          onSubmitted: (value) {
            _onTap(value);
          },
          onChanged: (value) {
            data[question.id] = value;
          },
        );
      case InputType.time:
        return TextField(
          style: CustomTextStyles.bodyMediumGray600,
          decoration: InputDecoration(
            hintText: (question as InputQuestion).placeholder ?? "Enter your answer",
            hintStyle: CustomTextStyles.bodyMediumGray600,
          ),
          keyboardType: TextInputType.datetime,
          onSubmitted: (value) {
            _onTap(value);
          },
          onChanged: (value) {
            data[question.id] = value;
          },
        );
      case InputType.dateTime:
        return TextField(
          style: CustomTextStyles.bodyMediumGray600,
          decoration: InputDecoration(
            hintText: (question as InputQuestion).placeholder ?? "Enter your answer",
            hintStyle: CustomTextStyles.bodyMediumGray600,
          ),
          keyboardType: TextInputType.datetime,
          onSubmitted: (value) {
            _onTap(value);
          },
          onChanged: (value) {
            data[question.id] = value;
          },
        );
      case InputType.email:
        return TextField(
          style: CustomTextStyles.bodyMediumGray600,
          decoration: InputDecoration(
            hintText: (question as InputQuestion).placeholder ?? "Enter your answer",
            hintStyle: CustomTextStyles.bodyMediumGray600,
          ),
          keyboardType: TextInputType.emailAddress,
          onSubmitted: (value) {
            _onTap(value);
          },
          onChanged: (value) {
            data[question.id] = value;
          },
        );
      case InputType.phone:
        return TextField(
          style: CustomTextStyles.bodyMediumGray600,
          decoration: InputDecoration(
            hintText: (question as InputQuestion).placeholder ?? "Enter your answer",
            hintStyle: CustomTextStyles.bodyMediumGray600,
          ),
          keyboardType: TextInputType.phone,
          onSubmitted: (value) {
            _onTap(value);
          },
          onChanged: (value) {
            data[question.id] = value;
          },
        );
      case InputType.url:
        return TextField(
          style: CustomTextStyles.bodyMediumGray600,
          decoration: InputDecoration(
            hintText: (question as InputQuestion).placeholder ?? "Enter your answer",
            hintStyle: CustomTextStyles.bodyMediumGray600,
          ),
          keyboardType: TextInputType.url,
          onSubmitted: (value) {
            _onTap(value);
          },
          onChanged: (value) {
            data[question.id] = value;
          },
        );
      case InputType.password:
        return TextField(
          style: CustomTextStyles.bodyMediumGray600,
          decoration: InputDecoration(
            hintText: (question as InputQuestion).placeholder ?? "Enter your answer",
            hintStyle: CustomTextStyles.bodyMediumGray600,
          ),
          keyboardType: TextInputType.visiblePassword,
          onSubmitted: (value) {
            _onTap(value);
          },
          onChanged: (value) {
            data[question.id] = value;
          },
        );
      case InputType.file:
        return TextField(
          style: CustomTextStyles.bodyMediumGray600,
          decoration: InputDecoration(
            hintText: (question as InputQuestion).placeholder ?? "Enter your answer",
            hintStyle: CustomTextStyles.bodyMediumGray600,
          ),
          keyboardType: TextInputType.text,
          onSubmitted: (value) {
            _onTap(value);
          },
          onChanged: (value) {
            data[question.id] = value;
          },
        );
      case InputType.month:
        return TextField(
          style: CustomTextStyles.bodyMediumGray600,
          decoration: InputDecoration(
            hintText: (question as InputQuestion).placeholder ?? "Enter your answer",
            hintStyle: CustomTextStyles.bodyMediumGray600,
          ),
          keyboardType: TextInputType.datetime,
          onSubmitted: (value) {
            _onTap(value);
          },
          onChanged: (value) {
            data[question.id] = value;
          },
        );
      case InputType.week:
        return TextField(
          style: CustomTextStyles.bodyMediumGray600,
          decoration: InputDecoration(
            hintText: (question as InputQuestion).placeholder ?? "Enter your answer",
            hintStyle: CustomTextStyles.bodyMediumGray600,
          ),
          keyboardType: TextInputType.datetime,
          onSubmitted: (value) {
            _onTap(value);
          },
          onChanged: (value) {
            data[question.id] = value;
          },
        );
      case InputType.range:
        return TextField(
          style: CustomTextStyles.bodyMediumGray600,
          decoration: InputDecoration(
            hintText: (question as InputQuestion).placeholder ?? "Enter your answer",
            hintStyle: CustomTextStyles.bodyMediumGray600,
          ),
          keyboardType: TextInputType.number,
          onSubmitted: (value) {
            _onTap(value);
          },
          onChanged: (value) {
            data[question.id] = value;
          },
        );
      case InputType.search:
        return TextField(
          style: CustomTextStyles.bodyMediumGray600,
          decoration: InputDecoration(
            hintText: (question as InputQuestion).placeholder ?? "Enter your answer",
            hintStyle: CustomTextStyles.bodyMediumGray600,
          ),
          keyboardType: TextInputType.text,
          onSubmitted: (value) {
            _onTap(value);
          },
          onChanged: (value) {
            data[question.id] = value;
          },
        );
      case InputType.tel:
        return TextField(
          style: CustomTextStyles.bodyMediumGray600,
          decoration: InputDecoration(
            hintText: (question as InputQuestion).placeholder ?? "Enter your answer",
            hintStyle: CustomTextStyles.bodyMediumGray600,
          ),
          keyboardType: TextInputType.phone,
          onSubmitted: (value) {
            _onTap(value);
          },
          onChanged: (value) {
            data[question.id] = value;
          },
        );
      case InputType.timeLocal:
        return TextField(
          style: CustomTextStyles.bodyMediumGray600,
          decoration: InputDecoration(
            hintText: (question as InputQuestion).placeholder ?? "Enter your answer",
            hintStyle: CustomTextStyles.bodyMediumGray600,
          ),
          keyboardType: TextInputType.datetime,
          onSubmitted: (value) {
            _onTap(value);
          },
          onChanged: (value) {
            data[question.id] = value;
          },
        );
      case InputType.color:
        return Container();
    }
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 52.v,
      title: Row(
        children: [
          Container(
            height: 40.adaptSize,
            width: 40.adaptSize,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  ImageConstant.imgTreePlanting40x40,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 26.adaptSize,
            width: 26.adaptSize,
            margin: EdgeInsets.only(top: 14.v),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  ImageConstant.imgPottedPlant,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 40.adaptSize,
            width: 40.adaptSize,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  ImageConstant.imgOakTree,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 40.adaptSize,
            width: 40.adaptSize,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  ImageConstant.imgOakTree40x40,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      actions: [
        AppbarTrailingButton(
          margin: EdgeInsets.fromLTRB(9.h, 13.v, 9.h, 12.v),
        ),
      ],
    );
  }
}

class AnswerCell extends StatelessWidget {
  final String answer;
  final Function(String) onTap;

  const AnswerCell({super.key, required this.answer, required this.onTap});

  @override
  Widget build(BuildContext context) {
    List<String> lines = splitString(answer);
    List<Widget> widgets = [];
    for(var line in lines) {
      var (isR, text) = isRecommended(line);
      widgets.add(Text(
        text,
        style: isR ? CustomTextStyles.bodyMediumOnError : CustomTextStyles.bodyMediumGray600,
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
                children: [
                  ...widgets
                ],
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


List<String> splitString(String input) {
  return input.split(" /n ");
}

(bool, String) isRecommended(String input) {
  if (input.startsWith("r-")) {
    return (true, input.substring(2));
  }
  return (false, input);
}
