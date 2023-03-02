// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import 'package:smart_parents/pages/Student/notice_s/notice_dash.dart';

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

    // Find the index of the current day
    final todayIndex = dates.indexWhere(
      (date) =>
          date.day == now.day &&
          date.month == now.month &&
          date.year == now.year,
    );

    // Set the initial selected index to the index of the current day
    _selectedIndex = todayIndex;
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
      body: Column(children: [
        Container(
          // padding: const EdgeInsets.only(top: 55.0),
          margin: const EdgeInsets.only(top: 50),
          child: CarouselSlider(
            options: CarouselOptions(
              enlargeCenterPage: true,
              initialPage:
                  _selectedIndex, // Set the initial page to the current day index
              enableInfiniteScroll: false,
              height: MediaQuery.of(context).size.height * 0.25,
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: _selectedIndex == dates.indexOf(date)
                              ? Colors.white
                              : Colors.grey,
                        ),
                        child: Transform.rotate(
                          angle: -math.pi / 2,
                          child: Text(
                            DateFormat('dd MMM').format(date),
                            style: GoogleFonts.rubik(
                              fontSize: 20,
                              fontWeight: _selectedIndex == dates.indexOf(date)
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
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.all(0),
          height: MediaQuery.of(context).size.height * 0.80,
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            color: Colors.white,
          ),
          child: ListView(
              padding: EdgeInsets.zero,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      DateFormat('E, dd MMM').format(dates[_selectedIndex]),
                      style: GoogleFonts.rubik(
                          fontSize: 30,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    const Icon(
                      Icons.calendar_today_outlined,
                      color: kPrimaryColor,
                      size: 40,
                    ),
                  ],
                ),
                // ListView(children: [
                //   Text(
                //     "Selected date: ${DateFormat.yMMMMd().format(dates[_selectedIndex])}",
                //     style: const TextStyle(fontSize: 18, color: kPrimaryColor),
                //   ),
                // ]),
              ]),
        ),
      ]),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => {
      //     // Navigator.push(
      //     //     context,
      //     //     MaterialPageRoute(
      //     //       builder: (context) => const AddParentPage(),
      //     //     ))
      //   },
      //   child: const Icon(Icons.edit),
      // ),
    );
  }
}
