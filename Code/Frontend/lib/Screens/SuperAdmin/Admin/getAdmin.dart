// ignore_for_file: file_names

import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';

import '../../../../main.dart';

import 'package:http/http.dart' as http;

List<AdminList> parseAdmin(String responseBody) {
  Map<dynamic, dynamic> adminMap =
      jsonDecode(responseBody) as Map<String, dynamic>;

  List<AdminList> _adminList = (adminMap['result']! as List)
      .map((item) => AdminList.fromJson(item))
      .toList();

  return _adminList;
}

Future<List<AdminList>> fetchAdminList(http.Client client) async {
  var url = "$SERVER_IP/api/super-admin/view-all-super-admin";
  String? token;
  if (kIsWeb) {
    token = await localstorage.getToken();
  } else {
    token = await storage.getToken();
  }

  final response = await client.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });

  if (response.statusCode == 201) {
    // If the server did return a 201 OK response,
    // then parse the JSON.
    print(response.body);
    return parseAdmin(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
        'Failed to load Admin List ${response.statusCode.toString()}');
  }
}

Future commitDeleteAdmin(String adminId) async {
  String? token;
  if (kIsWeb) {
    token = await localstorage.getToken();
  } else {
    token = await storage.getToken();
  }

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/super-admin/delete-super-admin"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'adminId': adminId,
    }),
  );

  var message = jsonDecode(response.body);
  //print(message);
  if (response.statusCode == 201) {
    print("commited successful");
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return message;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception(
        'Failed to delete admin. ${response.statusCode.toString()}');
  }
}

Future commitNew(
  String firstName,
  String lastName,
  String email,
) async {
  String? token;
  if (kIsWeb) {
    token = await localstorage.getToken();
  } else {
    token = await storage.getToken();
  }

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/super-admin/create-super-admin"),
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
        'Failed to create admin. ${response.statusCode.toString()}');
  }
}

Future commitCheck(String email) async {
  String? token;
  if (kIsWeb) {
    token = await localstorage.getToken();
  } else {
    token = await storage.getToken();
  }

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

Future commitUpdate(String adminId, String firstName, String lastName) async {
  String? token;
  if (kIsWeb) {
    token = await localstorage.getToken();
  } else {
    token = await storage.getToken();
  }

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/super-admin/update-super-admin"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, dynamic>{
      'adminId': adminId,
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
        'Failed to update admin. ${response.statusCode.toString()}');
  }
}

class AdminList {
  final int adminId;
  final String firstName;
  final String lastName;
  final String email;

  AdminList(
      {required this.adminId,
      required this.firstName,
      required this.lastName,
      required this.email});

  bool selected = false;

  factory AdminList.fromJson(Map<dynamic, dynamic> json) {
    return AdminList(
        adminId: json["Super_Admin_ID"] as int,
        firstName: json["First_Name"] as String,
        lastName: json["Last_Name"] as String,
        email: json["Email"] as String);
  }
}
