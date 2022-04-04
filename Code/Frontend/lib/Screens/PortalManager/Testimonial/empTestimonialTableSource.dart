// ignore_for_file: file_names

import 'dart:convert';
import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'getEmpTestimonial.dart';
import 'package:flutter/material.dart';

class EmpTestimonialTableSource extends DataTableSource {
  final List<EmpTestimonialList> testimonialLists;
  EmpTestimonialTableSource(this.testimonialLists);

  List<EmpTestimonialList> selectedList = [];
  late BuildContext _context;

  void getContext(BuildContext context) {
    _context = context;
  }

  List<EmpTestimonialList>? getSelected() {
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

  void _sort<T>(Comparable<T> getField(EmpTestimonialList d), bool ascending) {
    testimonialLists.sort((EmpTestimonialList a, EmpTestimonialList b) {
      if (!ascending) {
        final EmpTestimonialList c = a;
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
    if (index >= testimonialLists.length) return null;
    final EmpTestimonialList testimonialList = testimonialLists[index];

    List<int> pictureData = testimonialList.image.cast<int>();
    Uint8List pictureBytes = Uint8List.fromList(pictureData);
    String pictureBase64 = String.fromCharCodes(pictureBytes);

    var image = base64Decode(pictureBase64);

    return DataRow.byIndex(
        index: index,
        selected: testimonialList.selected,
        onSelectChanged: (selected) {
          testimonialList.selected = selected!;
          if (selected == true) {
            _selectedCount++;
            selectedList.add(testimonialList);
          } else if (selected == false) {
            _selectedCount = _selectedCount - 1;
            selectedList.remove(testimonialList);
          }
          notifyListeners();
        },
        cells: [
          DataCell(Text((testimonialList.companyName).toString())),
          DataCell(Text((testimonialList.firstName).toString() +
              " " +
              (testimonialList.lastName).toString())),
          DataCell(
              Text(formatDisplayDate((testimonialList.createdOn).toString()))),
          DataCell(Text((testimonialList.comment).toString())),
          DataCell(Image.memory(image, fit: BoxFit.fill)),
          DataCell(Text((testimonialList.status).toString())),
        ]);
  }

  @override
  int get rowCount => testimonialLists.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void selectAll(bool? checked) {
    for (EmpTestimonialList result in testimonialLists) {
      result.selected = checked!;
    }
    _selectedCount = checked! ? testimonialLists.length : 0;
    notifyListeners();
  }
}
