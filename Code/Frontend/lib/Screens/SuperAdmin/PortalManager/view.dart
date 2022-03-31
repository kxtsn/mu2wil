import 'package:flutter/material.dart';
import 'package:my_app/Screens/SuperAdmin/PortalManager/body.dart';

class ViewManager extends StatelessWidget {
  var manager;
  ViewManager({Key? key, this.manager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Body(manager: manager),
            ),
          ],
        ),
      ),
    );
  }
}
