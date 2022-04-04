import 'package:flutter/material.dart';
import 'package:my_app/Screens/PortalManager/Testimonial/dashboard.dart';
import 'package:my_app/Util/color.dart';
import 'package:my_app/Util/responsive.dart';
import 'package:my_app/Screens/PortalManager/menuDrawer.dart';

import '../menuContent.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              iconTheme: const IconThemeData(color: primaryColor),
              backgroundColor: offWhiteColor,
              elevation: 0,
              centerTitle: true,
              title: const Image(
                  image: AssetImage("../../../../images/murdoch_logo.png"),
                  width: 150),
            )
          : PreferredSize(
              child: TopBarContents(),
              preferredSize: Size(screenSize.width, 70),
            ),
      drawer: const MenuDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                    height: screenSize.height * .9,
                    width: screenSize.width,
                    child: DashBoard()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
