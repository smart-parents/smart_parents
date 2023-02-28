// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class MyCarouselSlider extends StatefulWidget {
  const MyCarouselSlider({super.key});

  @override
  _MyCarouselSliderState createState() => _MyCarouselSliderState();
}

class _MyCarouselSliderState extends State<MyCarouselSlider> {
  late List<DateTime> dates;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    dates = List.generate(
      DateTime(now.year + 1, 0, 0).difference(DateTime(now.year, 0, 0)).inDays,
      (index) => DateTime(now.year, 1, 1).add(Duration(days: index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Schedule',
          style: GoogleFonts.oswald(fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Column(
          //ROW 1
          children: [
            Container(
              padding: const EdgeInsets.only(top: 55.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  // enlargeCenterPage: true,
                  // initialPage: 0,
                  // enableInfiniteScroll: false,
                  // autoPlay: false,
                  // autoPlayInterval: const Duration(seconds: 3),
                  // autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  // autoPlayCurve: Curves.fastOutSlowIn,
                  // enlargeFactor: 0.3,
                  height: MediaQuery.of(context).size.height * 0.20,
                  // scrollDirection: Axis.horizontal,
                  viewportFraction: 1 / 5,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
                items: dates.map((date) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Transform(
                            transform: Matrix4.rotationZ(-math.pi /
                                2), // rotate -90 degrees (i.e. clockwise)
                            child: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                                color: _selectedIndex == dates.indexOf(date)
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                              child: Text(
                                DateFormat('dd MMM').format(date),
                                style: GoogleFonts.oswald(
                                  fontSize: 20,
                                  fontWeight:
                                      _selectedIndex == dates.indexOf(date)
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.80,
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                color: Colors.white,
              ),
              child: Column(children: [
                Text(
                  "Selected date: ${DateFormat.yMMMMd().format(dates[_selectedIndex])}",
                  style: const TextStyle(fontSize: 18),
                ),
              ]),
            ),
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const AddParentPage(),
          //   ),
          // )
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
