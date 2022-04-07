// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:my_app/Screens/Employer/Application/body.dart';

class ViewApplication extends StatelessWidget {
  var listing;
  ViewApplication({Key? key, this.listing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Body(listing: listing),
            ),
          ],
        ),
      ),
    );
  }
}
