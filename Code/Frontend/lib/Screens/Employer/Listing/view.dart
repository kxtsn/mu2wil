import 'package:flutter/material.dart';
import 'package:my_app/Screens/Employer/Listing/body.dart';

class ViewListing extends StatelessWidget {
  var listing;
  ViewListing({Key? key, this.listing}) : super(key: key);

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
