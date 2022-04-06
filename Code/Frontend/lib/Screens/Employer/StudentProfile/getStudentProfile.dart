import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';

List<StudentProfile> parseStudentDetails(String responseBody) {
  Map<dynamic, dynamic> studentDetailsMap = jsonDecode(responseBody);

  List<StudentProfile> _studentDetails = (studentDetailsMap['result']! as List)
      .map((item) => StudentProfile.fromJson(item))
      .toList();

  return _studentDetails;
}

Future<List<StudentProfile>> fetchStudentDetails(String studentId) async {
  String? token;
  token = await localstorage.getToken();

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/employer/get-student-detail"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'studentId': studentId,
    }),
  );

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

class StudentProfile {
  int? studentId;
  dynamic murdochId;
  String? firstName;
  String? lastName;
  String? email;

  StudentProfile(
      {this.studentId,
      this.firstName,
      this.lastName,
      this.email,
      this.murdochId});

  factory StudentProfile.fromJson(Map<String, dynamic> json) => StudentProfile(
        studentId: json["Student_ID"] as int,
        firstName: json["First_Name"] as String,
        lastName: json["Last_Name"] as String,
        email: json["Email"] as String,
        murdochId: json["Murdoch_Student_ID"],
      );
}
