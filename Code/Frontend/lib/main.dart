import 'package:flutter/material.dart';
import 'package:my_app/Util/localstorage.dart';
import 'package:my_app/Util/usersecurestorage.dart';
import 'basebuilding.dart';

// ignore: constant_identifier_names
const SERVER_IP = 'http://localhost:3000';
//'http://10.0.2.2:3000';

//const storage = FlutterSecureStorage();
UserSecureStorage storage = UserSecureStorage();
UserLocalStorage localstorage = UserLocalStorage();

void main() => runApp(const myApp());

// ignore: camel_case_types
class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(child: BaseBuilding()),
    );
  }
}
