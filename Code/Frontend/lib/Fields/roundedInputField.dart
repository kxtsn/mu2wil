// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:my_app/Fields/textFieldContainer.dart';
import 'package:flutter/services.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final IconData icon;
  final double widthSize;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final TextEditingController? textController;
  dynamic readOnly;
  void Function()? onClick;
  final bool? enabled;
  String? labelText;
  List<TextInputFormatter>? inputFormatters;
  TextInputType? keyboardType;

  RoundedInputField(
      {Key? key,
      required this.widthSize,
      this.hintText,
      this.icon = Icons.person,
      this.onChanged,
      this.errorText,
      this.textController,
      this.readOnly = false,
      this.onClick,
      this.labelText,
      this.inputFormatters,
      this.enabled,
      this.keyboardType})
      : super(key: key);

  bool filled = false;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      widthSize: widthSize,
      child: TextField(
        keyboardType: keyboardType,
        enabled: enabled,
        onTap: onClick,
        controller: textController,
        onChanged: onChanged,
        readOnly: readOnly,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: labelText,
          errorText: errorText,
          hintText: hintText,
        ),
      ),
    );
  }
}
