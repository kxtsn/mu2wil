// ignore_for_file: file_names, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:my_app/Fields/popUp.dart';
import 'package:my_app/Fields/roundedButton.dart';
import 'package:my_app/Fields/roundedInputField.dart';
import 'package:my_app/Screens/SuperAdmin/PortalManager/view.dart';
import 'package:my_app/Util/color.dart';
import 'getManager.dart';
import 'package:my_app/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class AddManager extends StatefulWidget {
  var manager;
  AddManager({Key? key, this.manager}) : super(key: key);
  static Future<ManagerList>? futureManagerList;
  @override
  State<AddManager> createState() => _AddManagerListState();
}

class _AddManagerListState extends State<AddManager> {
  @override
  void initState() {
    super.initState();
    if (widget.manager != null) {
      fillFields();
    }
  }

  var firstName, lastName, email;

  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _emailTextController = TextEditingController();

  bool _filledFirstName = false;
  bool _filledLastName = false;
  bool _filledEmail = false;
  bool _readOnly = false;
  String text = "Create New Portal Manager";

  bool validateField() {
    bool flag = true;
    if (firstName == null) {
      flag = false;
    }
    if (lastName == null) {
      flag = false;
    }
    if (email == null) {
      flag = false;
    }
    return flag;
  }

  void fillFields() {
    if (widget.manager != null) {
      _readOnly = true;
      text = "Update Portal Manager Details";
      _firstNameTextController.text = (widget.manager).firstName.toString();
      firstName = (widget.manager).firstName.toString();
      _lastNameTextController.text = (widget.manager).lastName.toString();
      lastName = (widget.manager).lastName.toString();
      _emailTextController.text = (widget.manager).email.toString();
      email = (widget.manager).email.toString();
    }
  }

  double changingWidth = 450;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (ResponsiveWidget.isSmallScreen(context)) {
      changingWidth = 250;
    }
    return Container(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
              decoration: BoxDecoration(
                border: Border.all(color: darkGreyColor),
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(text,
                                    style: TextStyle(color: blackColor),
                                    textAlign: TextAlign.left),
                                SizedBox(height: size.height * 0.01),
                                RoundedInputField(
                                  textController: _firstNameTextController,
                                  widthSize: changingWidth,
                                  hintText: "First Name",
                                  onChanged: (value) {
                                    firstName = value;
                                  },
                                  errorText: _filledFirstName
                                      ? 'field must be filled'
                                      : null,
                                ),
                                RoundedInputField(
                                  textController: _lastNameTextController,
                                  widthSize: changingWidth,
                                  hintText: "Last Name",
                                  onChanged: (value) {
                                    lastName = value;
                                  },
                                  errorText: _filledLastName
                                      ? 'field must be filled'
                                      : null,
                                ),
                                RoundedInputField(
                                  textController: _emailTextController,
                                  widthSize: changingWidth,
                                  hintText: "Email",
                                  readOnly: _readOnly,
                                  onChanged: (value) {
                                    email = value;
                                  },
                                  errorText: _filledEmail
                                      ? 'field must be filled'
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        ]),

                    //Buttons
                    Center(
                      child: Column(
                        children: [
                          RoundedButton(
                              widthSize: changingWidth,
                              text: "Submit",
                              color: primaryColor,
                              press: () async {
                                setState(() {
                                  firstName == null
                                      ? _filledFirstName = true
                                      : _filledFirstName = false;
                                  lastName == null
                                      ? _filledLastName = true
                                      : _filledLastName = false;
                                  email == null
                                      ? _filledEmail = true
                                      : _filledEmail = false;
                                });
                                // fields all filled

                                if (validateField() == true) {
                                  if (widget.manager == null) {
                                    // manager dont exist
                                    if (await commitCheck(email) == false) {
                                      // submit new manager
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              PopUpWidget(context,
                                                  icon: Icons.check_circle,
                                                  iconColor: greenColor,
                                                  iconSize: 80,
                                                  title:
                                                      'Added New Portal Manager',
                                                  subTitle:
                                                      'Portal Manager $firstName $lastName will be added.',
                                                  onPressed: () async {
                                                await commitNew(
                                                    firstName, lastName, email);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return ViewManager();
                                                    },
                                                  ),
                                                );
                                              }));
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              PopUpWidget(context,
                                                  icon: Icons.cancel,
                                                  iconColor: redColor,
                                                  iconSize: 80,
                                                  setConfirmBtn: false,
                                                  title:
                                                      'Email exist please enter another email',
                                                  subTitle:
                                                      'Email ($email) already exist in the system.',
                                                  onPressed: () {}));
                                    }
                                    // manager exist
                                  } else {
                                    // edit manager details
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            PopUpWidget(context,
                                                icon: Icons.check_circle,
                                                iconColor: greenColor,
                                                iconSize: 80,
                                                title:
                                                    'Edit Portal Manager Details',
                                                subTitle:
                                                    'Portal Manager will be updated.',
                                                onPressed: () async {
                                              await commitUpdate(
                                                  widget.manager.managerId
                                                      .toString(),
                                                  firstName,
                                                  lastName);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return ViewManager();
                                                  },
                                                ),
                                              );
                                            }));
                                  }
                                }
                                //fields not filled
                              }),
                          RoundedButton(
                            widthSize: changingWidth,
                            text: "Clear",
                            color: primaryColor,
                            press: () {
                              _firstNameTextController.clear();
                              _lastNameTextController.clear();
                              _emailTextController.clear();
                            },
                          ),
                        ],
                      ),
                    )
                  ]))
        ],
      ),
    );
  }
}
