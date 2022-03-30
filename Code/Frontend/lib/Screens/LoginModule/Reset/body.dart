import 'package:my_app/Fields/roundedButton.dart';
import 'package:my_app/Fields/roundedInputField.dart';
import 'package:my_app/Screens/LoginModule/Login/background.dart';
import 'package:my_app/Screens/LoginModule/Login/login.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            const Image(
                image: AssetImage("../../../../images/murdoch_logo.png"),
                width: 350),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              widthSize: 400,
              hintText: "Email",
              onChanged: (value) {},
            ),
            RoundedButton(
              widthSize: 400,
              text: "Reset",
              press: () {
                // Navigator.pop(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return const Login();
                //     },
                //   ),
                // );
              },
            ),
          ])),
    );
  }
}
