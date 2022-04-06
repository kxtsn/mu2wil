import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/Screens/Student/CompanyTestimonial/getTestimonial.dart';

class TestimonialCardTile extends StatelessWidget {
  TestimonialList testimonial;
  TestimonialCardTile({Key? key, required this.testimonial}) : super(key: key);

  String formatDisplayDate(String date) {
    if (date != "") {
      date = DateFormat("dd MMM yyyy").format(DateTime.parse(date)).toString();
    } else {
      date = "";
    }
    return date;
  }

  @override
  Widget build(BuildContext context) {
    List<int> pictureData = testimonial.image.cast<int>();
    Uint8List pictureBytes = Uint8List.fromList(pictureData);
    String pictureBase64 = String.fromCharCodes(pictureBytes);

    var image = base64Decode(pictureBase64);

    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Stack(children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.memory(image, fit: BoxFit.fitHeight, scale: 2),
                          const SizedBox(height: 10),
                          Text(
                            testimonial.companyName!.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(testimonial.comment!),
                          const SizedBox(height: 10),
                          Text("Written on:" +
                              formatDisplayDate(
                                  testimonial.createdOn!.toString())),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
        ));
  }
}
