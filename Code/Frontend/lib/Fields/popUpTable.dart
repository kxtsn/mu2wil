// ignore_for_file: file_names, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:my_app/Util/color.dart';

class PopUpTableWidget extends StatelessWidget {
  var title;
  PopUpTableWidget(
    BuildContext context, {
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  Widget content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('close'),
          ),
        ],
        content: Container(
          //height: 250,
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18,
                      color: primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 7),
                content
              ],
            ),
          ),
        ));
  }
}
