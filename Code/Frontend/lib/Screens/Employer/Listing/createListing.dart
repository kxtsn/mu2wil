// ignore_for_file: file_names, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:intl/intl.dart';
import 'package:my_app/Fields/header.dart';
import 'package:my_app/Fields/popUp.dart';
import 'package:my_app/Fields/roundedButton.dart';
import 'package:my_app/Fields/roundedInputField.dart';
import 'package:my_app/Screens/Employer/Listing/view.dart';
import 'package:my_app/Util/color.dart';
import 'getListing.dart';
import 'package:my_app/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class AddListing extends StatefulWidget {
  var listing;
  AddListing({Key? key, this.listing}) : super(key: key);
  static Future<ListingList>? futureListingList;
  @override
  State<AddListing> createState() => _AddListingListState();
}

class _AddListingListState extends State<AddListing> {
  @override
  void initState() {
    super.initState();
    if (widget.listing != null) {
      fillFields();
    }
  }

  var title, description, slots, closingDate;

  final _titleTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  final _slotsTextController = TextEditingController();
  final _closingDateTextController = TextEditingController();

  bool _filledTitle = false;
  bool _filledDescription = false;
  bool _filledSlot = false;
  bool _filledClosing = false;
  String text = "Create New Listing";

  bool validateField() {
    bool flag = true;
    if (title == null) {
      flag = false;
    }
    if (description == null) {
      flag = false;
    }
    if (slots == null) {
      flag = false;
    }
    if (closingDate == null) {
      flag = false;
    }
    return flag;
  }

  String formatDisplayDate(String date) {
    if (date != "") {
      date = DateFormat("dd MMM yyyy").format(DateTime.parse(date)).toString();
    } else {
      date = "";
    }
    return date;
  }

  void fillFields() {
    if (widget.listing != null) {
      text = "Update Listing Details";
      _titleTextController.text = (widget.listing).title.toString();
      title = (widget.listing).title.toString();
      _descriptionTextController.text = (widget.listing).description.toString();
      description = (widget.listing).description.toString();
      _slotsTextController.text = (widget.listing).slot.toString();
      slots = (widget.listing).slot.toString();
      _closingDateTextController.text =
          formatDisplayDate(widget.listing.closingDate.toString());
      closingDate = widget.listing.closingDate.toString();
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
              padding: const EdgeInsets.all(15),
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
                                  textController: _titleTextController,
                                  widthSize: changingWidth,
                                  hintText: "Title",
                                  onChanged: (value) {
                                    title = value;
                                  },
                                  errorText: _filledTitle
                                      ? 'field must be filled'
                                      : null,
                                ),
                                TextField(
                                  keyboardType: TextInputType.multiline,
                                  controller: _descriptionTextController,
                                  // widthSize: changingWidth,
                                  decoration: InputDecoration(
                                    hintText: "Description",
                                    errorText: _filledDescription
                                        ? 'field must be filled'
                                        : null,
                                  ),
                                  onChanged: (value) {
                                    description = value;
                                  },
                                ),
                                //set validation on field
                                RoundedInputField(
                                  textController: _slotsTextController,
                                  widthSize: changingWidth,
                                  hintText: "Available Slots",
                                  onChanged: (value) {
                                    slots = value;
                                    _slotsTextController.text = value;
                                  },
                                  errorText: _filledSlot
                                      ? 'field must be filled'
                                      : null,
                                ),
                                RoundedInputField(
                                  textController: _closingDateTextController,
                                  widthSize: changingWidth,
                                  hintText: "Select Date",
                                  labelText: "Listing Closing Date",
                                  readOnly: true,
                                  onClick: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now()
                                            .add(const Duration(days: 15)),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2030));

                                    if (pickedDate != null) {
                                      String formattedDate =
                                          DateFormat('dd-MMM-yyyy')
                                              .format(pickedDate);

                                      setState(() {
                                        _closingDateTextController.text =
                                            formattedDate;
                                        closingDate = formattedDate;
                                      });
                                    }
                                  },
                                  errorText: _filledClosing
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
                                  title == null
                                      ? _filledTitle = true
                                      : _filledTitle = false;
                                  description == null
                                      ? _filledDescription = true
                                      : _filledDescription = false;
                                  slots == null
                                      ? _filledSlot = true
                                      : _filledSlot = false;
                                  closingDate == null
                                      ? _filledClosing = true
                                      : _filledClosing = false;
                                });
                                // fields all filled

                                if (validateField() == true) {
                                  if (widget.listing == null) {
                                    // submit new listing
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            PopUpWidget(context,
                                                icon: Icons.check_circle,
                                                iconColor: greenColor,
                                                iconSize: 80,
                                                title: 'Added New Listing',
                                                subTitle:
                                                    'Listing for $title will be added.',
                                                onPressed: () async {
                                              await commitNew(
                                                  title,
                                                  description,
                                                  closingDate.toString(),
                                                  slots);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return ViewListing();
                                                  },
                                                ),
                                              );
                                            }));
                                  } else {
                                    // edit listing details
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            PopUpWidget(context,
                                                icon: Icons.check_circle,
                                                iconColor: greenColor,
                                                iconSize: 80,
                                                title: 'Edit Listing Details',
                                                subTitle:
                                                    'Listing $title will be updated.',
                                                onPressed: () async {
                                              await commitUpdate(
                                                  widget.listing.listingId
                                                      .toString(),
                                                  title,
                                                  description,
                                                  closingDate.toString(),
                                                  slots);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return ViewListing();
                                                  },
                                                ),
                                              );
                                            }));
                                  }

                                  //fields not filled
                                }
                              }),
                          RoundedButton(
                            widthSize: changingWidth,
                            text: "Clear",
                            color: primaryColor,
                            press: () {
                              _titleTextController.clear();
                              _descriptionTextController.clear();
                              _slotsTextController.clear();
                              _closingDateTextController.clear();
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
