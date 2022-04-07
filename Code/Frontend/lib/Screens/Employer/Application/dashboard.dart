// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:my_app/Fields/header.dart';
import 'package:my_app/Screens/Employer/Application/applicationDisplay.dart';

//import 'ApplicationRow.dart';

class DashBoard extends StatefulWidget {
  var listing;
  DashBoard({Key? key, this.listing}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(
                    title: 'Applications',
                  ),
                ]),
            ApplicationDisplay(listing: widget.listing),
          ],
        )));
  }
}
