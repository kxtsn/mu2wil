// ignore_for_file: file_names

import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';

import '../../../../main.dart';

import 'package:http/http.dart' as http;

List<TestimonialList> parseTestimonialList(String responseBody) {
  Map<dynamic, dynamic> stdTestimonialMap =
      jsonDecode(responseBody) as Map<String, dynamic>;

  List<TestimonialList> _stdTestimonialList =
      (stdTestimonialMap['result']! as List)
          .map((item) => TestimonialList.fromJson(item))
          .toList();

  return _stdTestimonialList;
}

Future<List<TestimonialList>> fetchTestimonial(String studentId) async {
  String? token;
  token = await localstorage.getToken();

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/employer/view-testimonial-of-student"),
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
    //print(response.body);
    return parseTestimonialList(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
        'Failed to load Testimonial Details ${response.statusCode.toString()}');
  }
}

class TestimonialList {
  final int testimonialId;
  final int applicationId;
  final int createdBy;
  final int studentId;
  final String companyName;
  final String firstName;
  final String lastName;
  final String createdOn;
  final String comment;
  final dynamic image;
  final String status;

  TestimonialList(
      {required this.testimonialId,
      required this.applicationId,
      required this.createdBy,
      required this.studentId,
      required this.companyName,
      required this.firstName,
      required this.lastName,
      required this.createdOn,
      required this.comment,
      required this.image,
      required this.status});

  bool selected = false;

  factory TestimonialList.fromJson(Map<dynamic, dynamic> json) {
    return TestimonialList(
        testimonialId: json["Employer_Testimonial_ID"] as int,
        applicationId: json["Application_ID"] as int,
        createdBy: json["Created_By"] as int,
        studentId: json["Student_ID"] as int,
        companyName: json["Company_Name"] as String,
        firstName: json["First_Name"] as String,
        lastName: json["Last_Name"] as String,
        createdOn: json["Created_On"] as String,
        comment: json["Comment"] as String,
        image: json["File"]["data"],
        status: json["Status"] as String);
  }
}
