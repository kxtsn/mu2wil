import 'package:flutter/material.dart';
import 'package:my_app/Screens/Student/CompanyTestimonial/getCompanyProfile.dart';
import 'package:my_app/Util/color.dart';

class CompanyDetailCards extends StatefulWidget {
  CompanyList companyList;
  CompanyDetailCards({Key? key, required this.companyList}) : super(key: key);

  @override
  State<CompanyDetailCards> createState() => _CompanyDetailCardsState();
}

class _CompanyDetailCardsState extends State<CompanyDetailCards> {
  @override
  Widget build(BuildContext context) {
    widget.companyList.firstName ??= "";
    widget.companyList.lastName ??= "";
    widget.companyList.email ??= "";
    widget.companyList.contact ??= "";
    widget.companyList.companyName ??= "";
    widget.companyList.telephone ??= "";
    widget.companyList.website ??= "";
    widget.companyList.country ??= "";
    widget.companyList.address1 ??= "";
    widget.companyList.address2 ??= "";
    widget.companyList.postal ??= "";
    widget.companyList.companyCode ??= "";
    return Container(
        child: Column(children: [
      const SizedBox(
        height: 20,
      ),
      Container(
          decoration: BoxDecoration(
            border: Border.all(color: darkGreyColor),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Company Name: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.companyList.companyName!),
                  const SizedBox(height: 5),
                  const Text("Company Code: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.companyList.companyCode!),
                  const SizedBox(height: 5),
                  const Text("Country: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.companyList.country!),
                  const SizedBox(height: 5),
                  const Text("Address: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.companyList.address1! +
                      "\n" +
                      widget.companyList.address2! +
                      "\n" +
                      widget.companyList.postal!),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Contact Person: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.companyList.firstName! +
                      " " +
                      widget.companyList.lastName!),
                  const SizedBox(height: 5),
                  const Text("Email: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.companyList.email!),
                  const SizedBox(height: 5),
                  const Text("Contact Number: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.companyList.contact!),
                  const SizedBox(height: 5),
                  const Text("Website: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.companyList.website ??= ""),
                  const SizedBox(height: 5),
                  const Text("Telephone: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.companyList.telephone!),
                ],
              )
            ],
          ))
    ]));
  }
}
