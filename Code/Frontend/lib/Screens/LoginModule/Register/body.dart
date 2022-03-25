import 'package:flutter/services.dart';
import 'package:my_app/Fields/popUp.dart';
import 'package:my_app/Fields/roundedButton.dart';
import 'package:my_app/Fields/roundedInputField.dart';
import 'package:my_app/Screens/LoginModule/Login/background.dart';
import 'package:my_app/Screens/LoginModule/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Util/color.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var firstName,
      lastName,
      email,
      contact,
      companyName,
      telephone,
      website,
      country,
      address1,
      address2,
      postal,
      companyCode;

  final _companyTextController = TextEditingController();
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _contactTextController = TextEditingController();
  final _telTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _websiteTextController = TextEditingController();
  final _address1TextController = TextEditingController();
  final _address2TextController = TextEditingController();
  final _postalTextController = TextEditingController();
  final _countryTextController = TextEditingController();
  final _codeTextController = TextEditingController();

  bool _filledCompany = false;
  bool _filledFirstName = false;
  bool _filledLastName = false;
  bool _filledContact = false;
  bool _filledTel = false;
  bool _filledEmail = false;
  bool _filledAddress1 = false;
  bool _filledAddress2 = false;
  bool _filledPostal = false;
  bool _filledCountry = false;
  bool _filledCode = false;

  bool validateField() {
    bool flag = true;
    if (companyName == null) {
      flag = false;
    }
    if (firstName == null) {
      flag = false;
    }
    if (lastName == null) {
      flag = false;
    }
    if (contact == null) {
      flag = false;
    }
    if (telephone == null) {
      flag = false;
    }
    if (email == null) {
      flag = false;
    }
    if (address1 == null) {
      flag = false;
    }
    if (address2 == null) {
      flag = false;
    }
    if (postal == null) {
      flag = false;
    }
    if (country == null) {
      flag = false;
    }
    if (companyCode == null) {
      flag = false;
    }
    return flag;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 20,
      ),
      const Center(
        child: Image(
            image: AssetImage("../../../../images/murdoch_logo.png"),
            width: 350),
      ),
      const SizedBox(
        height: 30,
      ),
      const Center(
          child: Text(
        "Register Your Company With Us Today",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: blackColor,
            fontSize: 20,
            decoration: TextDecoration.underline),
      )),
      const SizedBox(
        height: 30,
      ),
      Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Column(children: [
                  Text(
                    "Company Details",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: size.height * 0.01),
                  RoundedInputField(
                    textController: _companyTextController,
                    widthSize: 350,
                    hintText: "Company Name",
                    onChanged: (value) {
                      companyName = value;
                    },
                    errorText: _filledCompany ? 'field must be filled' : null,
                  ),
                  RoundedInputField(
                    textController: _countryTextController,
                    widthSize: 350,
                    hintText: "Country",
                    onChanged: (value) {
                      country = value;
                    },
                    errorText: _filledCountry ? 'field must be filled' : null,
                  ),
                  RoundedInputField(
                    textController: _codeTextController,
                    widthSize: 350,
                    hintText: "Company Code",
                    onChanged: (value) {
                      companyCode = value;
                    },
                    errorText: _filledCode ? 'field must be filled' : null,
                  ),
                  RoundedInputField(
                    textController: _telTextController,
                    widthSize: 350,
                    hintText: "Telephone",
                    onChanged: (value) {
                      telephone = value;
                    },
                    errorText: _filledTel ? 'field must be filled' : null,
                  ),
                  RoundedInputField(
                    textController: _websiteTextController,
                    widthSize: 350,
                    hintText: "Website",
                    onChanged: (value) {
                      website = value;
                    },
                  ),
                  RoundedInputField(
                    textController: _address1TextController,
                    widthSize: 350,
                    hintText: "Address Line 1",
                    onChanged: (value) {
                      address1 = value;
                    },
                    errorText: _filledAddress1 ? 'field must be filled' : null,
                  ),
                  RoundedInputField(
                    textController: _address2TextController,
                    widthSize: 350,
                    hintText: "Address Line 2",
                    onChanged: (value) {
                      address2 = value;
                    },
                    errorText: _filledAddress2 ? 'field must be filled' : null,
                  ),
                  RoundedInputField(
                    textController: _postalTextController,
                    widthSize: 350,
                    hintText: "Postal Code",
                    onChanged: (value) {
                      postal = value;
                    },
                    errorText: _filledPostal ? 'field must be filled' : null,
                  ),
                ]),
              ),
              const SizedBox(
                width: 30,
              ),
              Flexible(
                flex: 1,
                child: SecondColumn(context),
              ),
            ]),
      ),
      const SizedBox(height: 10),
      //Buttons
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        RoundedButton(
          widthSize: 250,
          text: "Back",
          color: darkGreyColor,
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const Login();
                },
              ),
            );
          },
        ),
        const SizedBox(width: 10),
        RoundedButton(
          widthSize: 250,
          text: "Clear",
          color: primaryColor,
          press: () {
            _companyTextController.clear();
            _firstNameTextController.clear();
            _lastNameTextController.clear();
            _contactTextController.clear();
            _telTextController.clear();
            _websiteTextController.clear();
            _emailTextController.clear();
            _countryTextController.clear();
            _address1TextController.clear();
            _address2TextController.clear();
            _postalTextController.clear();
            _codeTextController.clear();
          },
        ),
        const SizedBox(width: 10),
        RoundedButton(
            widthSize: 250,
            text: "Submit",
            color: primaryColor,
            press: () async {
              setState(() {
                companyName == null
                    ? _filledCompany = true
                    : _filledCompany = false;
                firstName == null
                    ? _filledFirstName = true
                    : _filledFirstName = false;
                lastName == null
                    ? _filledLastName = true
                    : _filledLastName = false;
                contact == null
                    ? _filledContact = true
                    : _filledContact = false;
                telephone == null ? _filledTel = true : _filledTel = false;
                email == null ? _filledEmail = true : _filledEmail = false;
                country == null
                    ? _filledCountry = true
                    : _filledCountry = false;
                address1 == null
                    ? _filledAddress1 = true
                    : _filledAddress1 = false;
                address2 == null
                    ? _filledAddress2 = true
                    : _filledAddress2 = false;
                postal == null ? _filledPostal = true : _filledPostal = false;
                companyCode == null ? _filledCode = true : _filledCode = false;
              });
              if (validateField() == true) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => PopUpWidget(context,
                            icon: Icons.check_circle,
                            iconColor: greenColor,
                            iconSize: 80,
                            title: 'Register Company',
                            subTitle:
                                '$companyName will be registered upon confirmation by the school\'s management. \n An email will be sent with an account password alongside the registration.',
                            onPressed: () async {
                          // registerCompany(
                          //     companyName,
                          //     firstName,
                          //     lastName,
                          //     contact,
                          //     telephone,
                          //     email,
                          //     address1,
                          //     address2,
                          //     postal,
                          //     country,
                          //     companyCode);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const Login();
                              },
                            ),
                          );
                        }));
              }
            }),
      ])
    ])));
  }

  Column SecondColumn(BuildContext context) {
    return Column(
      children: [
        Text(
          "Contact Person Details",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        RoundedInputField(
          textController: _firstNameTextController,
          widthSize: 350,
          hintText: "Contact Person First Name",
          onChanged: (value) {
            firstName = value;
          },
          errorText: _filledFirstName ? 'field must be filled' : null,
        ),
        RoundedInputField(
          textController: _lastNameTextController,
          widthSize: 350,
          hintText: "Contact Person Last Name",
          onChanged: (value) {
            lastName = value;
          },
          errorText: _filledLastName ? 'field must be filled' : null,
        ),
        RoundedInputField(
          textController: _contactTextController,
          widthSize: 350,
          hintText: "Mobile Number",
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
          ],
          onChanged: (value) {
            contact = value;
          },
          errorText: _filledContact ? 'field must be filled' : null,
        ),
        RoundedInputField(
          textController: _emailTextController,
          widthSize: 350,
          hintText: "Email",
          onChanged: (value) {
            email = value;
          },
          errorText: _filledEmail ? 'field must be filled' : null,
        ),
      ],
    );
  }
}
