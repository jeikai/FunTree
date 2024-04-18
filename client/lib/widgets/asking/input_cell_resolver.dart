import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/core/question.dart';

class InputCellResolver {
  static Widget resolve(BuildContext context,
      InputType inputType,
      AbQuestion question,
      Map<String, dynamic> data,
      Function(String) _onTap) {
    switch (inputType) {
      case InputType.text:
        return TextField(
          style: CustomTextStyles.bodyMediumGray600,
          decoration: InputDecoration(
            hintText:
            (question as InputQuestion).placeholder ?? "Enter your answer",
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
            hintText:
            (question as InputQuestion).placeholder ?? "Enter your answer",
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
            hintText:
            (question as InputQuestion).placeholder ?? "Enter your answer",
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
            hintText:
            (question as InputQuestion).placeholder ?? "Enter your answer",
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
            hintText:
            (question as InputQuestion).placeholder ?? "Enter your answer",
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
            hintText:
            (question as InputQuestion).placeholder ?? "Enter your answer",
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
            hintText:
            (question as InputQuestion).placeholder ?? "Enter your answer",
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
            hintText:
            (question as InputQuestion).placeholder ?? "Enter your answer",
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
            hintText:
            (question as InputQuestion).placeholder ?? "Enter your answer",
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
            hintText:
            (question as InputQuestion).placeholder ?? "Enter your answer",
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
            hintText:
            (question as InputQuestion).placeholder ?? "Enter your answer",
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
            hintText:
            (question as InputQuestion).placeholder ?? "Enter your answer",
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
            hintText:
            (question as InputQuestion).placeholder ?? "Enter your answer",
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
            hintText:
            (question as InputQuestion).placeholder ?? "Enter your answer",
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
            hintText:
            (question as InputQuestion).placeholder ?? "Enter your answer",
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
            hintText:
            (question as InputQuestion).placeholder ?? "Enter your answer",
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
}