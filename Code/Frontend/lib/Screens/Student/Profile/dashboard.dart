import 'package:flutter/material.dart';
import 'package:my_app/Fields/header.dart';
import 'package:my_app/Screens/Student/Application/applicationDisplay.dart';
import 'package:my_app/Screens/Student/Profile/getStudentProfile.dart';
import 'package:my_app/Screens/Student/Profile/profileCard.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/Screens/Student/Testimonial/testimonialCarousel.dart';
import 'package:my_app/Util/color.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool _isLoaded = false;
  StudentList studentList = StudentList();

  @override
  void initState() {
    super.initState();
    setState(() {
      getData();
    });
  }

  //getdata
  Future<void> getData() async {
    final results = await fetchStudentDetails(http.Client());
    if (!_isLoaded) {
      setState(() {
        studentList = results[0];
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
                    width: 400,
                  )),
                  Header(
                    title: 'Your Application(s)',
                  ),
                ]),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                  flex: 2,
                  child: Column(children: [
                    StudentDetailCards(
                      studentList: studentList,
                    ),
                    const SizedBox(height: 15),
                    Header(
                      title: 'Testimonial(s) Received',
                    ),
                    const SizedBox(height: 5),
                    TestimonialCarousel()
                  ])),
              const SizedBox(width: 20),
              Expanded(flex: 4, child: ApplicationDisplay()),
            ]),
          ],
        )));
  }
}
