// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, must_be_immutable
import 'dart:ui';

import 'package:my_app/Fields/header.dart';
import 'package:my_app/Fields/popUp.dart';
import 'package:my_app/Fields/roundedButton.dart';
import 'package:my_app/Screens/PortalManager/Company/view.dart' as PM;
import 'package:my_app/Screens/SuperAdmin/Company/view.dart' as SA;
import 'package:my_app/main.dart';
import 'package:my_app/util/color.dart';
import 'package:my_app/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'getCompany.dart';
import 'companyTableSource.dart';
import 'package:my_app/Fields/search.dart';

class CompanyRow extends StatefulWidget {
  bool isLoaded = false;
  CompanyRow({Key? key}) : super(key: key);

  @override
  _CompanyRowState createState() => _CompanyRowState();

  static sort(
      String Function(CompanyList d) param0, int columnIndex, bool ascending) {}
}

class _CompanyRowState extends State<CompanyRow> {
  CompanyTableSource _companyTableSource = CompanyTableSource([]);
  bool isLoaded = false;
  int? _sortColumnIndex;
  bool _sortAscending = true;

  String query = "";
  List<CompanyList> companies = [];
  int totalRow = 0;
  String role = "";

  // void _sort<T>(
  //     Comparable<T> getField(CompanyList d), int columnIndex, bool ascending) {
  //   _companyTableSource.sort<T>(getField, ascending);
  //   setState(() {
  //     _sortColumnIndex = columnIndex;
  //     _sortAscending = ascending;
  //   });
  // }

  //getdata
  Future<void> getData() async {
    role = await localstorage.getRole();
    final results = await fetchCompanyList(http.Client());
    if (!isLoaded) {
      setState(() {
        _companyTableSource = CompanyTableSource(results);

        isLoaded = true;
      });
    }
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Company Code, Company Name, First Name, Last Name',
        onChanged: searchPurchase,
      );

  Future<void> searchPurchase(String query) async {
    final results = await fetchCompanyList(http.Client());
    final company = results.where((companyDetails) {
      final companyCodeLower = companyDetails.companyCode.toLowerCase();
      final companyNameLower = companyDetails.companyName.toLowerCase();
      final firstNameLower = companyDetails.firstName.toLowerCase();
      final lastNameLower = companyDetails.lastName.toLowerCase();
      final searchLower = query.toLowerCase();

      return companyCodeLower.contains(searchLower) ||
          companyNameLower.contains(searchLower) ||
          firstNameLower.contains(searchLower) ||
          lastNameLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      _companyTableSource = CompanyTableSource(company);
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
    _companyTableSource.getContext(context);
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
                    onSelectAll: _companyTableSource.selectAll,
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
                        'Company Code',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      )),
                      const DataColumn(
                          label: Text(
                        'Contact Person',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      )),
                      const DataColumn(
                          label: Text(
                        'Email',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      )),
                      const DataColumn(
                          label: Text(
                        'Contact Number',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      )),
                      const DataColumn(
                          label: Text(
                        'Telephone',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      )),
                      const DataColumn(
                          label: Text(
                        'Website',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      )),
                      const DataColumn(
                          label: Text(
                        'Country',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      )),
                      const DataColumn(
                          label: Text(
                        'Address',
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
                    source: _companyTableSource,
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
                    List<CompanyList>? selectedList =
                        _companyTableSource.getSelected();
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
                                  title: 'Approve Company',
                                  subTitle:
                                      'Selected companies will be accepted.',
                                  onPressed: () async {
                                for (CompanyList c in selectedList!) {
                                  await commitApprove(c.companyId.toString());
                                  if (role == "1") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return SA.ViewCompany();
                                        },
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return PM.ViewCompany();
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
                    List<CompanyList>? selectedList =
                        _companyTableSource.getSelected();
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
                                  title: 'Reject Company',
                                  subTitle:
                                      'Selected companies will be rejected.',
                                  onPressed: () async {
                                for (CompanyList c in selectedList!) {
                                  await commitReject(c.companyId.toString());
                                  if (role == "1") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return SA.ViewCompany();
                                        },
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return PM.ViewCompany();
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
