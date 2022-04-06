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

Future getTestimonialById(String employerId) async {
  String? token;
  if (kIsWeb) {
    token = await localstorage.getToken();
  } else {
    token = await storage.getToken();
  }

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/student/get-company-testimonial"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'employerId': employerId,
    }),
  );

  //var message = jsonDecode(response.body);
  //print(message);
  if (response.statusCode == 201) {
    print("commited successful");
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return parseTestimonialList(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception(
        'Failed to load profile. ${response.statusCode.toString()}');
  }
}

class TestimonialList {
  int? testimonialId;
  int? applicationId;
  int? employerId;
  String? companyName;
  String? firstName;
  String? lastName;
  String? createdOn;
  String? comment;
  dynamic image;
  String? studentFirstName;
  String? studentLastName;
  String? email;
  String? telephone;
  String? contact;
  String? website;
  String? country;
  String? address1;
  String? address2;
  String? postal;
  String? companyCode;

  TestimonialList(
      {this.testimonialId,
      this.applicationId,
      this.employerId,
      this.companyName,
      this.studentFirstName,
      this.studentLastName,
      this.firstName,
      this.lastName,
      this.createdOn,
      this.comment,
      this.image,
      this.email,
      this.telephone,
      this.contact,
      this.website,
      this.country,
      this.address1,
      this.address2,
      this.postal,
      this.companyCode});

  bool selected = false;

  factory TestimonialList.fromJson(Map<dynamic, dynamic> json) {
    return TestimonialList(
        testimonialId: json["Employer_Testimonial_ID"] as int?,
        applicationId: json["Application_ID"] as int?,
        employerId: json["Employer_ID"] as int?,
        companyName: json["Company_Name"] as String?,
        firstName: json["First_Name"] as String?,
        lastName: json["Last_Name"] as String?,
        studentFirstName: json["Student_First_Name"] as String?,
        studentLastName: json["Student_Last_Name"] as String?,
        createdOn: json["Created_On"] as String?,
        comment: json["Comment"] as String?,
        image: json["File"]["data"],
        email: json["Email"] as String?,
        telephone: json["Telephone"] as String?,
        contact: json["Contact_Number"] as String?,
        website: json["Website"] as String?,
        country: json["Country"] as String?,
        address1: json["Address1"] as String?,
        address2: json["Address2"] as String?,
        postal: json["Postal_Code"] as String?,
        companyCode: json["Company_Code"] as String?);
  }
}
