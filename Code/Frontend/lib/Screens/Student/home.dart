import 'package:flutter/material.dart';

import 'Profile/view.dart';

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
              child: ViewProfile(),
            ),
          ],
        ),
      ),
    );
  }
}
