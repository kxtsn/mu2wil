// ignore_for_file: file_names

import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';

import '../../../../main.dart';

import 'package:http/http.dart' as http;

List<StudentList> parseStudent(String responseBody) {
  Map<dynamic, dynamic> studentMap =
      jsonDecode(responseBody) as Map<String, dynamic>;

  List<StudentList> _studentList = (studentMap['result']! as List)
      .map((item) => StudentList.fromJson(item))
      .toList();

  return _studentList;
}

Future<List<StudentList>> fetchSAStudentList(http.Client client) async {
  var url = "$SERVER_IP/api/super-admin/view-all-student";
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
    //print(response.body);
    return parseStudent(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
        'Failed to load Student List ${response.statusCode.toString()}');
  }
}

Future<List<StudentList>> fetchStudentList(http.Client client) async {
  var url = "$SERVER_IP/api/portal-manager/view-all-student";
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
    //print(response.body);
    return parseStudent(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
        'Failed to load Student List ${response.statusCode.toString()}');
  }
}

Future commitDeleteStudent(String studentId) async {
  String? token;
  token = await localstorage.getToken();

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/portal-manager/delete-student"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'studentId': studentId,
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
        'Failed to delete student. ${response.statusCode.toString()}');
  }
}

Future commitGraduatedStudent(String studentId) async {
  String? token;
  token = await localstorage.getToken();

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/portal-manager/update-graduate"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'studentId': studentId,
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
        'Failed to update graduated. ${response.statusCode.toString()}');
  }
}

Future commitNew(
  String murdochId,
  String firstName,
  String lastName,
  String email,
) async {
  String? token;
  token = await localstorage.getToken();

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/portal-manager/create-student"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, dynamic>{
      'murdochId': murdochId,
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
        'Failed to create student. ${response.statusCode.toString()}');
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

Future commitUpdate(String studentId, String murdochId, String firstName,
    String lastName) async {
  String? token;
  token = await localstorage.getToken();

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/portal-manager/update-student"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, dynamic>{
      'studentId': studentId,
      'murdochId': murdochId,
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
        'Failed to update student. ${response.statusCode.toString()}');
  }
}

class StudentList {
  final int studentId;
  final String murdochId;
  final String firstName;
  final String lastName;
  final String email;
  final String status;

  StudentList(
      {required this.studentId,
      required this.murdochId,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.status});

  bool selected = false;

  factory StudentList.fromJson(Map<dynamic, dynamic> json) {
    return StudentList(
        studentId: json["Student_ID"] as int,
        murdochId: json["Murdoch_Student_ID"] as String,
        firstName: json["First_Name"] as String,
        lastName: json["Last_Name"] as String,
        email: json["Email"] as String,
        status: json["Status"] as String);
  }
}
