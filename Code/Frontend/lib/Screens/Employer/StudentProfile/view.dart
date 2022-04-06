import 'package:flutter/material.dart';
import 'package:my_app/Screens/Employer/StudentProfile/body.dart';

class ViewStudentProfile extends StatelessWidget {
  var studentId;
  ViewStudentProfile({Key? key, required this.studentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Body(studentId: studentId),
            ),
          ],
        ),
      ),
    );
  }
}
