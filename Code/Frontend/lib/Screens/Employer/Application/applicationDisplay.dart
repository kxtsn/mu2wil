// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, must_be_immutable, prefer_typing_uninitialized_variables, sized_box_for_whitespace

import 'package:my_app/Fields/applicationCard.dart';
import 'package:my_app/Screens/Employer/Application/getApplication.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

// import 'getListing.dart';
// import 'listingTableSource.dart';

class ApplicationDisplay extends StatefulWidget {
  var listing;
  bool isLoaded = false;
  ApplicationDisplay({Key? key, this.listing}) : super(key: key);

  @override
  _ApplicationDisplayState createState() => _ApplicationDisplayState();

  static sort(String Function(ApplicationDisplay d) param0, int columnIndex,
      bool ascending) {}
}

class _ApplicationDisplayState extends State<ApplicationDisplay> {
  //ListingTableSource _listingTableSource = ListingTableSource([]);
  bool isLoaded = false;

  String query = "";
  List<ApplicationList> applicantLists = [];
  int totalRow = 0;
  String role = "";

  Future<void> getData() async {
    if (widget.listing != null) {
      final results = await fetchApplicationDetailsByListing(
          widget.listing.listingId.toString());
      if (!isLoaded) {
        setState(() {
          applicantLists = results;
          isLoaded = true;
        });
      }
    } else {
      final results = await fetchApplicationDetails(http.Client());
      if (!isLoaded) {
        setState(() {
          applicantLists = results;
          isLoaded = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width / 1.5),
      height: 500,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: applicantLists.length,
          itemBuilder: (context, index) {
            return CardTile(
              applicant: applicantLists[index],
            );
          }),
    );
  }
}
