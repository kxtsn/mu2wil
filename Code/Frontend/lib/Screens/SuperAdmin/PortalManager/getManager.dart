// ignore_for_file: file_names

import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';

import '../../../../main.dart';

import 'package:http/http.dart' as http;

List<ManagerList> parseManager(String responseBody) {
  Map<dynamic, dynamic> managerMap =
      jsonDecode(responseBody) as Map<String, dynamic>;

  List<ManagerList> _managerList = (managerMap['result']! as List)
      .map((item) => ManagerList.fromJson(item))
      .toList();

  return _managerList;
}

Future<List<ManagerList>> fetchManagerList(http.Client client) async {
  var url = "$SERVER_IP/api/super-admin/view-all-portal-manager";
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
    // print(response.body);
    return parseManager(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
        'Failed to load Manager List ${response.statusCode.toString()}');
  }
}

Future commitDeleteManager(String managerId) async {
  String? token;
  token = await localstorage.getToken();

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/super-admin/delete-portal-manager"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'managerId': managerId,
    }),
  );

  var message = jsonDecode(response.body);
  //print(message);
  if (response.statusCode == 201) {
    //print("commited successful");
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return message;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception(
        'Failed to delete manager. ${response.statusCode.toString()}');
  }
}

Future commitNew(
  String firstName,
  String lastName,
  String email,
) async {
  String? token;

  token = await localstorage.getToken();

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/super-admin/create-portal-manager"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    }),
  );

  var message = jsonDecode(response.body);

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return message;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception(
        'Failed to create manager. ${response.statusCode.toString()}');
  }
}

Future commitCheck(String email) async {
  String? token;

  token = await localstorage.getToken();

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/util/check-email-exist"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{'email': email}),
  );

  //var result = jsonDecode(response.body);

  if (response.statusCode == 201) {
    Map<String, dynamic> map = jsonDecode(response.body);
    bool check = map['result'];
    return check;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Email already exist. ${response.statusCode.toString()}');
  }
}

Future commitUpdate(String managerId, String firstName, String lastName) async {
  String? token;
  token = await localstorage.getToken();

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/super-admin/update-portal-manager"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, dynamic>{
      'managerId': managerId,
      'firstName': firstName,
      'lastName': lastName
    }),
  );

  var message = jsonDecode(response.body);

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return message;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception(
        'Failed to update manager. ${response.statusCode.toString()}');
  }
}

class ManagerList {
  final int managerId;
  final String firstName;
  final String lastName;
  final String email;

  ManagerList(
      {required this.managerId,
      required this.firstName,
      required this.lastName,
      required this.email});

  bool selected = false;

  factory ManagerList.fromJson(Map<dynamic, dynamic> json) {
    return ManagerList(
        managerId: json["Portal_Manager_ID"] as int,
        firstName: json["First_Name"] as String,
        lastName: json["Last_Name"] as String,
        email: json["Email"] as String);
  }
}
