import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';

List<ListingList> parseListingDetails(String responseBody) {
  Map<dynamic, dynamic> listingDetailsMap = jsonDecode(responseBody);

  List<ListingList> _listingDetails = (listingDetailsMap['result']! as List)
      .map((item) => ListingList.fromJson(item))
      .toList();

  return _listingDetails;
}

Future<List<ListingList>> fetchListingDetails(http.Client client) async {
  var url = "$SERVER_IP/api/student/view-approved-listing";
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
    return parseListingDetails(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
        'Failed to load Listing Details ${response.statusCode.toString()}');
  }
}

Future checkIfApplied(String listingId) async {
  String? token;
  if (kIsWeb) {
    token = await localstorage.getToken();
  } else {
    token = await storage.getToken();
  }

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/student/check-student-application"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'listingId': listingId,
    }),
  );

  //print(message);
  if (response.statusCode == 201) {
    Map<String, dynamic> map = jsonDecode(response.body);
    bool check = map['result'];
    print("bool: " + check.toString());
    return check;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception(
        'Fail to check application. ${response.statusCode.toString()}');
  }
}

Future createApplication(String listingId) async {
  String? token;
  if (kIsWeb) {
    token = await localstorage.getToken();
  } else {
    token = await storage.getToken();
  }

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/student/create-application"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'listingId': listingId,
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
        'Failed to create application. ${response.statusCode.toString()}');
  }
}

class ListingList {
  int? listingId;
  String? title;
  String? description;
  int? applicants;
  String? closingDate;
  String? status;
  String? applied;

  ListingList(
      {this.listingId,
      this.title,
      this.description,
      this.applicants,
      this.closingDate,
      this.status,
      this.applied});

  factory ListingList.fromJson(Map<String, dynamic> json) => ListingList(
      listingId: json["Listing_ID"] as int,
      title: json["Title"] as String,
      description: json["Description"] as String,
      applicants: json["Applicants"] as int,
      closingDate: json["Closing_Date"] as String,
      status: json["Status"] as String,
      applied: json["Applied"] as String);
}
