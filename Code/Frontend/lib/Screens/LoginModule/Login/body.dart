// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:html';

import 'package:my_app/Screens/LoginModule/Login/background.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Fields/roundedPasswordField.dart';
import 'package:my_app/Fields/roundedInputField.dart';
import 'package:my_app/Fields/roundedButton.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/Screens/LoginModule/Register/register.dart';
import 'package:my_app/Screens/LoginModule/Reset/resetPassword.dart';
import 'package:my_app/Util/color.dart';

import '../../../main.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _email = '';
  String _password = '';

  bool _filledEmail = false;
  bool _filledPassword = false;

  void displayDialog(context, title, text) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(text),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'))
              ]));

  Future<String?> attemptLogIn(String email, String password) async {
    var res = await http.post(
      Uri.parse("$SERVER_IP/api/auth/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "email": email,
        "password": password,
      }),
    );
    Map<String, dynamic> responseMap = json.decode(res.body);
    print("hi in response map");
    print(responseMap);
    if (res.statusCode == 200) {
      localstorage.setToken(responseMap['token']);
      localstorage.setRole(responseMap['role'].toString());
      return res.body;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Image(
              image: AssetImage("../../../../images/murdoch_logo.png"),
              width: 350),
          SizedBox(height: size.height * 0.03),

          //email
          SizedBox(height: size.height * 0.03),
          RoundedInputField(
            widthSize: 400,
            hintText: "Email",
            onChanged: (value) {
              _email = value;
            },
            errorText: _filledEmail ? 'field must be filled' : null,
          ),

          //Password
          RoundedPasswordField(
            widthSize: 400,
            onChanged: (value) {
              _password = value;
            },
            errorText: _filledPassword ? 'field must be filled' : null,
          ),

          //Bottom Login button
          RoundedButton(
            widthSize: 400,
            text: "LOGIN",
            press: () async {
              print("hi in login");
              setState(() {
                _email.isEmpty ? _filledEmail = true : _filledEmail = false;
                _password.isEmpty
                    ? _filledPassword = true
                    : _filledPassword = false;
              });

              var response =
                  await attemptLogIn(_email.toString(), _password.toString());
              if (response != null) {
                var role = "";
                localstorage.setResponesKey(response);

                role = await localstorage.getRole();
                print("Hi role: " + role.toString());
                if (role == "1") {
                  print("Hello1");
                  Navigator.pushReplacementNamed(context, '/admin');
                } else if (role == "2") {
                  Navigator.pushReplacementNamed(context, '/portalManager');
                } else if (role == "3") {
                  Navigator.pushReplacementNamed(context, '/student');
                } else if (role == "4") {
                  Navigator.pushReplacementNamed(context, '/employer');
                }
              } else {
                displayDialog(context, "An Error has occurred",
                    "Email or Password is incorrect");
              }
            },
          ),

          SizedBox(height: size.height * 0.03),
          Row(
              children: [
                GestureDetector(
                    child: const Text(
                      "Forget Password",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(
                      //   builder: (context) {
                      //     return const ResetPasswordScreen();
                      //   },
                      //));
                    }),
                const SizedBox(
                  width: 150,
                ),
                GestureDetector(
                  child: const Text("Register New Company",
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const RegisterCompany();
                        },
                      ),
                    );
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min)
        ],
      ),
    );
  }
}
