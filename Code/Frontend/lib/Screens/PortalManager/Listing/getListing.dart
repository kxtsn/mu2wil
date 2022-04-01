// ignore_for_file: file_names

import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';

import '../../../../main.dart';

import 'package:http/http.dart' as http;

List<ListingList> parseListingList(String responseBody) {
  Map<dynamic, dynamic> listingMap =
      jsonDecode(responseBody) as Map<String, dynamic>;

  List<ListingList> _listingList = (listingMap['result']! as List)
      .map((item) => ListingList.fromJson(item))
      .toList();

  return _listingList;
}

Future<List<ListingList>> fetchListingList(http.Client client) async {
  var url = "$SERVER_IP/api/portal-manager/view-all-listing";
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
    return parseListingList(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
        'Failed to load listing List ${response.statusCode.toString()}');
  }
}

Future commitReject(String listingId) async {
  String? token;
  if (kIsWeb) {
    token = await localstorage.getToken();
  } else {
    token = await storage.getToken();
  }

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/portal-manager/reject-listing"),
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
        'Failed to reject listing. ${response.statusCode.toString()}');
  }
}

Future commitApprove(String listingId) async {
  String? token;
  if (kIsWeb) {
    token = await localstorage.getToken();
  } else {
    token = await storage.getToken();
  }

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/portal-manager/approve-listing"),
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
        'Failed to approve listing. ${response.statusCode.toString()}');
  }
}

class ListingList {
  final int listingId;
  final int employerId;
  final String companyName;
  final String title;
  final String description;
  final String closingDate;
  final int slot;
  final String status;

  ListingList(
      {required this.listingId,
      required this.employerId,
      required this.companyName,
      required this.title,
      required this.description,
      required this.closingDate,
      required this.slot,
      required this.status});

  bool selected = false;

  factory ListingList.fromJson(Map<dynamic, dynamic> json) {
    return ListingList(
        listingId: json["Listing_ID"] as int,
        employerId: json["Employer_ID"] as int,
        companyName: json["Company_Name"] as String,
        title: json["Title"] as String,
        description: json["Description"] as String,
        closingDate: json["Closing_Date"] as String,
        slot: json["Available_Slot"] as int,
        status: json["Status"] as String);
  }
}
