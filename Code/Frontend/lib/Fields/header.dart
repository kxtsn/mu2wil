// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import '../../main.dart';
import '../../util/color.dart';
import 'package:http/http.dart' as http;

class Header extends StatefulWidget {
  String title;

  Header({Key? key, required this.title}) : super(key: key);
  @override
  _HeaderRowState createState() => _HeaderRowState();
}

class _HeaderRowState extends State<Header> {
  String firstname = "";
  bool isLoaded = false;
  //getdata
  // Future<void> getData() async {
  //   final result = await fetchFirstName(http.Client());
  //   if (!isLoaded) {
  //     setState(() {
  //       firstname = result[0].firstName.toUpperCase();
  //       isLoaded = true;
  //     });
  //   }
  // }

  @override
  void initState() {
    //getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title,
      style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
      textScaleFactor: 1.2,
    );
    // Flexible(
    //   child: ProfileCard(firstName: firstname.toString()),
    // ),
  }
}

class ProfileCard extends StatelessWidget {
  ProfileCard({Key? key, required this.firstName}) : super(key: key);
  String firstName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16),
      padding: EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: kBackGroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),

          child: Text(firstName),
          //Body().username),
        ),
        Icon(Icons.keyboard_arrow_down),
      ]),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: title,
          fillColor: kBackGroundColor,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          suffixIcon: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(16 * 0.75),
                margin: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Icon(Icons.info),
              ))),
    );
  }
}

List<FirstName> parseFirstName(String responseBody) {
  Map<dynamic, dynamic> firstNameMap = jsonDecode(responseBody);

  List<FirstName> _firstNameList = (firstNameMap['result']! as List)
      .map((item) => FirstName.fromJson(item))
      .toList();

  return _firstNameList;
}

Future<List<FirstName>> fetchFirstName(http.Client client) async {
  var url = "$SERVER_IP/api/util/get-first-name";
  String? token;
  token = await localstorage.getToken();

  final response = await client.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });

  if (response.statusCode == 201) {
    // If the server did return a 201 OK response,
    // then parse the JSON.
    return parseFirstName(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to get first name');
  }
}

class FirstName {
  final String firstName;

  FirstName({required this.firstName});

  factory FirstName.fromJson(Map<dynamic, dynamic> json) {
    return FirstName(firstName: json["First_Name"]);
  }
}
