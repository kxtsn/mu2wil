// ignore_for_file: file_names

import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';

import '../../../../main.dart';

import 'package:http/http.dart' as http;

List<CompanyList> parseEmployer(String responseBody) {
  Map<dynamic, dynamic> companyMap =
      jsonDecode(responseBody) as Map<String, dynamic>;

  List<CompanyList> _companyList = (companyMap['result']! as List)
      .map((item) => CompanyList.fromJson(item))
      .toList();

  return _companyList;
}

Future<List<CompanyList>> fetchCompanyList(http.Client client) async {
  var url = "$SERVER_IP/api/portal-manager/view-all-employer";
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
    return parseEmployer(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
        'Failed to load employer List ${response.statusCode.toString()}');
  }
}

Future commitReject(String employerId) async {
  String? token;
  if (kIsWeb) {
    token = await localstorage.getToken();
  } else {
    token = await storage.getToken();
  }

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/portal-manager/reject-employer"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'employerId': employerId,
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
        'Failed to reject employer. ${response.statusCode.toString()}');
  }
}

Future commitApprove(String employerId) async {
  String? token;
  if (kIsWeb) {
    token = await localstorage.getToken();
  } else {
    token = await storage.getToken();
  }

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/portal-manager/approve-employer"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'employerId': employerId,
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
        'Failed to approve employer. ${response.statusCode.toString()}');
  }
}

class CompanyList {
  final int companyId;
  final String companyCode;
  final String companyName;
  final String website;
  final String firstName;
  final String lastName;
  final String email;
  final String contactNo;
  final String tel;
  final String country;
  final String address1;
  final String address2;
  final String postal;
  final String status;

  CompanyList(
      {required this.companyId,
      required this.companyCode,
      required this.companyName,
      required this.website,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.contactNo,
      required this.tel,
      required this.country,
      required this.address1,
      required this.address2,
      required this.postal,
      required this.status});

  bool selected = false;

  factory CompanyList.fromJson(Map<dynamic, dynamic> json) {
    return CompanyList(
        companyId: json["Employer_ID"] as int,
        companyCode: json["Company_Code"] as String,
        companyName: json["Company_Name"] as String,
        website: json["Website"] as String,
        firstName: json["First_Name"] as String,
        lastName: json["Last_Name"] as String,
        email: json["Email"] as String,
        contactNo: json["Contact_Number"] as String,
        tel: json["Telephone"] as String,
        country: json["Country"] as String,
        address1: json["Address1"] as String,
        address2: json["Address2"] as String,
        postal: json["Postal_Code"] as String,
        status: json["Status"] as String);
  }
}
