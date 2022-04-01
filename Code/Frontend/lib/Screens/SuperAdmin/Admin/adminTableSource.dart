// ignore_for_file: file_names

import 'package:my_app/Fields/popUp.dart';
import 'package:my_app/Screens/SuperAdmin/Admin/view.dart';
import 'package:my_app/util/color.dart';
import 'getAdmin.dart';
import 'package:flutter/material.dart';

class AdminTableSource extends DataTableSource {
  final List<AdminList> adminLists;
  AdminTableSource(this.adminLists);

  List<AdminList> selectedList = [];
  late BuildContext _context;

  void getContext(BuildContext context) {
    _context = context;
  }

  List<AdminList>? getSelected() {
    if (selectedList.isNotEmpty) {
      return selectedList;
    }
    return null;
  }

  void _sort<T>(Comparable<T> getField(AdminList d), bool ascending) {
    adminLists.sort((AdminList a, AdminList b) {
      if (!ascending) {
        final AdminList c = a;
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
    if (index >= adminLists.length) return null;
    final AdminList adminList = adminLists[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            child: const Icon(Icons.edit, color: primaryColor),
            onTap: () {
              Navigator.push(
                _context,
                MaterialPageRoute(
                  builder: (context) {
                    return ViewAdmin(admin: adminList);
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
                        title: 'Delete Admin',
                        subTitle:
                            'Admin will be deleted upon confirmation. The account will no longer be accessible.',
                        onPressed: () async {
                          await commitDeleteAdmin(adminList.adminId.toString());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ViewAdmin();
                              },
                            ),
                          );
                        },
                      ));
            },
          ))),
      DataCell(Text((adminList.firstName).toString())),
      DataCell(Text((adminList.lastName).toString())),
      DataCell(Text((adminList.email).toString()))
    ]);
  }

  @override
  int get rowCount => adminLists.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void _selectAll(bool checked) {
    for (AdminList result in adminLists) {
      result.selected = checked;
    }
    _selectedCount = checked ? adminLists.length : 0;
    notifyListeners();
  }
}
