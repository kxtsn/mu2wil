import 'package:flutter/material.dart';
import 'package:my_app/Fields/header.dart';
import 'package:my_app/Screens/PortalManager/Student/createStudent.dart';
import 'package:my_app/Util/color.dart';

import 'studentRow.dart';

class DashBoard extends StatefulWidget {
  var student;
  DashBoard({Key? key, this.student}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(
                    title: 'Students',
                  ),
                  const Flexible(
                      child: SizedBox(
                    width: 550,
                  )),
                  Header(
                    title: 'Student Form',
                  ),
                ]),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(flex: 3, child: StudentRow()),
              Expanded(flex: 3, child: AddStudent(student: widget.student)),
            ]),
          ],
        )));
  }
}
