import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';

List<CompanyList> parseCompanyDetails(String responseBody) {
  Map<dynamic, dynamic> companyDetailsMap = jsonDecode(responseBody);

  List<CompanyList> _companyDetails = (companyDetailsMap['result']! as List)
      .map((item) => CompanyList.fromJson(item))
      .toList();

  return _companyDetails;
}

Future<List<CompanyList>> fetchCompanyDetails(String employerId) async {
  String? token;
  token = await localstorage.getToken();

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/student/get-company-detail"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'employerId': employerId,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 OK response,
    // then parse the JSON.
    //print(response.body);
    return parseCompanyDetails(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
        'Failed to load Company Details ${response.statusCode.toString()}');
  }
}

class CompanyList {
  int? employerId;
  String? firstName;
  String? lastName;
  String? email;
  String? contact;
  String? companyName;
  String? telephone;
  String? website;
  String? country;
  String? address1;
  String? address2;
  String? postal;
  String? companyCode;

  CompanyList(
      {this.employerId,
      this.firstName,
      this.lastName,
      this.email,
      this.contact,
      this.companyName,
      this.telephone,
      this.website,
      this.country,
      this.address1,
      this.address2,
      this.postal,
      this.companyCode});

  factory CompanyList.fromJson(Map<String, dynamic> json) => CompanyList(
        employerId: json["Employer_ID"] as int,
        firstName: json["First_Name"] as String,
        lastName: json["Last_Name"] as String,
        email: json["Email"] as String,
        contact: json["Contact_Number"] as String,
        companyName: json["Company_Name"] as String,
        telephone: json["Telephone"] as String,
        website: json["Website"] as String,
        country: json["Country"] as String,
        address1: json["Address1"] as String,
        address2: json["Address2"] as String,
        postal: json["Postal_Code"] as String,
        companyCode: json["Company_Code"] as String,
      );
}
