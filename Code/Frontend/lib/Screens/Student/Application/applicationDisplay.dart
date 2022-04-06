// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, must_be_immutable
import 'dart:ui';

import 'package:my_app/Fields/stdApplicationCard.dart';
import 'package:my_app/Fields/popUp.dart';
import 'package:my_app/Fields/roundedButton.dart';
import 'package:my_app/Screens/Student/Application/getApplication.dart';
import 'package:my_app/main.dart';
import 'package:my_app/util/color.dart';
import 'package:my_app/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

// import 'getListing.dart';
// import 'listingTableSource.dart';
import 'package:my_app/Fields/search.dart';

class ApplicationDisplay extends StatefulWidget {
  bool isLoaded = false;
  ApplicationDisplay({Key? key}) : super(key: key);

  @override
  _ApplicationDisplayState createState() => _ApplicationDisplayState();

  static sort(String Function(ApplicationDisplay d) param0, int columnIndex,
      bool ascending) {}
}

class _ApplicationDisplayState extends State<ApplicationDisplay> {
  //ListingTableSource _listingTableSource = ListingTableSource([]);
  bool isLoaded = false;
  int? _sortColumnIndex;
  bool _sortAscending = true;

  String query = "";
  List<ApplicationList> applicantLists = [];
  int totalRow = 0;
  String role = "";

  Future<void> getData() async {
    final results = await fetchApplicationDetails(http.Client());
    if (!isLoaded) {
      setState(() {
        applicantLists = results;
        isLoaded = true;
      });
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
