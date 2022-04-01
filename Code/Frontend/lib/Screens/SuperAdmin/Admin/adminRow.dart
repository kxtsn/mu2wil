// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, must_be_immutable
import 'dart:ui';

import 'package:my_app/Fields/header.dart';
import 'package:my_app/util/color.dart';
import 'package:my_app/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'getAdmin.dart';
import 'adminTableSource.dart';
import 'package:my_app/Fields/search.dart';

class AdminRow extends StatefulWidget {
  bool isLoaded = false;
  AdminRow({Key? key}) : super(key: key);

  @override
  _AdminRowState createState() => _AdminRowState();

  static sort(
      String Function(AdminList d) param0, int columnIndex, bool ascending) {}
}

class _AdminRowState extends State<AdminRow> {
  AdminTableSource _adminTableSource = AdminTableSource([]);
  bool isLoaded = false;
  final int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int? _sortColumnIndex;
  bool _sortAscending = true;

  String query = "";
  late List<AdminList> client;
  int totalRow = 0;

  String role = "";

  double changingWidth = 0;

  //getdata
  Future<void> getData() async {
    final results = await fetchAdminList(http.Client());
    if (!isLoaded) {
      setState(() {
        _adminTableSource = AdminTableSource(results);
        isLoaded = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getData();
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'First Name, Last Name',
        onChanged: search,
      );

  Future<void> search(String query) async {
    final results = await fetchAdminList(http.Client());
    final admin = results.where((adminDetail) {
      final firstNameLower = adminDetail.firstName.toString().toLowerCase();
      final lowerNameLower = adminDetail.lastName.toString().toLowerCase();
      final searchLower = query.toLowerCase();

      return firstNameLower.contains(searchLower) ||
          lowerNameLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      _adminTableSource = AdminTableSource(admin);
      isLoaded = true;
    });
  }

  double setChangingWidth() {
    if (ResponsiveWidget.isSmallScreen(context)) {
      return changingWidth = 40;
    } else {
      return 20;
    }
  }

  @override
  Widget build(BuildContext context) {
    setChangingWidth();
    _adminTableSource.getContext(context);
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
          color: kBackGroundColor,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                  child: PaginatedDataTable(
                    showCheckboxColumn: true,
                    sortColumnIndex: _sortColumnIndex,
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
                        'First Name',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      )),
                      const DataColumn(
                          label: Text(
                        'Last Name',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      )),
                      const DataColumn(
                          label: Text(
                        'Email',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      )),
                    ],
                    source: _adminTableSource,
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
