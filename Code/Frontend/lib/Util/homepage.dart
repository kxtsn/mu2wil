import 'dart:convert' show json, base64, ascii;
import 'package:flutter/material.dart';

import '../main.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  HomePage(this.jwt, this.payload);

  factory HomePage.fromBase64(String jwt) => HomePage(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  final String jwt;
  final Map<String, dynamic> payload;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Secret Data Screen")),
        body: Center(
          child: FutureBuilder(
              // can use to read role id or token to check which page to go
              future: http
                  .read(Uri.parse('$SERVER_IP/'), headers: {"isLoggedIn": jwt}),
              builder: (context, snapshot) => snapshot.hasData
                  ? Column(
                      children: <Widget>[
                        Text(
                          "${payload['username']}, here's the data:" +
                              "${payload['token']},here's your token",
                          style: const TextStyle(color: Colors.black),
                        ),
                        Text(
                          snapshot.data.toString(),
                          style: const TextStyle(color: Colors.black),
                        )
                      ],
                    )
                  : snapshot.hasError
                      ? const Text("An error occurred")
                      : const CircularProgressIndicator()),
        ),
      );
}
