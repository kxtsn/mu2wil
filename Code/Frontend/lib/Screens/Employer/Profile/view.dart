import 'package:flutter/material.dart';
import 'package:my_app/Screens/Employer/Profile/body.dart';

class ViewProfile extends StatelessWidget {
  ViewProfile({Key? key}) : super(key: key);

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
