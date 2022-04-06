import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/Fields/testimonialPopUp.dart';
import 'package:my_app/Screens/Student/Profile/view.dart';
import 'package:my_app/Screens/Student/Application/getApplication.dart';
import 'package:my_app/Util/color.dart';

class CardTile extends StatelessWidget {
  ApplicationList applicant;
  CardTile({Key? key, required this.applicant}) : super(key: key);

  Color getColor(String status) {
    Color color = Colors.black;
    // approved
    if (status == "Matched") {
      color = greenColor;
    }
    // pending
    if (status == "Failed") {
      color = redColor;
    }
    // draft
    if (status == "Pending") {
      color = Colors.yellow.shade800;
    }
    return color;
  }

  bool getCancelFlag(String status) {
    bool flag = false;

    if (status == "Pending") {
      flag = true;
    }

    return flag;
  }

  bool getTestFlag(String status) {
    bool flag = false;

    if (status == "Matched") {
      flag = true;
    }

    return flag;
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
                                      applicant.title!.toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(applicant.description!),
                                  ],
                                ),
                                const SizedBox(width: 32),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      applicant.status!.toUpperCase(),
                                      style: TextStyle(
                                        color: getColor(applicant.status!),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Visibility(
                                  child: TextButton(
                                    child: const Text('CANCEL APPLICATION'),
                                    onPressed: () async {
                                      await cancelApplication(
                                          applicant.applicationId.toString());
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return ViewProfile();
                                          },
                                        ),
                                      );
                                      Fluttertoast.showToast(
                                          msg: "Cancelled Application.",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 3,
                                          backgroundColor: Colors.white,
                                          textColor: Colors.black,
                                          fontSize: 16.0);
                                    },
                                  ),
                                  visible: getCancelFlag(applicant.status!),
                                ),
                                const SizedBox(width: 8),
                                Visibility(
                                  child: TextButton(
                                    child: const Text('WRITE TESTIMONIAL'),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              TestimonialPopUp(context,
                                                  listing: applicant));
                                    },
                                  ),
                                  visible: getTestFlag(applicant.status!),
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
