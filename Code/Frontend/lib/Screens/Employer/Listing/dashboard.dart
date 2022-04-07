// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:my_app/Fields/header.dart';
import 'package:my_app/Screens/Employer/Listing/createListing.dart';

import 'ListingRow.dart';

class DashBoard extends StatefulWidget {
  var listing;
  DashBoard({Key? key, this.listing}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  String title = 'New Listings';

  @override
  Widget build(BuildContext context) {
    if (widget.listing != null) {
      title = 'Edit Listing';
    }
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
                    title: 'Listings',
                  ),
                  const Flexible(
                      child: SizedBox(
                    width: 550,
                  )),
                  Header(
                    title: title,
                  ),
                ]),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(flex: 3, child: ListingRow()),
              Expanded(flex: 3, child: AddListing(listing: widget.listing)),
            ]),
          ],
        )));
  }
}
