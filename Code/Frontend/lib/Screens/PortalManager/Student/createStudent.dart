// ignore_for_file: file_names, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:my_app/Fields/header.dart';
import 'package:my_app/Fields/popUp.dart';
import 'package:my_app/Fields/roundedButton.dart';
import 'package:my_app/Fields/roundedInputField.dart';
import 'package:my_app/Screens/PortalManager/Student/view.dart';
import 'package:my_app/Screens/SuperAdmin/Admin/view.dart';
import 'package:my_app/Util/color.dart';
import 'getStudent.dart';
import 'package:my_app/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class AddStudent extends StatefulWidget {
  var student;
  AddStudent({Key? key, this.student}) : super(key: key);
  static Future<StudentList>? futureStudentList;
  @override
  State<AddStudent> createState() => _AddStudentListState();
}

class _AddStudentListState extends State<AddStudent> {
  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      fillFields();
    }
  }

  var murdochId, firstName, lastName, email;

  final _murdochIdTextController = TextEditingController();
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _emailTextController = TextEditingController();

  bool _filledId = false;
  bool _filledFirstName = false;
  bool _filledLastName = false;
  bool _filledEmail = false;
  bool _readOnly = false;
  String text = "Create New Student";

  bool validateField() {
    bool flag = true;
    if (murdochId == null) {
      flag = false;
    }
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
    if (widget.student != null) {
      _readOnly = true;
      text = "Update Student Details";
      _murdochIdTextController.text = (widget.student).murdochId.toString();
      murdochId = (widget.student).murdochId.toString();
      _firstNameTextController.text = (widget.student).firstName.toString();
      firstName = (widget.student).firstName.toString();
      _lastNameTextController.text = (widget.student).lastName.toString();
      lastName = (widget.student).lastName.toString();
      _emailTextController.text = (widget.student).email.toString();
      email = (widget.student).email.toString();
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
                                  textController: _murdochIdTextController,
                                  widthSize: changingWidth,
                                  hintText: "Murdoch Student ID",
                                  onChanged: (value) {
                                    murdochId = value;
                                  },
                                  errorText:
                                      _filledId ? 'field must be filled' : null,
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
                                  murdochId == null
                                      ? _filledId = true
                                      : _filledId = false;
                                });
                                // fields all filled

                                if (validateField() == true) {
                                  if (widget.student == null) {
                                    // student dont exist
                                    if (await commitCheck(email) == false) {
                                      // submit new student
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              PopUpWidget(context,
                                                  icon: Icons.check_circle,
                                                  iconColor: greenColor,
                                                  iconSize: 80,
                                                  title: 'Added New Student',
                                                  subTitle:
                                                      'Student $firstName $lastName will be added.',
                                                  onPressed: () async {
                                                await commitNew(murdochId,
                                                    firstName, lastName, email);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return ViewStudent();
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
                                    // student exist
                                  } else {
                                    // edit student details
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            PopUpWidget(context,
                                                icon: Icons.check_circle,
                                                iconColor: greenColor,
                                                iconSize: 80,
                                                title: 'Edit Student Details',
                                                subTitle:
                                                    'Student will be updated.',
                                                onPressed: () async {
                                              await commitUpdate(
                                                  widget.student.studentId
                                                      .toString(),
                                                  murdochId,
                                                  firstName,
                                                  lastName);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return ViewStudent();
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
                              _murdochIdTextController.clear();
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
