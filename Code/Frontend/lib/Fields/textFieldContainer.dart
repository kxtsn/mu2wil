// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_app/Util/color.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final double widthSize;
  const TextFieldContainer({
    Key? key,
    required this.child,
    required this.widthSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: widthSize,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
