import 'package:flutter/material.dart';
import 'package:my_app/Fields/header.dart';
import 'package:my_app/Screens/PortalManager/Testimonial/empTestimonialRow.dart';
import 'package:my_app/Screens/PortalManager/Testimonial/stdTestimonialRow.dart';
import 'package:my_app/Util/color.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

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
                    title: 'Student Written Testimonial',
                  ),
                ]),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(child: StdTestimonialRow()),
            ]),
            const SizedBox(
              height: 20,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(
                    title: 'Company Written Testimonial',
                  ),
                ]),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(child: EmpTestimonialRow()),
            ]),
          ],
        )));
  }
}
