// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, must_be_immutable
import 'dart:ui';

import 'package:my_app/Fields/popUp.dart';
import 'package:my_app/Fields/roundedButton.dart';
import 'package:my_app/Screens/PortalManager/Testimonial/view.dart' as PM;
import 'package:my_app/Screens/SuperAdmin/Testimonial/view.dart' as SA;
import 'package:my_app/main.dart';
import 'package:my_app/util/color.dart';
import 'package:my_app/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'getStdTestimonial.dart';
import 'stdTestimonialTableSource.dart';
import 'package:my_app/Fields/search.dart';

class StdTestimonialRow extends StatefulWidget {
  bool isLoaded = false;
  StdTestimonialRow({Key? key}) : super(key: key);

  @override
  _StdTestimonialRowState createState() => _StdTestimonialRowState();

  static sort(String Function(StdTestimonialRow d) param0, int columnIndex,
      bool ascending) {}
}

class _StdTestimonialRowState extends State<StdTestimonialRow> {
  StdTestimonialTableSource _stdTestimonialTableSource =
      StdTestimonialTableSource([]);
  bool isLoaded = false;
  int? _sortColumnIndex;
  bool _sortAscending = true;

  String query = "";
  List<StdTestimonialList> testimonial = [];
  int totalRow = 0;
  String role = "";

  //getdata
  Future<void> getData() async {
    role = await localstorage.getRole();
    final results = await fetchStdTestimonialList(http.Client());
    if (!isLoaded) {
      setState(() {
        _stdTestimonialTableSource = StdTestimonialTableSource(results);

        isLoaded = true;
      });
    }
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Company Name, Student Name, Comment, Status',
        onChanged: searchPurchase,
      );

  Future<void> searchPurchase(String query) async {
    final results = await fetchStdTestimonialList(http.Client());
    final testimonial = results.where((testimonialDetails) {
      final companyNameLower = testimonialDetails.companyName.toLowerCase();
      final firstNameLower = testimonialDetails.firstName.toLowerCase();
      final lastNameLower = testimonialDetails.lastName.toLowerCase();
      final commentLower = testimonialDetails.comment.toLowerCase();
      final statusLower = testimonialDetails.status.toLowerCase();
      final searchLower = query.toLowerCase();

      return companyNameLower.contains(searchLower) ||
          firstNameLower.contains(searchLower) ||
          lastNameLower.contains(searchLower) ||
          commentLower.contains(searchLower) ||
          statusLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      _stdTestimonialTableSource = StdTestimonialTableSource(testimonial);
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
    _stdTestimonialTableSource.getContext(context);
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
                    onSelectAll: _stdTestimonialTableSource.selectAll,
                    onRowsPerPageChanged: (perPage) {},
                    rowsPerPage: 10,
                    columns: <DataColumn>[
                      const DataColumn(
                          label: Text(
                        'Student',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
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
                    source: _stdTestimonialTableSource,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              RoundedButton(
                  text: "APPROVE",
                  widthSize: changingWidth,
                  press: () {
                    List<StdTestimonialList>? selectedList =
                        _stdTestimonialTableSource.getSelected();
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
                                  title: 'Approve Student Testimonials',
                                  subTitle:
                                      'Selected testimonials will be accepted.',
                                  onPressed: () async {
                                for (StdTestimonialList stdTest
                                    in selectedList!) {
                                  await commitApproveStd(
                                      stdTest.testimonialId.toString());
                                  if (role == "1") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return SA.ViewTestimonial();
                                        },
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return PM.ViewTestimonial();
                                        },
                                      ),
                                    );
                                  }
                                }
                              }));
                    }
                  }),
              const SizedBox(width: 20),
              RoundedButton(
                  text: "REJECT",
                  widthSize: changingWidth,
                  press: () {
                    List<StdTestimonialList>? selectedList =
                        _stdTestimonialTableSource.getSelected();
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
                                  title: 'Reject Student Testimonial',
                                  subTitle:
                                      'Selected testimonials will be rejected.',
                                  onPressed: () async {
                                for (StdTestimonialList stdTest
                                    in selectedList!) {
                                  await commitRejectStd(
                                      stdTest.testimonialId.toString());
                                  if (role == "1") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return SA.ViewTestimonial();
                                        },
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return PM.ViewTestimonial();
                                        },
                                      ),
                                    );
                                  }
                                }
                              }));
                    }
                  }),
            ]),
          ],
        ),
      ),
    );
  }
}
