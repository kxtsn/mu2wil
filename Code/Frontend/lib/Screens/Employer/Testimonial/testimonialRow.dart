// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, must_be_immutable
import 'dart:ui';

import 'package:my_app/main.dart';
import 'package:my_app/util/color.dart';
import 'package:my_app/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'getWrittenTestimonial.dart';
import 'testimonialTableSource.dart';
import 'package:my_app/Fields/search.dart';

class TestimonialRow extends StatefulWidget {
  bool isLoaded = false;
  TestimonialRow({Key? key}) : super(key: key);

  @override
  _TestimonialRowState createState() => _TestimonialRowState();

  static sort(String Function(TestimonialRow d) param0, int columnIndex,
      bool ascending) {}
}

class _TestimonialRowState extends State<TestimonialRow> {
  TestimonialTableSource _testimonialTableSource = TestimonialTableSource([]);
  bool isLoaded = false;
  int? _sortColumnIndex;
  bool _sortAscending = true;

  String query = "";
  List<EmpTestimonialList> testimonial = [];
  int totalRow = 0;
  String role = "";

  //getdata
  Future<void> getData() async {
    role = await localstorage.getRole();
    final results = await fetchEmpTestimonialList(http.Client());
    if (!isLoaded) {
      setState(() {
        _testimonialTableSource = TestimonialTableSource(results);

        isLoaded = true;
      });
    }
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Student Name, Comment',
        onChanged: searchPurchase,
      );

  Future<void> searchPurchase(String query) async {
    final results = await fetchEmpTestimonialList(http.Client());
    final testimonial = results.where((testimonialDetails) {
      final firstNameLower = testimonialDetails.firstName.toLowerCase();
      final lastNameLower = testimonialDetails.lastName.toLowerCase();
      final commentLower = testimonialDetails.comment.toLowerCase();
      final searchLower = query.toLowerCase();

      return firstNameLower.contains(searchLower) ||
          lastNameLower.contains(searchLower) ||
          commentLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      _testimonialTableSource = TestimonialTableSource(testimonial);
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
    _testimonialTableSource.getContext(context);
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
                    showCheckboxColumn: false,
                    sortColumnIndex: _sortColumnIndex,
                    sortAscending: _sortAscending,
                    onRowsPerPageChanged: (perPage) {},
                    rowsPerPage: 10,
                    columns: <DataColumn>[
                      // const DataColumn(
                      //     label: Icon(
                      //   Icons.edit,
                      //   color: primaryColor,
                      // )),
                      const DataColumn(
                          label: Icon(
                        Icons.delete,
                        color: primaryColor,
                      )),
                      const DataColumn(
                          label: Text(
                        'Company Name',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      )),
                      const DataColumn(
                          label: Text(
                        'Created On',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      )),
                      const DataColumn(
                          label: Text(
                        'Comment',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      )),
                      const DataColumn(
                          label: Text(
                        'Image',
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
                    source: _testimonialTableSource,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
