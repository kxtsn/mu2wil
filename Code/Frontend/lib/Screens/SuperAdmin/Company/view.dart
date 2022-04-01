import 'package:flutter/material.dart';
import 'package:my_app/Screens/SuperAdmin/Company/body.dart';

class ViewCompany extends StatelessWidget {
  ViewCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Body(),
            ),
          ],
        ),
      ),
    );
  }
}
