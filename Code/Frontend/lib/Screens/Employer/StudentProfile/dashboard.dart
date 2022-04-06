import 'package:flutter/material.dart';
import 'package:my_app/Fields/header.dart';
import 'package:my_app/Screens/Employer/StudentProfile/getStudentProfile.dart';
import 'package:my_app/Screens/Employer/StudentProfile/profileCard.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/Screens/Employer/StudentProfile/testimonialCarousel.dart';
import 'package:my_app/Util/color.dart';

import 'getStudentTestimonial.dart';

class DashBoard extends StatefulWidget {
  var studentId;
  DashBoard({Key? key, required this.studentId}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool _isLoaded = false;
  StudentProfile student = StudentProfile();
  List<TestimonialList> testimonialLists = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      getProfileData();
      getTestimonials();
    });
  }

  //getdata
  Future<void> getProfileData() async {
    final results = await fetchStudentDetails(widget.studentId.toString());
    if (!_isLoaded) {
      setState(() {
        student = results[0];
        _isLoaded = true;
      });
    }
  }

  Future<void> getTestimonials() async {
    final results = await fetchTestimonial(widget.studentId.toString());
    if (!_isLoaded) {
      setState(() {
        testimonialLists = results;
        _isLoaded = true;
      });
    }
  }

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
                    title: 'Profile',
                  ),
                  const Flexible(
                      child: SizedBox(
                    width: 600,
                  )),
                  Header(
                    title: 'Testimonials',
                  ),
                ]),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StudentDetailCards(
                        studentList: student,
                      ),
                    ],
                  )),
              const SizedBox(width: 20),
              Expanded(
                  flex: 3,
                  child:
                      TestimonialCarousel(testimonialLists: testimonialLists)),
            ]),
          ],
        )));
  }
}
