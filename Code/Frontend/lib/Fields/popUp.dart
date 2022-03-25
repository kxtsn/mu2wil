// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

class PopUpWidget extends StatelessWidget {
  PopUpWidget(
    BuildContext context, {
    Key? key,
    required this.title,
    required this.subTitle,
    required this.onPressed,
    required this.icon,
    required this.iconColor,
    required this.iconSize,
    this.setConfirmBtn = true,
  }) : super(key: key);

  String title, subTitle;
  Function()? onPressed;
  IconData? icon;
  Color iconColor;
  double iconSize;
  bool setConfirmBtn;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: iconSize,
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Text(subTitle,
                  style: const TextStyle(
                    color: Colors.black,
                  )),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        Visibility(
          child: ElevatedButton(
              onPressed: onPressed, child: const Text("Confirm")),
          visible: setConfirmBtn,
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
