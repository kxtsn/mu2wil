// ignore_for_file: file_names

import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';

import '../../../../main.dart';

import 'package:http/http.dart' as http;

List<EmpTestimonialList> parseTestimonialList(String responseBody) {
  Map<dynamic, dynamic> empTestimonialMap =
      jsonDecode(responseBody) as Map<String, dynamic>;

  List<EmpTestimonialList> _empTestimonialList =
      (empTestimonialMap['result']! as List)
          .map((item) => EmpTestimonialList.fromJson(item))
          .toList();

  return _empTestimonialList;
}

Future<List<EmpTestimonialList>> fetchEmpTestimonialList(
    http.Client client) async {
  var url = "$SERVER_IP/api/employer/view-written-testimonial";
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
    return parseTestimonialList(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
        'Failed to load testimonial List ${response.statusCode.toString()}');
  }
}

Future commitDelete(String testimonialId) async {
  String? token;
  token = await localstorage.getToken();

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/employer/delete-testimonial"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'testimonialId': testimonialId,
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
        'Failed to delete testimonial. ${response.statusCode.toString()}');
  }
}

Future createTestimonial(
    String applicationId, String comment, String file) async {
  String? token;
  token = await localstorage.getToken();

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/employer/create-testimonial"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, dynamic>{
      'applicationId': applicationId,
      'comment': comment,
      'blob': file,
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
        'Failed to create testimonial. ${response.statusCode.toString()}');
  }
}

class EmpTestimonialList {
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

  EmpTestimonialList(
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

  factory EmpTestimonialList.fromJson(Map<dynamic, dynamic> json) {
    return EmpTestimonialList(
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
