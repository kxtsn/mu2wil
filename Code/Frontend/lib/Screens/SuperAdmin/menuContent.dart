import 'package:flutter/material.dart';
import 'package:my_app/Screens/LoginModule/Login/login.dart';
import 'package:my_app/Screens/SuperAdmin/Testimonial/view.dart';
import 'package:my_app/Screens/SuperAdmin/Company/view.dart';
import 'package:my_app/Screens/SuperAdmin/Listing/view.dart';
import 'package:my_app/Screens/SuperAdmin/Student/view.dart';
import 'package:my_app/Screens/SuperAdmin/PortalManager/view.dart';
import 'package:my_app/Util/color.dart';

import 'Admin/view.dart';

class TopBarContents extends StatefulWidget {
  TopBarContents();

  @override
  _TopBarContentsState createState() => _TopBarContentsState();
}

class _TopBarContentsState extends State<TopBarContents> {
  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
        color: offWhiteColor.withOpacity(0.5),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Expanded(
                        child: Image(
                            alignment: Alignment.topLeft,
                            image: AssetImage(
                                "../../../../images/murdoch_logo.png"),
                            width: 300)),
                    Expanded(child: SizedBox(width: screenSize.width / 15)),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[0] = true
                              : _isHovering[0] = false;
                        });
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ViewAdmin();
                            },
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Super Admin',
                            style: TextStyle(
                                color: _isHovering[0]
                                    ? primaryColor
                                    : primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[0],
                            child: Container(
                              height: 2,
                              width: 100,
                              color: greyColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: screenSize.width / 30),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[1] = true
                              : _isHovering[1] = false;
                        });
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ViewManager();
                            },
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Portal Manager',
                            style: TextStyle(
                                color: _isHovering[1]
                                    ? primaryColor
                                    : primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[1],
                            child: Container(
                              height: 2,
                              width: 100,
                              color: greyColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: screenSize.width / 30),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[2] = true
                              : _isHovering[2] = false;
                        });
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ViewStudent();
                            },
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Students',
                            style: TextStyle(
                                color: _isHovering[2]
                                    ? primaryColor
                                    : primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[2],
                            child: Container(
                              height: 2,
                              width: 80,
                              color: greyColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: screenSize.width / 30),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[3] = true
                              : _isHovering[3] = false;
                        });
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ViewCompany();
                            },
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Companies',
                            style: TextStyle(
                                color: _isHovering[3]
                                    ? primaryColor
                                    : primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[3],
                            child: Container(
                              height: 2,
                              width: 80,
                              color: greyColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: screenSize.width / 30),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[4] = true
                              : _isHovering[4] = false;
                        });
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ViewListing();
                            },
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Listing',
                            style: TextStyle(
                                color: _isHovering[4]
                                    ? primaryColor
                                    : primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[4],
                            child: Container(
                              height: 2,
                              width: 70,
                              color: greyColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: screenSize.width / 30),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[5] = true
                              : _isHovering[5] = false;
                        });
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ViewTestimonial();
                            },
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Testimonial',
                            style: TextStyle(
                                color: _isHovering[5]
                                    ? primaryColor
                                    : primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[5],
                            child: Container(
                              height: 2,
                              width: 80,
                              color: greyColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: screenSize.width / 30),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[6] = true
                              : _isHovering[6] = false;
                        });
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const Login();
                            },
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Log Out',
                            style: TextStyle(
                                color: _isHovering[6]
                                    ? primaryColor
                                    : primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[6],
                            child: Container(
                              height: 2,
                              width: 80,
                              color: greyColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
