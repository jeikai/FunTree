import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/core/question.dart';
import 'package:funtree/widgets/app_bar/appbar_trailing_button.dart';
import 'package:funtree/widgets/app_bar/custom_app_bar.dart';
import 'package:funtree/widgets/asking/answer_cell.dart';
import 'package:funtree/widgets/asking/input_cell_resolver.dart';

class AskingscreenScreen extends StatefulWidget {
  const AskingscreenScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<StatefulWidget> createState() => AskingscreenScreenState();
}

/// Data map to store the answers
/// This will be made public to be accessed from other screens
/// If you want to reset the data, just set it to an empty map
/// Remember to reset the data before navigating to this screen again
Map<String, Object> data = {};

class AskingscreenScreenState extends State<AskingscreenScreen> {
  AbQuestion? question = q0;

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
              ..._buildAnswers(context),
            ],
          ),
        ),
      ),
    );
  }

  // On tap on any answer or on submit input cell
  void _onTap(Object answer) {
    // check if the current question is not null
    if (question == null) {
      return;
    }
    print("onTap: $answer");
    // save the answer to the data map, store the answer with the key is the question id
    data[question!.id] = answer;
    // check the current question is a type of Question or InputQuestion
    if (question is Question) {
      // if current question is a type of Question, then get the next question by the answer
      // answers is a map of next question with the key is the answer
      setState(() {
        question = (question as Question).answers[answer];
        if (question == null) {
          // if the next question is null, then call the onLastQuestion function
          _onLastQuestion();
        }
      });
    } else if (question is InputQuestion &&
        (question as InputQuestion).nextQuestion != null) {
      // if current question is a type of InputQuestion, then get the next question by the nextQuestion
      setState(() {
        question = (question as InputQuestion).nextQuestion;
        if (question == null) {
          // if the next question is null, then call the onLastQuestion function
          _onLastQuestion();
        }
      });
    } else {
      _onLastQuestion();
    }
  }

  /// This is the function that will be called when the current question is the last question
  _onLastQuestion() {
    //when the current question is the last question, then submit the data

    print("data: $data");
    //TODO: Upload data to server

    // then navigate to the camera screen
    Navigator.pushNamed(context, AppRoutes.camerascreenScreen);
  }

  /// This is the place that mapping from Question Data structure to Widget
  /// Each AbQuestion has a different way to display
  /// Question is a type of AbQuestion that has a list of answers so it will be displayed as a list of answers
  /// InputQuestion is a type of AbQuestion that has an inputType so it will be displayed as an input cell
  List<Widget> _buildAnswers(BuildContext context) {
    // List of widgets that will be displayed
    List<Widget> widgets = [];
    // Check the current question is a type of Question or InputQuestion
    if (question is Question) {
      // if current question is a type of Question, then get the answers and display them
      // each answer will be displayed as an AnswerCell, gap between each answer is 21.v
      (question as Question).answers.forEach((key, value) {
        widgets.add(_buildAnswerCell(context, key));
        widgets.add(SizedBox(height: 21.v));
      });
    } else if (question is InputQuestion) {
      // if current question is a type of InputQuestion, then display an input cell
      widgets.add(_buildInputAnswerCell(
          context, (question as InputQuestion).inputType));
    }
    return widgets;
  }

  /// This is the function to build an AnswerCell
  Widget _buildAnswerCell(BuildContext context, String answer) {
    return AnswerCell(
      answer: answer,
      onTap: _onTap,
    );
  }

  /// This is the function to build an InputCell
  /// This uses InputCellResolver to resolve the inputType to the corresponding widget
  Widget _buildInputAnswerCell(BuildContext context, InputType inputType) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 6.h,
        vertical: 7.v,
      ),
      decoration: AppDecoration.fillLightGreen.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      /// This function will return the corresponding widget based on the inputType
      child: _buildInputCell(context, inputType),
    );
  }

  Widget _buildInputCell(BuildContext context, InputType inputType) {
    return InputCellResolver.resolve(context, inputType, question, data, _onTap);
  }

  /// Casual AppBar for this screen
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
