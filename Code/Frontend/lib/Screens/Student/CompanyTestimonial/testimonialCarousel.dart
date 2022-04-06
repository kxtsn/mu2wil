// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, must_be_immutable
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_app/Fields/listingCard.dart';
import 'package:my_app/Fields/popUp.dart';
import 'package:my_app/Fields/roundedButton.dart';
import 'package:my_app/Fields/empTestimonialCard.dart';
import 'package:my_app/Screens/Student/CompanyTestimonial/getTestimonial.dart';
import 'package:my_app/main.dart';
import 'package:my_app/util/color.dart';
import 'package:my_app/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:my_app/Fields/search.dart';

class TestimonialCarousel extends StatefulWidget {
  bool isLoaded = false;
  List<TestimonialList> testimonialLists;
  TestimonialCarousel({Key? key, required this.testimonialLists})
      : super(key: key);

  @override
  _TestimonialCarouselState createState() => _TestimonialCarouselState();

  static sort(String Function(TestimonialCarousel d) param0, int columnIndex,
      bool ascending) {}
}

class _TestimonialCarouselState extends State<TestimonialCarousel> {
  bool isLoaded = false;
  int? _sortColumnIndex;
  bool _sortAscending = true;

  String query = "";
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 500,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: true,
          ),
          items: widget.testimonialLists.map((testimonialList) {
            return Builder(builder: (BuildContext context) {
              return Container(
                child: TestimonialCardTile(testimonial: testimonialList),
              );
            });
          }).toList(),
        ),
      ],
    ));
  }
}
