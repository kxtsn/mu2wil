// ignore_for_file: library_prefixes

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Screens/LoginModule/Login/login.dart';
// import 'Screens/DigitalInventory/home.dart' as DI;
// import 'Screens/Sales/home.dart' as Sales;
// import 'Screens/Warehouse/home.dart' as Warehouse;
// import 'Screens/Admin/home.dart' as Admin;

import 'main.dart';
import 'Util/color.dart';

// ignore: prefer_typing_uninitialized_variables
var role;

Future<String> get responseOrEmpty async {
  // ignore: prefer_typing_uninitialized_variables
  var response, role;
  if (kIsWeb) {
    response = await localstorage.getResponseKey();
    role = await localstorage.getRole();
  } else {
    response = await storage.getResponseKey();
    role = await storage.getRole();
  }
  if (response == null) return "";
  return response;
}

checkRole() async {
  role = await localstorage.getRole();
}

class BaseBuilding extends StatelessWidget {
  const BaseBuilding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MU2WIL',
        theme: ThemeData(
            primaryColor: primaryColor,
            scaffoldBackgroundColor: kBackGroundColor,
            // textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            //     .apply(bodyColor: primaryColor),
            //Colors.black),
            //canvasColor: primaryColor,
            cardTheme: const CardTheme(
              color: kBackGroundColor,
            )),
        home: FutureBuilder(
            future: responseOrEmpty,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              if (snapshot.data != "") {
                var str = snapshot.data;
                print(str);
                var response = str.toString().split(".");

                if (response.length != 3) {
                  return const Login();
                } else {
                  // //if user has logged in before token xpiry, if user has token comes here
                  var payload = json.decode(ascii
                      .decode(base64.decode(base64.normalize(response[1]))));
                  if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
                      .isAfter(DateTime.now())) {
                    //return HomePage(str.toString(), payload);
                    var role = payload['role'];
                    //   if (role == "1") {
                    //     return const Admin.Home();
                    //   }
                    //   if (role == "2") {
                    //     return const PortalManager.Home();
                    //   }
                    //   if (role == "3") {
                    //     return const Student.Home();
                    //   }
                    //   if (role == "4") {
                    //     return const Employer.Home();
                    //   } else {
                    //     return const Login();
                    //   }
                    // } else {
                    return const Login();
                  }
                }
              } else {
                return const Login();
              }
              return const Login();
            }),
        routes: {
          '/login': (context) => const Login(),
          //'/signup': (context) => const SignUp(),
          //'/employer': (context) => const DI.Home(),
          //'/admin': (context) => const ClientScreen(),
          //'/portalManager': (context) => const EmployeeScreen(),
          //'/student': (context) => const Sales.Home(),
        });
  }
}
