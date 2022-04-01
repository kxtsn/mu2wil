// ignore_for_file: file_names

import 'package:my_app/Fields/popUp.dart';
import 'package:my_app/Screens/PortalManager/Student/view.dart';
import 'package:my_app/util/color.dart';
import 'getCompany.dart';
import 'package:flutter/material.dart';

class CompanyTableSource extends DataTableSource {
  final List<CompanyList> companyLists;
  CompanyTableSource(this.companyLists);

  List<CompanyList> selectedList = [];
  late BuildContext _context;

  void getContext(BuildContext context) {
    _context = context;
  }

  List<CompanyList>? getSelected() {
    if (selectedList.isNotEmpty) {
      return selectedList;
    }
    return null;
  }

  void _sort<T>(Comparable<T> getField(CompanyList d), bool ascending) {
    companyLists.sort((CompanyList a, CompanyList b) {
      if (!ascending) {
        final CompanyList c = a;
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
    if (index >= companyLists.length) return null;
    final CompanyList companyList = companyLists[index];
    return DataRow.byIndex(
        index: index,
        selected: companyList.selected,
        onSelectChanged: (selected) {
          companyList.selected = selected!;
          if (selected == true) {
            _selectedCount++;
            selectedList.add(companyList);
          } else if (selected == false) {
            _selectedCount = _selectedCount - 1;
            selectedList.remove(companyList);
          }
          notifyListeners();
        },
        cells: [
          DataCell(Text((companyList.companyName).toString())),
          DataCell(Text((companyList.companyCode).toString())),
          DataCell(Text(
              (companyList.firstName + " " + companyList.lastName).toString())),
          DataCell(Text((companyList.email).toString())),
          DataCell(Text((companyList.contactNo).toString())),
          DataCell(Text((companyList.tel).toString())),
          DataCell(Text((companyList.website).toString())),
          DataCell(Text((companyList.country).toString())),
          DataCell(Text((companyList.address1 +
                  " " +
                  companyList.address2 +
                  " (" +
                  companyList.postal +
                  ")")
              .toString())),
          DataCell(Text((companyList.status).toString())),
        ]);
  }

  @override
  int get rowCount => companyLists.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void selectAll(bool? checked) {
    for (CompanyList result in companyLists) {
      result.selected = checked!;
    }
    _selectedCount = checked! ? companyLists.length : 0;
    notifyListeners();
  }
}
