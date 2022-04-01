import 'package:flutter/material.dart';
import 'package:my_app/Screens/SuperAdmin/Student/body.dart';

class ViewStudent extends StatelessWidget {
  var student;
  ViewStudent({Key? key, this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Body(student: student),
            ),
          ],
        ),
      ),
    );
  }
}
