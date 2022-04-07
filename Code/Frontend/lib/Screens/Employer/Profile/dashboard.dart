import 'package:flutter/material.dart';
import 'package:my_app/Fields/header.dart';
import 'package:my_app/Screens/Employer/Listing/createListing.dart';
import 'package:my_app/Screens/Employer/Profile/getCompanyProfile.dart';
import 'package:my_app/Screens/Employer/Profile/profileCard.dart';
import 'package:http/http.dart' as http;

import 'listingRow.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool _isLoaded = false;
  CompanyList companyList = CompanyList();

  @override
  void initState() {
    super.initState();
    setState(() {
      getData();
    });
  }

  //getdata
  Future<void> getData() async {
    final results = await fetchCompanyDetails(http.Client());
    if (!_isLoaded) {
      setState(() {
        companyList = results[0];
        _isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(
                    title: 'Profile',
                  ),
                  const Flexible(
                      child: SizedBox(
                    width: 600,
                  )),
                  Header(
                    title: 'Create New Listing?',
                  ),
                ]),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CompanyDetailCards(
                        companyList: companyList,
                      ),
                      const SizedBox(height: 30),
                      Header(
                        title: 'Your Current Listing(s)',
                      ),
                      ListingRow()
                    ],
                  )),
              const SizedBox(width: 20),
              Expanded(flex: 3, child: AddListing()),
            ]),
          ],
        )));
  }
}
