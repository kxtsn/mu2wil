// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, must_be_immutable
import 'dart:ui';

import 'package:my_app/Fields/popUp.dart';
import 'package:my_app/Fields/roundedButton.dart';
import 'package:my_app/Screens/Employer/Listing/view.dart';
import 'package:my_app/main.dart';
import 'package:my_app/util/color.dart';
import 'package:my_app/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'getListing.dart';
import 'listingTableSource.dart';
import 'package:my_app/Fields/search.dart';

class ListingRow extends StatefulWidget {
  bool isLoaded = false;
  ListingRow({Key? key}) : super(key: key);

  @override
  _ListingRowState createState() => _ListingRowState();

  static sort(
      String Function(ListingRow d) param0, int columnIndex, bool ascending) {}
}

class _ListingRowState extends State<ListingRow> {
  ListingTableSource _listingTableSource = ListingTableSource([]);
  bool isLoaded = false;
  int? _sortColumnIndex;
  final bool _sortAscending = true;

  String query = "";
  List<ListingList> listings = [];
  int totalRow = 0;
  String role = "";

  //getdata
  Future<void> getData() async {
    role = await localstorage.getRole();
    final results = await fetchListingList(http.Client());
    if (!isLoaded) {
      setState(() {
        _listingTableSource = ListingTableSource(results);

        isLoaded = true;
      });
    }
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title, Description',
        onChanged: searchListing,
      );

  Future<void> searchListing(String query) async {
    final results = await fetchListingList(http.Client());
    final listing = results.where((listingDetails) {
      final titleLower = listingDetails.title.toLowerCase();
      final descLower = listingDetails.description.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          descLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      _listingTableSource = ListingTableSource(listing);
      isLoaded = true;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double changingWidth = 200;
    if (ResponsiveWidget.isSmallScreen(context)) {
      changingWidth = 100;
    }
    _listingTableSource.getContext(context);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          color: kBackGroundColor,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSearch(),
            SizedBox(
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.mouse,
                    PointerDeviceKind.touch,
                  },
                ),
                child: SingleChildScrollView(
                  //scrollDirection: Axis.horizontal,
                  child: PaginatedDataTable(
                    showCheckboxColumn: true,
                    sortColumnIndex: _sortColumnIndex,
                    sortAscending: _sortAscending,
                    onSelectAll: _listingTableSource.selectAll,
                    onRowsPerPageChanged: (perPage) {},
                    rowsPerPage: 10,
                    columns: <DataColumn>[
                      const DataColumn(
                          label: Icon(
                        Icons.edit,
                        color: primaryColor,
                      )),
                      const DataColumn(
                          label: Icon(
                        Icons.delete,
                        color: primaryColor,
                      )),
                      const DataColumn(
                          label: Text(
                        'Title',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      )),
                      const DataColumn(
                          label: Text(
                        'Description',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      )),
                      const DataColumn(
                          label: Text(
                        'Slot',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      )),
                      const DataColumn(
                          label: Text(
                        'Closing Date',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      )),
                      const DataColumn(
                          label: Text(
                        'Applicants',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      )),
                      const DataColumn(
                          label: Text(
                        'Status',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      )),
                    ],
                    source: _listingTableSource,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: RoundedButton(
                  text: "CLOSE LISTING",
                  widthSize: changingWidth,
                  press: () {
                    List<ListingList>? selectedList =
                        _listingTableSource.getSelected();
                    if (selectedList == null) {
                      totalRow = 0;
                    } else {
                      totalRow = selectedList.length;
                    }
                    if (totalRow != 0) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => PopUpWidget(
                                  context,
                                  icon: Icons.check_circle,
                                  iconColor: greenColor,
                                  iconSize: 80,
                                  title: 'Close Listings',
                                  subTitle: 'Selected listings will be close.',
                                  onPressed: () async {
                                for (ListingList c in selectedList!) {
                                  await commitClose(c.listingId.toString());

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ViewListing();
                                      },
                                    ),
                                  );
                                }
                              }));
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
