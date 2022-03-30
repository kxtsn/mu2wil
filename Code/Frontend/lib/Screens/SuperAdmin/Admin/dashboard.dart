import 'package:flutter/material.dart';
import 'package:my_app/Fields/header.dart';
import 'package:my_app/Screens/SuperAdmin/Admin/createAdmin.dart';
import 'package:my_app/Util/color.dart';

import 'adminRow.dart';

class DashBoard extends StatefulWidget {
  var admin;
  DashBoard({Key? key, this.admin}) : super(key: key);

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
                    title: 'Super Admin',
                  ),
                  const Flexible(
                      child: SizedBox(
                    width: 550,
                  )),
                  Header(
                    title: 'Super Admin Form',
                  ),
                ]),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(flex: 3, child: AdminRow()),
              Expanded(flex: 3, child: AddAdmin(admin: widget.admin)),
            ]),
          ],
        )));
  }
}
