import 'package:flutter/material.dart';
import 'text_field_container.dart';
import '../constants.dart';

class MyRoundedInputField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator validator;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const MyRoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.email,
    required this.controller,required this.validator,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
