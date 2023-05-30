import 'package:flutter/material.dart';
import 'text_field_container.dart';
import '../constants.dart';

class RoundedInputFieldClaim extends StatelessWidget {
  final String hintText;
  //final IconData icon;
  final ValueChanged<String> onChanged;
    final TextEditingController controller;
  final FormFieldValidator validator;
  const RoundedInputFieldClaim({
    Key? key,
    required this.hintText,
    // this.icon = Icons.person,
    required this.onChanged,
    required this.controller,required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          // icon: Icon(
          //   icon,
          //   color: kPrimaryColor,
          // ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
