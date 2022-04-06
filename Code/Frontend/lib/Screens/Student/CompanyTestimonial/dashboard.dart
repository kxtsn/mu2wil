import 'package:flutter/material.dart';
import 'package:my_app/Fields/header.dart';
import 'package:my_app/Screens/Student/CompanyTestimonial/profile.dart';
import 'package:my_app/Screens/Student/CompanyTestimonial/testimonialCarousel.dart';
import 'package:my_app/Util/color.dart';
import 'package:my_app/Screens/Student/CompanyTestimonial/getTestimonial.dart';

class DashBoard extends StatefulWidget {
  var employerId;
  DashBoard({Key? key, required this.employerId}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<TestimonialList> testimonialLists = [];
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      getData();
    });
  }

  //getdata
  Future<void> getData() async {
    final results = await getTestimonialById(widget.employerId);
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
                    title: 'Company\'s Profile',
                  ),
                  const Flexible(
                      child: SizedBox(
                    width: 550,
                  )),
                  Header(
                    title: "Testimonials",
                  ),
                ]),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                  flex: 3,
                  child: CompanyDetailCards(companyLists: testimonialLists)),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  flex: 3,
                  child: TestimonialCarousel(
                    testimonialLists: testimonialLists,
                  )),
            ]),
          ],
        )));
  }
}
