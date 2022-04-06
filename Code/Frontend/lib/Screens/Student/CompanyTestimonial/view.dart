import 'package:flutter/material.dart';
import 'package:my_app/Screens/Student/CompanyTestimonial/body.dart';

class ViewComTestimonial extends StatelessWidget {
  var employerId;
  ViewComTestimonial({Key? key, required this.employerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Body(employerId: employerId),
            ),
          ],
        ),
      ),
    );
  }
}
