import 'package:flutter/material.dart';
import 'package:my_app/Fields/header.dart';
import 'package:my_app/Screens/SuperAdmin/PortalManager/createManager.dart';
import 'package:my_app/Util/color.dart';

import 'managerRow.dart';

class DashBoard extends StatefulWidget {
  var manager;
  DashBoard({Key? key, this.manager}) : super(key: key);

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
                    title: 'Portal Manager',
                  ),
                  const Flexible(
                      child: SizedBox(
                    width: 550,
                  )),
                  Header(
                    title: 'Portal Manager Form',
                  ),
                ]),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(flex: 3, child: ManagerRow()),
              Expanded(flex: 3, child: AddManager(manager: widget.manager)),
            ]),
          ],
        )));
  }
}
