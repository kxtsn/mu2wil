// ignore_for_file: file_names, must_be_immutable

import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/Screens/Employer/Application/getApplication.dart';
import 'package:my_app/Screens/Employer/Testimonial/getWrittenTestimonial.dart';

import 'package:flutter/material.dart';

class TestimonialPopUp extends StatelessWidget {
  ApplicationList listing;
  TestimonialPopUp(BuildContext context, {Key? key, required this.listing})
      : super(key: key);

  final _commentTextController = TextEditingController();
  String comment = "";
  String fileName = "";

  // String getTitle() {
  //   if (testimonial != null) {
  //     return "Edit Testimonial";
  //   } else {
  //     return "Write Testimonial";
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    String i = "";
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Write Testimonial",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                  "Please write your testimonial for " +
                      listing.firstName! +
                      " " +
                      listing.lastName! +
                      ".",
                  style: const TextStyle(
                    color: Colors.black,
                  )),
              const SizedBox(height: 20),
              TextField(
                minLines: 1,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                controller: _commentTextController,
                decoration: const InputDecoration(
                    hintText: "Comment(s) | Feedback(S) | Remark(s)"),
                onChanged: (value) {
                  comment = value;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                child: const Text('UPLOAD IMAGE'),
                onPressed: () async {
                  var picked = await FilePicker.platform
                      .pickFiles(type: FileType.image, allowMultiple: false);

                  if (picked != null) {
                    Fluttertoast.showToast(
                        msg: "Image added.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        fontSize: 16.0);
                    Uint8List? fileBytes = picked.files.first.bytes;
                    List<int> image = fileBytes!.toList();
                    i = base64Encode(image);
                  }
                },
              ),
              Text(fileName),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
            onPressed: () async {
              await createTestimonial(
                  listing.applicationId.toString(), comment, i);
              Navigator.pop(context);
              Fluttertoast.showToast(
                  msg: "Testimonial Submitted.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  fontSize: 16.0);
            },
            child: const Text("Confirm")),
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
