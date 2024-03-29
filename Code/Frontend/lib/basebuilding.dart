// ignore_for_file: library_prefixes

import 'dart:convert';

import 'package:flutter/material.dart';
import 'Screens/LoginModule/Login/login.dart';
import 'Screens/SuperAdmin/home.dart' as SA;
import 'Screens/PortalManager/home.dart' as PM;
import 'Screens/Employer/home.dart' as E;
import 'Screens/Student/home.dart' as S;

import 'main.dart';
import 'Util/color.dart';

// ignore: prefer_typing_uninitialized_variables
var role;

Future<String> get responseOrEmpty async {
  // ignore: prefer_typing_uninitialized_variables
  var response;
  response = await localstorage.getResponseKey();
  role = await localstorage.getRole();
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
            cardTheme: const CardTheme(
              color: kBackGroundColor,
            )),
        home: FutureBuilder(
            future: responseOrEmpty,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              if (snapshot.data != "") {
                var str = snapshot.data;
                // print(str);
                var response = str.toString().split(".");

                if (response.length != 3) {
                  return const Login();
                } else {
                  // //if user has logged in before token xpiry, if user has token comes here
                  var payload = json.decode(ascii
                      .decode(base64.decode(base64.normalize(response[1]))));
                  if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
                      .isAfter(DateTime.now())) {
                    var role = payload['role'];
                    //print("Role: " + role.toString());
                    if (role == 1 || role.toString() == "1") {
                      return const SA.Home();
                    } else if (role == 2 || role.toString() == "2") {
                      return const PM.Home();
                    } else if (role == 3 || role.toString() == "3") {
                      return const S.Home();
                    } else if (role == 4 || role.toString() == "4") {
                      return const E.Home();
                    } else {
                      return const Login();
                    }
                  } else {
                    return const Login();
                  }
                }
              } else {
                return const Login();
              }
            }),
        routes: {
          '/login': (context) => const Login(),
          '/employer': (context) => const E.Home(),
          '/admin': (context) => const SA.Home(),
          '/portalManager': (context) => const PM.Home(),
          '/student': (context) => const S.Home(),
        });
  }
}
