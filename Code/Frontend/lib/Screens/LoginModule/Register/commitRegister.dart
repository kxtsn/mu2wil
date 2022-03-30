import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../../main.dart';

Future registerCompany(
    String companyName,
    String firstName,
    String lastName,
    String contact,
    String telephone,
    String email,
    String? website,
    String address1,
    String address2,
    String postal,
    String country,
    String companyCode) async {
  String? token;
  if (kIsWeb) {
    token = await localstorage.getToken();
  } else {
    token = await storage.getToken();
  }

  final response = await http.post(
    Uri.parse("$SERVER_IP/api/employer/register-employer"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, dynamic>{
      'companyName': companyName,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'contactNo': contact,
      'telephone': telephone,
      'website': website,
      'address1': address1,
      'address2': address2,
      'postal': postal,
      'country': country,
      'companyCode': companyCode
    }),
  );

  var message = jsonDecode(response.body);

  if (response.statusCode == 201) {
    return message;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception(
        'Failed to register company. ${response.statusCode.toString()}');
  }
}
