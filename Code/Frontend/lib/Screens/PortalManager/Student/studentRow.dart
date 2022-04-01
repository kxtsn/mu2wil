// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, must_be_immutable
import 'dart:ui';

import 'package:my_app/Fields/popUp.dart';
import 'package:my_app/Fields/roundedButton.dart';
import 'package:my_app/Screens/PortalManager/Student/view.dart' as PM;
import 'package:my_app/Screens/SuperAdmin/Student/view.dart' as SA;
import 'package:my_app/main.dart';
import 'package:my_app/util/color.dart';
import 'package:my_app/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'getStudent.dart';
import 'studentTableSource.dart';
import 'package:my_app/Fields/search.dart';

class StudentRow extends StatefulWidget {
  bool isLoaded = false;
  StudentRow({Key? key}) : super(key: key);

  @override
  _StudentRowState createState() => _StudentRowState();

  static sort(
      String Function(StudentList d) param0, int columnIndex, bool ascending) {}
}

class _StudentRowState extends State<StudentRow> {
  StudentTableSource _studentTableSource = StudentTableSource([], false);
  bool isLoaded = false;
  final int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int? _sortColumnIndex;
  bool _sortAscending = true;

  String query = "";
  late List<StudentList> client;
  int totalRow = 0;

  late String role;

  double changingWidth = 0;

  bool _isVisible = false;

  //getdata
  Future<void> getData() async {
    role = await localstorage.getRole();
    if (role == "1") {
      _isVisible = true;
      final results = await fetchSAStudentList(http.Client());
      if (!isLoaded) {
        setState(() {
          _studentTableSource = StudentTableSource(results, _isVisible);
          isLoaded = true;
        });
      }
    } else {
      final results = await fetchStudentList(http.Client());
      if (!isLoaded) {
        setState(() {
          _studentTableSource = StudentTableSource(results, _isVisible);
          isLoaded = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Widget Graduatebutton() {
    return RoundedButton(
        text: "Graduate",
        widthSize: 200,
        press: () {
          List<StudentList>? selectedList = _studentTableSource.getSelected();
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
                      icon: Icons.school,
                      iconColor: greenColor,
                      iconSize: 80,
                      title: 'Students Graduated',
                      subTitle:
                          'Selected Students will be updated as graduated.',
                      onPressed: () async {
                        for (StudentList student in selectedList!) {
                          await commitGraduatedStudent(
                              student.studentId.toString());
                        }
                        if (role == "1") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SA.ViewStudent();
                              },
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PM.ViewStudent();
                              },
                            ),
                          );
                        }
                      },
                    ));
          }
        });
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'First Name, Last Name, Murdoch Student ID',
        onChanged: search,
      );

  Future<void> search(String query) async {
    var results;
    if (role == "1") {
      results = await fetchSAStudentList(http.Client());
    } else {
      results = await fetchStudentList(http.Client());
    }
    final student = results.where((studentDetail) {
      final firstNameLower = studentDetail.firstName.toString().toLowerCase();
      final lowerNameLower = studentDetail.lastName.toString().toLowerCase();
      final murdochIdLower = studentDetail.murdochId.toString().toLowerCase();
      final searchLower = query.toLowerCase();

      return firstNameLower.contains(searchLower) ||
          lowerNameLower.contains(searchLower) ||
          murdochIdLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      _studentTableSource = StudentTableSource(student, _isVisible);
      isLoaded = true;
    });
  }

  double setChangingWidth() {
    if (ResponsiveWidget.isSmallScreen(context)) {
      return changingWidth = 40;
    } else {
      return 200;
    }
  }

  @override
  Widget build(BuildContext context) {
    setChangingWidth();
    _studentTableSource.getContext(context);
    return Container(
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
            color: kBackGroundColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                        'Murdoch Student ID',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
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
                      DataColumn(
                        label: Visibility(
                            child: const Text(
                              'Status',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            visible: _isVisible),
                      ),
                    ],
                    source: _studentTableSource,
                  ),
                ),
              ),
            ),
            Center(child: Graduatebutton()),
          ],
        )));
  }
}
