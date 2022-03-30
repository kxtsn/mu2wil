import 'package:flutter/material.dart';
import 'package:my_app/Screens/SuperAdmin/Admin/body.dart';

class ViewAdmin extends StatelessWidget {
  var admin;
  ViewAdmin({Key? key, this.admin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Body(admin: admin),
            ),
          ],
        ),
      ),
    );
  }
}
