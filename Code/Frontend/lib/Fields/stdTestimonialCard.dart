import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:my_app/Screens/Student/Testimonial/getStdTestimonial.dart';
import 'package:my_app/Util/color.dart';

//employer write to student
class TestimonialCardTile extends StatelessWidget {
  TestimonialList testimonial;
  TestimonialCardTile({Key? key, required this.testimonial}) : super(key: key);

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
                alignment: Alignment.centerRight,
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
                            testimonial.companyName.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(testimonial.comment),
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
