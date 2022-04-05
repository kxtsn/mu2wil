import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';

List<StudentList> parseStudentDetails(String responseBody) {
  Map<dynamic, dynamic> studentDetailsMap = jsonDecode(responseBody);

  List<StudentList> _studentDetails = (studentDetailsMap['result']! as List)
      .map((item) => StudentList.fromJson(item))
      .toList();

  return _studentDetails;
}

Future<List<StudentList>> fetchStudentDetails(http.Client client) async {
  var url = "$SERVER_IP/api/student/get-student-detail";
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
    return parseStudentDetails(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
        'Failed to load Student Details ${response.statusCode.toString()}');
  }
}

class StudentList {
  int? studentId;
  dynamic murdochId;
  String? firstName;
  String? lastName;
  String? email;

  StudentList(
      {this.studentId,
      this.firstName,
      this.lastName,
      this.email,
      this.murdochId});

  factory StudentList.fromJson(Map<String, dynamic> json) => StudentList(
        studentId: json["Student_ID"] as int,
        firstName: json["First_Name"] as String,
        lastName: json["Last_Name"] as String,
        email: json["Email"] as String,
        murdochId: json["Murdoch_Student_ID"],
      );
}
