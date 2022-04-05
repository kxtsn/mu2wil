import 'package:flutter/material.dart';
import 'package:my_app/Screens/Employer/Application/getApplication.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/Screens/Employer/Application/view.dart';
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

  bool getBool(String status) {
    bool flag = true;
    if (status == "Matched" || status == "Failed") {
      flag = false;
    }

    return flag;
  }

  bool getWriteTestimonial(String status) {
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CircleAvatar(
                                      radius:
                                          50, //we give the image a radius of 50
                                      backgroundImage: NetworkImage(
                                          'https://webstockreview.net/images/male-clipart-professional-man-3.jpg'),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      applicant.firstName! +
                                          " " +
                                          applicant.lastName!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(applicant.email!),
                                  ],
                                ),
                                const SizedBox(width: 32),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'APPLIED FOR ' +
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
                                    child: const Text('ACCEPT'),
                                    onPressed: () async {
                                      await acceptApplication(
                                          applicant.applicationId.toString());
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return ViewApplication();
                                          },
                                        ),
                                      );
                                      Fluttertoast.showToast(
                                          msg: "Accepted Student.",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 3,
                                          backgroundColor: Colors.white,
                                          textColor: Colors.black,
                                          fontSize: 16.0);
                                    },
                                  ),
                                  visible: getBool(applicant.status!),
                                ),
                                const SizedBox(width: 8),
                                Visibility(
                                  child: TextButton(
                                    child: const Text('REJECT'),
                                    onPressed: () async {
                                      await rejectApplication(
                                          applicant.applicationId.toString());
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return ViewApplication();
                                          },
                                        ),
                                      );
                                      Fluttertoast.showToast(
                                          msg: "Rejected Student.",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 3,
                                          backgroundColor: Colors.white,
                                          textColor: Colors.black,
                                          fontSize: 16.0);
                                    },
                                  ),
                                  visible: getBool(applicant.status!),
                                ),
                                Visibility(
                                  child: TextButton(
                                    child: const Text('WRITE TESTIMONIAL'),
                                    onPressed: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) {
                                      //       return ViewApplication();
                                      //     },
                                      //   ),
                                      // );
                                    },
                                  ),
                                  visible:
                                      getWriteTestimonial(applicant.status!),
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
