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
  var url = "$SERVER_IP/api/employer/view-own-listing";
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

Future commitClose(String listingId) async {
  String? token;
  if (kIsWeb) {
    token = await localstorage.getToken();
  } else {
    token = await storage.getToken();
  }

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/employer/close-listing"),
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
        'Failed to close listing. ${response.statusCode.toString()}');
  }
}

Future commitDelete(String listingId) async {
  String? token;
  if (kIsWeb) {
    token = await localstorage.getToken();
  } else {
    token = await storage.getToken();
  }

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/employer/delete-listing"),
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
        'Failed to delete listing. ${response.statusCode.toString()}');
  }
}

Future commitNew(
    String title, String description, String closingDate, String slot) async {
  String? token;
  token = await localstorage.getToken();

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/employer/create-listing"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, dynamic>{
      'title': title,
      'description': description,
      'closingDate': closingDate,
      'slot': slot
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
        'Failed to create listing. ${response.statusCode.toString()}');
  }
}

Future commitUpdate(String listingId, String title, String description,
    String closingDate, String slot) async {
  String? token;
  token = await localstorage.getToken();

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/employer/edit-listing"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, dynamic>{
      'listingId': listingId,
      'title': title,
      'description': description,
      'closingDate': closingDate,
      'slot': slot
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
        'Failed to update listing. ${response.statusCode.toString()}');
  }
}

class ListingList {
  final int listingId;
  final int employerId;
  final String title;
  final String description;
  final String closingDate;
  final int slot;
  final String status;
  final int applicants;

  ListingList(
      {required this.listingId,
      required this.employerId,
      required this.title,
      required this.description,
      required this.closingDate,
      required this.slot,
      required this.status,
      required this.applicants});

  bool selected = false;

  factory ListingList.fromJson(Map<dynamic, dynamic> json) {
    return ListingList(
        listingId: json["Listing_ID"] as int,
        employerId: json["Employer_ID"] as int,
        title: json["Title"] as String,
        description: json["Description"] as String,
        closingDate: json["Closing_Date"] as String,
        slot: json["Available_Slot"] as int,
        status: json["Status"] as String,
        applicants: json["Applicants"] as int);
  }
}
