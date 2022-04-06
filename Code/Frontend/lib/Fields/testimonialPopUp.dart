// ignore_for_file: file_names, must_be_immutable

import 'package:my_app/Screens/Student/Application/getApplication.dart';
import 'package:my_app/Screens/Student/Testimonial/getWrittenTestimonial.dart';

import 'roundedInputField.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TestimonialPopUp extends StatelessWidget {
  StdTestimonialList? testimonial;
  ApplicationList listing;
  TestimonialPopUp(BuildContext context,
      {Key? key, this.testimonial, required this.listing})
      : super(key: key);

  final _commentTextController = TextEditingController();
  String comment = "";

  String getTitle() {
    if (testimonial != null) {
      return "Edit Testimonial";
    } else {
      return "Write Testimonial";
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getTitle(),
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Text("Please write your testimonial for " + listing.title! + ".",
                  style: const TextStyle(
                    color: Colors.black,
                  )),
              const SizedBox(height: 20),
              TextField(
                minLines: 1,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                controller: _commentTextController,
                decoration: const InputDecoration(hintText: "Comment: "),
                onChanged: (value) {
                  comment = value;
                },
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(onPressed: () {}, child: const Text("Confirm")),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
