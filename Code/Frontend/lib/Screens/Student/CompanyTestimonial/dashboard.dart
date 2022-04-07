import 'package:flutter/material.dart';
import 'package:my_app/Fields/header.dart';
import 'package:my_app/Screens/Student/CompanyTestimonial/getCompanyProfile.dart';
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
  bool _isLoadedProfile = false;
  bool _isLoaded = false;
  CompanyList company = CompanyList();
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
    final results = await fetchCompanyDetails(widget.employerId.toString());
    if (!_isLoadedProfile) {
      setState(() {
        company = results[0];
        _isLoadedProfile = true;
      });
    }
  }

  Future<void> getTestimonials() async {
    final results = await fetchTestimonial(widget.employerId.toString());
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
                  flex: 3, child: CompanyDetailCards(companyList: company)),
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
