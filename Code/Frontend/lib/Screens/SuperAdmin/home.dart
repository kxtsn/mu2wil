import 'package:my_app/Screens/SuperAdmin/Admin/view.dart';

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ViewAdmin(),
            ),
          ],
        ),
      ),
    );
  }
}
