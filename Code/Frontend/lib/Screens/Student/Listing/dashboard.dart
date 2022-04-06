import 'package:flutter/material.dart';
import 'package:my_app/Fields/header.dart';
import 'package:my_app/Screens/Student/Listing/listingDisplay.dart';
import 'package:my_app/Util/color.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key? key}) : super(key: key);

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
                    title: 'Available Listings',
                  ),
                ]),
            ListingDisplay(),
          ],
        )));
  }
}
