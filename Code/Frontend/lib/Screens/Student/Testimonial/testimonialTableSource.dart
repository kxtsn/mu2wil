// ignore_for_file: file_names

import 'dart:convert';
import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:my_app/Fields/popUp.dart';
import 'package:my_app/Screens/Student/Testimonial/view.dart';
import 'package:my_app/Util/color.dart';
import 'getWrittenTestimonial.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class TestimonialTableSource extends DataTableSource {
  final List<StdTestimonialList> testimonialLists;
  TestimonialTableSource(this.testimonialLists);

  List<StdTestimonialList> selectedList = [];
  late BuildContext _context;

  void getContext(BuildContext context) {
    _context = context;
  }

  List<StdTestimonialList>? getSelected() {
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

  void _sort<T>(Comparable<T> getField(StdTestimonialList d), bool ascending) {
    testimonialLists.sort((StdTestimonialList a, StdTestimonialList b) {
      if (!ascending) {
        final StdTestimonialList c = a;
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

  Widget getEdit(StdTestimonialList testimonial) {
    if (testimonial.status == "Pending") {
      return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            child: const Icon(Icons.edit, color: primaryColor),
            onTap: () {},
          ));
    } else {
      return const Text("");
    }
  }

  Widget getDelete(StdTestimonialList testimonial) {
    if (testimonial.status == "Pending" || testimonial.status == "Approved") {
      return MouseRegion(
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
                        title: 'Delete Testimonial',
                        subTitle:
                            'Testimonial will be deleted upon confirmation.',
                        onPressed: () async {
                          await commitDelete(
                              testimonial.testimonialId.toString());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ViewTestimonial();
                              },
                            ),
                          );
                        },
                      ));
            },
          ));
    } else {
      return const Text("");
    }
  }

  static Future<ui.Image> bytesToImage(Uint8List imgBytes) async {
    ui.Codec codec = await ui.instantiateImageCodec(imgBytes);
    ui.FrameInfo frame = await codec.getNextFrame();
    return frame.image;
  }

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= testimonialLists.length) return null;
    final StdTestimonialList testimonialList = testimonialLists[index];
    List<int> pictureData = testimonialList.image.cast<int>();
    Uint8List pictureBytes = Uint8List.fromList(pictureData);
    String pictureBase64 = String.fromCharCodes(pictureBytes);

    var image = base64Decode(pictureBase64);
    return DataRow.byIndex(index: index, cells: [
      DataCell(getEdit(testimonialList)),
      DataCell(getDelete(testimonialList)),
      DataCell(Text((testimonialList.companyName).toString())),
      DataCell(Text(formatDisplayDate((testimonialList.createdOn).toString()))),
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
    for (StdTestimonialList result in testimonialLists) {
      result.selected = checked!;
    }
    _selectedCount = checked! ? testimonialLists.length : 0;
    notifyListeners();
  }
}
