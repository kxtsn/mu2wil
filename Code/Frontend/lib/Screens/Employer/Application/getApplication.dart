// ignore_for_file: file_names

import 'dart:convert';

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
  var url = "$SERVER_IP/api/employer/view-student-application";
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
    return parseApplicantDetails(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
        'Failed to load Application Details ${response.statusCode.toString()}');
  }
}

Future<List<ApplicationList>> fetchApplicationDetailsByListing(
    String listingId) async {
  String? token;
  token = await localstorage.getToken();

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/employer/view-application-by-listing"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, dynamic>{
      'listingId': listingId,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 OK response,
    // then parse the JSON.
    //print(response.body);
    return parseApplicantDetails(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
        'Failed to load Application Details by listing ${response.statusCode.toString()}');
  }
}

Future rejectApplication(String applicationId) async {
  String? token;
  token = await localstorage.getToken();

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/employer/reject-application"),
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
    //print("commited successful");
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return message;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception(
        'Failed to reject application. ${response.statusCode.toString()}');
  }
}

Future acceptApplication(String applicationId) async {
  String? token;
  token = await localstorage.getToken();

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/employer/accept-application"),
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
    //print("commited successful");
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return message;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception(
        'Failed to accept application. ${response.statusCode.toString()}');
  }
}

class ApplicationList {
  int? applicationId;
  String? title;
  String? description;
  String? firstName;
  String? lastName;
  String? email;
  String? murdochId;
  String? status;
  int? studentId;

  ApplicationList(
      {this.applicationId,
      this.title,
      this.description,
      this.firstName,
      this.lastName,
      this.email,
      this.murdochId,
      this.status,
      this.studentId});

  factory ApplicationList.fromJson(Map<String, dynamic> json) =>
      ApplicationList(
          applicationId: json["Application_ID"] as int,
          title: json["Title"] as String,
          description: json["Description"] as String,
          firstName: json["First_Name"] as String,
          lastName: json["Last_Name"] as String,
          email: json["Email"] as String,
          murdochId: json["Murdoch_Student_ID"] as String,
          status: json["Status"] as String,
          studentId: json["Student_ID"] as int);
}
