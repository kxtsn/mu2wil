// ignore_for_file: file_names

import 'package:my_app/Fields/popUp.dart';
import 'package:my_app/Screens/SuperAdmin/Admin/view.dart';
import 'package:my_app/Screens/SuperAdmin/PortalManager/view.dart';
import 'package:my_app/util/color.dart';
import 'getManager.dart';
import 'package:flutter/material.dart';

class ManagerTableSource extends DataTableSource {
  final List<ManagerList> managerLists;
  ManagerTableSource(this.managerLists);

  List<ManagerList> selectedList = [];
  late BuildContext _context;

  void getContext(BuildContext context) {
    _context = context;
  }

  List<ManagerList>? getSelected() {
    if (selectedList.isNotEmpty) {
      return selectedList;
    }
    return null;
  }

  void _sort<T>(Comparable<T> getField(ManagerList d), bool ascending) {
    managerLists.sort((ManagerList a, ManagerList b) {
      if (!ascending) {
        final ManagerList c = a;
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
    if (index >= managerLists.length) return null;
    final ManagerList managerList = managerLists[index];
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
                    return ViewManager(manager: managerList);
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
                        title: 'Delete Portal Manager',
                        subTitle:
                            'Manager will be deleted upon confirmation. The account will no longer be accessible.',
                        onPressed: () async {
                          await commitDeleteManager(
                              managerList.managerId.toString());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ViewManager();
                              },
                            ),
                          );
                        },
                      ));
            },
          ))),
      DataCell(Text((managerList.firstName).toString())),
      DataCell(Text((managerList.lastName).toString())),
      DataCell(Text((managerList.email).toString()))
    ]);
  }

  @override
  int get rowCount => managerLists.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void _selectAll(bool checked) {
    for (ManagerList result in managerLists) {
      result.selected = checked;
    }
    _selectedCount = checked ? managerLists.length : 0;
    notifyListeners();
  }
}
