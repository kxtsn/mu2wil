// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, must_be_immutable
import 'dart:ui';

import 'package:my_app/Fields/listingCard.dart';
import 'package:my_app/Fields/popUp.dart';
import 'package:my_app/Fields/roundedButton.dart';
import 'package:my_app/Screens/Student/Listing/getListing.dart';
import 'package:my_app/main.dart';
import 'package:my_app/util/color.dart';
import 'package:my_app/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:my_app/Fields/search.dart';

class ListingDisplay extends StatefulWidget {
  bool isLoaded = false;
  ListingDisplay({Key? key}) : super(key: key);

  @override
  _ListingDisplayState createState() => _ListingDisplayState();

  static sort(String Function(ListingDisplay d) param0, int columnIndex,
      bool ascending) {}
}

class _ListingDisplayState extends State<ListingDisplay> {
  bool isLoaded = false;
  int? _sortColumnIndex;
  bool _sortAscending = true;

  String query = "";
  List<ListingList> listingLists = [];
  int totalRow = 0;
  String role = "";
  bool notApplied = true;

  Future<void> getData() async {
    final results = await fetchListingDetails(http.Client());
    if (!isLoaded) {
      setState(() {
        listingLists = results;
        isLoaded = true;
      });
    }
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Job',
        onChanged: search,
      );

  Future<void> search(String query) async {
    final results = await fetchListingDetails(http.Client());
    final listing = results.where((listingDetail) {
      final titleLower = listingDetail.title.toString().toLowerCase();
      final descLower = listingDetail.description.toString().toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          descLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      listingLists = listing;
      isLoaded = true;
    });
  }

  Future<void> getApplicationStatus(String listingId) async {
    final flag = await checkIfApplied(listingId);

    setState(() {
      notApplied = flag;
    });
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
        child: Column(
      children: [
        buildSearch(),
        const SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 400,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: listingLists.length,
              itemBuilder: (context, index) {
                return CardTile(list: listingLists[index]);
              }),
        )
      ],
    ));
  }
}
