// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_app/Screens/Employer/Application/view.dart';
import 'package:my_app/Screens/Employer/Listing/view.dart';
import 'package:my_app/Screens/Employer/Profile/view.dart';
import 'package:my_app/Screens/Employer/Testimonial/view.dart';
import 'package:my_app/Screens/LoginModule/Login/login.dart';
import 'package:my_app/Util/color.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Flexible(child: SizedBox(height: 20)),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ViewProfile();
                      },
                    ),
                  );
                },
                child: const Text(
                  'Dashboard',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: greyColor,
                  thickness: 1,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ViewApplication();
                      },
                    ),
                  );
                },
                child: const Text(
                  'Applications',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: greyColor,
                  thickness: 1,
                ),
              ),
              InkWell(
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
                child: const Text(
                  'Listings',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: greyColor,
                  thickness: 1,
                ),
              ),
              InkWell(
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
                child: const Text(
                  'Testimonials',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: greyColor,
                  thickness: 1,
                ),
              ),
              InkWell(
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
                child: const Text(
                  'Log Out',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Copyright © 2021 | Murdoch University \nICT302 TJA PT Group 5',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
