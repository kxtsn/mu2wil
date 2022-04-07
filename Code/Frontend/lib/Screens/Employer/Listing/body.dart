// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:my_app/Screens/Employer/Listing/dashboard.dart';
import 'package:my_app/Util/color.dart';
import 'package:my_app/Util/responsive.dart';
import 'package:my_app/Screens/Employer/menuDrawer.dart';

import '../menuContent.dart';

class Body extends StatefulWidget {
  var listing;
  Body({Key? key, this.listing}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final ScrollController _scrollController = ScrollController();

  _scrollListener() {
    setState(() {});
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
              child: const TopBarContents(),
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
                    child: DashBoard(listing: widget.listing)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
