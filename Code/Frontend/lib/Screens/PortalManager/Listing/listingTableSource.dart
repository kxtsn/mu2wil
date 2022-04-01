// ignore_for_file: file_names

import 'package:intl/intl.dart';
import 'package:my_app/Fields/popUp.dart';
import 'package:my_app/Screens/PortalManager/Student/view.dart';
import 'package:my_app/util/color.dart';
import 'getListing.dart';
import 'package:flutter/material.dart';

class ListingTableSource extends DataTableSource {
  final List<ListingList> listingLists;
  ListingTableSource(this.listingLists);

  List<ListingList> selectedList = [];
  late BuildContext _context;

  void getContext(BuildContext context) {
    _context = context;
  }

  List<ListingList>? getSelected() {
    if (selectedList.isNotEmpty) {
      return selectedList;
    }
    return null;
  }

  String formatDisplayDate(String date) {
    if (date != "") {
      date = DateFormat("dd MMM yyyy").format(DateTime.parse(date)).toString();
    } else {
      date = "";
    }
    return date;
  }

  void _sort<T>(Comparable<T> getField(ListingList d), bool ascending) {
    listingLists.sort((ListingList a, ListingList b) {
      if (!ascending) {
        final ListingList c = a;
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
    if (index >= listingLists.length) return null;
    final ListingList listingList = listingLists[index];
    return DataRow.byIndex(
        index: index,
        selected: listingList.selected,
        onSelectChanged: (selected) {
          listingList.selected = selected!;
          if (selected == true) {
            _selectedCount++;
            selectedList.add(listingList);
          } else if (selected == false) {
            _selectedCount = _selectedCount - 1;
            selectedList.remove(listingList);
          }
          notifyListeners();
        },
        cells: [
          DataCell(Text((listingList.companyName).toString())),
          DataCell(Text((listingList.title).toString())),
          DataCell(Text((listingList.description).toString())),
          DataCell(Text((listingList.slot).toString())),
          DataCell(
              Text((formatDisplayDate(listingList.closingDate)).toString())),
          DataCell(Text((listingList.status).toString())),
        ]);
  }

  @override
  int get rowCount => listingLists.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void selectAll(bool? checked) {
    for (ListingList result in listingLists) {
      result.selected = checked!;
    }
    _selectedCount = checked! ? listingLists.length : 0;
    notifyListeners();
  }
}
