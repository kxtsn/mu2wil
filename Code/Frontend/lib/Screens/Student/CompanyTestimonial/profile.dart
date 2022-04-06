import 'package:flutter/material.dart';
import 'package:my_app/Util/color.dart';

class CompanyDetailCards extends StatefulWidget {
  var companyLists;
  CompanyDetailCards({Key? key, this.companyLists}) : super(key: key);

  @override
  State<CompanyDetailCards> createState() => _CompanyDetailCardsState();
}

class _CompanyDetailCardsState extends State<CompanyDetailCards> {
  @override
  Widget build(BuildContext context) {
    widget.companyLists[0].firstName ??= "";
    widget.companyLists[0].lastName ??= "";
    widget.companyLists[0].email ??= "";
    widget.companyLists[0].contact ??= "";
    widget.companyLists[0].companyName ??= "";
    widget.companyLists[0].telephone ??= "";
    widget.companyLists[0].website ??= "";
    widget.companyLists[0].country ??= "";
    widget.companyLists[0].address1 ??= "";
    widget.companyLists[0].address2 ??= "";
    widget.companyLists[0].postal ??= "";
    widget.companyLists[0].companyCode ??= "";
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
                  Text(widget.companyLists[0].companyName!),
                  const SizedBox(height: 5),
                  const Text("Company Code: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.companyLists[0].companyCode!),
                  const SizedBox(height: 5),
                  const Text("Country: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.companyLists[0].country!),
                  const SizedBox(height: 5),
                  const Text("Address: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.companyLists[0].address1! +
                      "\n" +
                      widget.companyLists[0].address2! +
                      "\n" +
                      widget.companyLists[0].postal!),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Contact Person: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.companyLists[0].firstName! +
                      " " +
                      widget.companyLists[0].lastName!),
                  const SizedBox(height: 5),
                  const Text("Email: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.companyLists[0].email!),
                  const SizedBox(height: 5),
                  const Text("Contact Number: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.companyLists[0].contact!),
                  const SizedBox(height: 5),
                  const Text("Website: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.companyLists[0].website ??= ""),
                  const SizedBox(height: 5),
                  const Text("Telephone: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.companyLists[0].telephone!),
                ],
              )
            ],
          ))
    ]));
  }
}
