import 'package:flutter/material.dart';
import 'package:my_app/Util/color.dart';

import 'getStudentProfile.dart';

class StudentDetailCards extends StatefulWidget {
  var studentList;
  StudentDetailCards({Key? key, required this.studentList}) : super(key: key);

  @override
  State<StudentDetailCards> createState() => _StudentDetailCardsState();
}

class _StudentDetailCardsState extends State<StudentDetailCards> {
  @override
  Widget build(BuildContext context) {
    widget.studentList.firstName ??= "";
    widget.studentList.lastName ??= "";
    widget.studentList.email ??= "";
    widget.studentList.murdochId ??= "";
    return Container(
        child: Column(children: [
      const SizedBox(
        height: 20,
      ),
      Container(
          decoration: BoxDecoration(
            border: Border.all(color: darkGreyColor),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Name: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.studentList.firstName! +
                      " " +
                      widget.studentList.lastName!),
                  const SizedBox(height: 5),
                  const Text("Murdoch Student ID: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.studentList.murdochId!),
                  const SizedBox(height: 5),
                  const Text("Email: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.studentList.email!),
                ],
              ),
            ],
          ))
    ]));
  }
}
