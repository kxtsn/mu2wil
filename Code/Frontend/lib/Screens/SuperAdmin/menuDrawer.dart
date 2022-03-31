import 'package:flutter/material.dart';
import 'package:my_app/Screens/SuperAdmin/Admin/view.dart';
import 'package:my_app/Screens/SuperAdmin/PortalManager/view.dart';
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
                        return ViewAdmin();
                      },
                    ),
                  );
                },
                child: const Text(
                  'Super Admin',
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
                        return ViewManager();
                      },
                    ),
                  );
                },
                child: const Text(
                  'Portal Manager',
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
                onTap: () {},
                child: const Text(
                  'Students',
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
                onTap: () {},
                child: const Text(
                  'Companies',
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
                onTap: () {},
                child: const Text(
                  'Listing',
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
                onTap: () {},
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
                onTap: () {},
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
