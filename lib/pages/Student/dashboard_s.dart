// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
    print(admin);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kPrimaryColor,
      // appBar: AppBar(
      //   // leading: const BackButton(),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: Text(
      //     'Schedule',
      //     style: GoogleFonts.oswald(fontSize: 30),
      //   ),
      //   centerTitle: true,
      // ),
      body: Column(children: [
        CarouselSlider(
          options: CarouselOptions(
            enlargeCenterPage: true,
            initialPage: _selectedIndex,
            enableInfiniteScroll: false,
            height: 150,
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
        Container(
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.all(0),
          height: MediaQuery.of(context).size.height * 0.80,
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            color: Colors.white,
          ),
          child: ListView(padding: EdgeInsets.zero, children: [
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
            )
          ]),
        ),
      ]),
    );
  }
}
