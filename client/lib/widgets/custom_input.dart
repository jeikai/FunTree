import 'package:flutter/material.dart';
import 'package:funtree/theme/custom_text_style.dart';

class Input extends StatelessWidget {
  const Input({
    Key? key,
    required this.textController,
    required this.validate,
    required this.keyboardType,
    required this.onDataChanged,
    required this.Icon,
    required this.obscureText,
  }) : super(key: key);
  final TextEditingController textController;
  final String? Function(String?)? validate;
  final TextInputType keyboardType;
  final Function(String) onDataChanged;
  final Widget? Icon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        style: CustomTextStyles.bodyMediumGreen600,
        maxLines: 1,
        keyboardType: keyboardType,
        onTapOutside: (event) => {FocusScope.of(context).unfocus()},
        controller: textController,
        validator: validate,
        enableSuggestions: true,
        onChanged: onDataChanged,
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          suffixIconColor: Color.fromRGBO(74, 134, 86, 1.0),
          suffixIcon: Icon,
          hintStyle: TextStyle(
            color: Color.fromRGBO(74, 134, 86, 1.0),
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
