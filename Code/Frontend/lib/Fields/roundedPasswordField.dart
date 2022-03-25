// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_app/Fields/textFieldContainer.dart';
import 'package:my_app/Util/color.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final double widthSize;
  final String? errorText;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
    required this.widthSize,
    this.errorText,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      widthSize: widget.widthSize,
      child: TextField(
        obscureText: _isObscure,
        onChanged: widget.onChanged,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          errorText: widget.errorText,
          suffixIcon: IconButton(
              icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              }),
        ),
      ),
    );
  }
}
