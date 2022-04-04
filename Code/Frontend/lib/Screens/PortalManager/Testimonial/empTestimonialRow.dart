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

import 'getEmpTestimonial.dart';
import 'empTestimonialTableSource.dart';
import 'package:my_app/Fields/search.dart';

class EmpTestimonialRow extends StatefulWidget {
  bool isLoaded = false;
  EmpTestimonialRow({Key? key}) : super(key: key);

  @override
  _EmpTestimonialRowState createState() => _EmpTestimonialRowState();

  static sort(String Function(EmpTestimonialRow d) param0, int columnIndex,
      bool ascending) {}
}

class _EmpTestimonialRowState extends State<EmpTestimonialRow> {
  EmpTestimonialTableSource _empTestimonialTableSource =
      EmpTestimonialTableSource([]);
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
        _empTestimonialTableSource = EmpTestimonialTableSource(results);

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
    final results = await fetchEmpTestimonialList(http.Client());
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
      _empTestimonialTableSource = EmpTestimonialTableSource(testimonial);
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
    _empTestimonialTableSource.getContext(context);
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
                    onSelectAll: _empTestimonialTableSource.selectAll,
                    onRowsPerPageChanged: (perPage) {},
                    rowsPerPage: 10,
                    columns: <DataColumn>[
                      const DataColumn(
                          label: Text(
                        'Company Name',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      )),
                      const DataColumn(
                          label: Text(
                        'Student',
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
                    source: _empTestimonialTableSource,
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
                    List<EmpTestimonialList>? selectedList =
                        _empTestimonialTableSource.getSelected();
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
                                  title: 'Approve Employer Testimonials',
                                  subTitle:
                                      'Selected testimonials will be accepted.',
                                  onPressed: () async {
                                for (EmpTestimonialList empTest
                                    in selectedList!) {
                                  await commitApproveEmp(
                                      empTest.testimonialId.toString());
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
                    List<EmpTestimonialList>? selectedList =
                        _empTestimonialTableSource.getSelected();
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
                                  title: 'Reject Employer Testimonial',
                                  subTitle:
                                      'Selected testimonials will be rejected.',
                                  onPressed: () async {
                                for (EmpTestimonialList empTest
                                    in selectedList!) {
                                  await commitRejectEmp(
                                      empTest.testimonialId.toString());
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
