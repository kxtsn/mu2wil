import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';

List<ApplicationList> parseApplicantDetails(String responseBody) {
  Map<dynamic, dynamic> applicantDetailsMap = jsonDecode(responseBody);

  List<ApplicationList> _applicantDetails =
      (applicantDetailsMap['result']! as List)
          .map((item) => ApplicationList.fromJson(item))
          .toList();

  return _applicantDetails;
}

Future<List<ApplicationList>> fetchApplicationDetails(
    http.Client client) async {
  var url = "$SERVER_IP/api/student/view-own-application";
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
    return parseApplicantDetails(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
        'Failed to load Application Details ${response.statusCode.toString()}');
  }
}

Future cancelApplication(String applicationId) async {
  String? token;
  if (kIsWeb) {
    token = await localstorage.getToken();
  } else {
    token = await storage.getToken();
  }

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/student/cancel-application"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'applicationId': applicationId,
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
        'Failed to cancel application. ${response.statusCode.toString()}');
  }
}

class ApplicationList {
  int? applicationId;
  int? listingId;
  String? title;
  String? description;
  int? applicants;
  String? closingDate;
  String? listingStatus;
  String? status;

  ApplicationList(
      {this.applicationId,
      this.listingId,
      this.title,
      this.description,
      this.applicants,
      this.closingDate,
      this.listingStatus,
      this.status});

  factory ApplicationList.fromJson(Map<String, dynamic> json) =>
      ApplicationList(
        applicationId: json["Application_ID"] as int,
        listingId: json["Listing_ID"] as int,
        title: json["Title"] as String,
        description: json["Description"] as String,
        applicants: json["Applicants"] as int,
        closingDate: json["Closing_Date"] as String,
        listingStatus: json["Listing_Status"] as String,
        status: json["Status"] as String,
      );
}
