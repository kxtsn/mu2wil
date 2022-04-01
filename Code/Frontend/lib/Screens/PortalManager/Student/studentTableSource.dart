// ignore_for_file: file_names

import 'package:my_app/Fields/popUp.dart';
import 'package:my_app/Screens/PortalManager/Student/view.dart';
import 'package:my_app/util/color.dart';
import 'getStudent.dart';
import 'package:flutter/material.dart';

class StudentTableSource extends DataTableSource {
  final List<StudentList> studentLists;
  final bool isVisible;
  StudentTableSource(this.studentLists, this.isVisible);

  List<StudentList> selectedList = [];
  late BuildContext _context;

  void getContext(BuildContext context) {
    _context = context;
  }

  List<StudentList>? getSelected() {
    if (selectedList.isNotEmpty) {
      return selectedList;
    }
    return null;
  }

  void _sort<T>(Comparable<T> getField(StudentList d), bool ascending) {
    studentLists.sort((StudentList a, StudentList b) {
      if (!ascending) {
        final StudentList c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= studentLists.length) return null;
    final StudentList studentList = studentLists[index];
    return DataRow.byIndex(
        index: index,
        selected: studentList.selected,
        onSelectChanged: (selected) {
          studentList.selected = selected!;
          if (selected == true) {
            _selectedCount++;
            selectedList.add(studentList);
          } else if (selected == false) {
            _selectedCount = _selectedCount - 1;
            selectedList.remove(studentList);
          }
          notifyListeners();
        },
        cells: [
          DataCell(MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                child: const Icon(Icons.edit, color: primaryColor),
                onTap: () {
                  Navigator.push(
                    _context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ViewStudent(student: studentList);
                      },
                    ),
                  );
                },
              ))),
          DataCell(MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                child: const Icon(Icons.delete, color: primaryColor),
                onTap: () {
                  showDialog(
                      context: _context,
                      builder: (BuildContext context) => PopUpWidget(
                            context,
                            icon: Icons.delete_forever,
                            iconColor: redColor,
                            iconSize: 80,
                            title: 'Delete Student',
                            subTitle:
                                'Student will be deleted upon confirmation. The account will no longer be accessible.',
                            onPressed: () async {
                              await commitDeleteStudent(
                                  studentList.studentId.toString());
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ViewStudent();
                                  },
                                ),
                              );
                            },
                          ));
                },
              ))),
          DataCell(Text((studentList.murdochId).toString())),
          DataCell(Text((studentList.firstName).toString())),
          DataCell(Text((studentList.lastName).toString())),
          DataCell(Text((studentList.email).toString())),
          DataCell(Visibility(
            child: Text((studentList.status).toString()),
            visible: isVisible,
          )),
        ]);
  }

  @override
  int get rowCount => studentLists.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void _selectAll(bool checked) {
    for (StudentList result in studentLists) {
      result.selected = checked;
    }
    _selectedCount = checked ? studentLists.length : 0;
    notifyListeners();
  }
}
