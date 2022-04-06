import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:my_app/Screens/Student/Listing/getListing.dart';
import 'package:my_app/Screens/Student/Listing/view.dart';
import 'package:my_app/Util/color.dart';

class CardTile extends StatelessWidget {
  ListingList list;
  CardTile({Key? key, required this.list}) : super(key: key);

  Widget getText(String applied) {
    if (applied == "true") {
      return const Text(
        "Applied",
        style: TextStyle(
          color: greenColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return const Text("");
    }
  }

  bool getBool(String applied) {
    if (applied == "true") {
      return true;
    } else {
      return false;
    }
  }

  String formatDisplayDate(String date) {
    if (date != "") {
      date = DateFormat("dd MMM yyyy").format(DateTime.parse(date)).toString();
    } else {
      date = "";
    }
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Stack(children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: Stack(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      list.title!.toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text("Current number of applicants: " +
                                        list.applicants!.toString()),
                                    const SizedBox(height: 5),
                                    Text("Closing Date: " +
                                        formatDisplayDate(
                                            list.closingDate!.toString())),
                                    const SizedBox(height: 10),
                                    Text(list.description!),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Visibility(
                                  child: getText(list.applied!),
                                  visible: getBool(list.applied!),
                                ),
                                Visibility(
                                  child: TextButton(
                                    child: const Text('APPLY'),
                                    onPressed: () async {
                                      await createApplication(
                                          list.listingId.toString());
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const ViewListing();
                                          },
                                        ),
                                      );
                                      Fluttertoast.showToast(
                                          msg: "Listing Applied.",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 3,
                                          backgroundColor: Colors.white,
                                          textColor: Colors.black,
                                          fontSize: 16.0);
                                    },
                                  ),
                                  visible: !getBool(list.applied!),
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
              )
            ]),
          ),
        ));
  }
}
