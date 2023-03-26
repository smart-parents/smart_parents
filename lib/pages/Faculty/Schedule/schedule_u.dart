// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'package:smart_parents/pages/Faculty/Schedule/addschedule.dart';
import 'package:smart_parents/pages/Faculty/Schedule/editSchedule.dart';

var semester = 1;

class ShowSchedule extends StatefulWidget {
  const ShowSchedule({super.key});

  @override
  _ShowScheduleState createState() => _ShowScheduleState();
}

class _ShowScheduleState extends State<ShowSchedule> {
  late List<DateTime> dates;
  int _selectedIndex = 0;
  final _service = TimetableService();
  var _selectedDay;
  @override
  void initState() {
    super.initState();
    // focusNode.requestFocus();
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
    _selectedDay = DateFormat('EEEE').format(dates[_selectedIndex]);
    print(_selectedDay);
  }

  void _showNumberPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select a Semester'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildNumberButton(1),
              _buildNumberButton(2),
              _buildNumberButton(3),
              _buildNumberButton(4),
              _buildNumberButton(5),
              _buildNumberButton(6),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNumberButton(int number) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            semester = number;
          });
          Navigator.of(context).pop();
        },
        child: Text('$number'),
      ),
    );
  }

  // FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
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
        // actions: [
        //   TextButton.icon(
        //     icon: CircleAvatar(
        //       radius: 15,
        //       backgroundColor: Colors.white,
        //       foregroundColor: kPrimaryColor,
        //       child: Text(
        //         semester.toString(),
        //         style: GoogleFonts.rubik(
        //           fontWeight: FontWeight.bold,
        //           // fontSize: 20,
        //         ),
        //       ),
        //     ),
        //     // const Icon(Icons.filter_list),
        //     onPressed: () {
        //       _showNumberPicker(context);
        //     },
        //     label: Text(
        //       'Sem',
        //       style: GoogleFonts.rubik(
        //           // fontSize: 20,
        //           fontWeight: FontWeight.bold,
        //           color: Colors.white),
        //     ),
        //   ),
        // ],
      ),
      body: Column(children: [
        CarouselSlider(
          options: CarouselOptions(
            enlargeCenterPage: true,
            initialPage:
                _selectedIndex, // Set the initial page to the current day index
            enableInfiniteScroll: false,
            // height: MediaQuery.of(context).size.height * 0.25,
            height: 145,
            viewportFraction: 1 / 5,
            onPageChanged: (index, reason) {
              setState(() {
                _selectedIndex = index;
                _selectedDay = DateFormat('EEEE').format(dates[_selectedIndex]);
                print(_selectedDay);
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
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.all(0),
            // height: MediaQuery.of(context).size.height,
            //  * 0.80,
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(
              // borderRadius: BorderRadius.circular(80),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(80),
                topRight: Radius.circular(80),
                bottomLeft: Radius.zero,
                bottomRight: Radius.zero,
              ),
              color: Colors.white,
            ),
            child: Column(
                // padding: EdgeInsets.zero,
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
                      // const Icon(
                      //   Icons.calendar_month_outlined,
                      //   color: kPrimaryColor,
                      //   size: 40,
                      // ),
                      GestureDetector(
                        child: TextButton.icon(
                          label: Text(
                            'Sem',
                            style: GoogleFonts.rubik(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          icon: CircleAvatar(
                            // radius: 15,
                            foregroundColor: Colors.white,
                            backgroundColor: kPrimaryColor,
                            child: Text(
                              semester.toString(),
                              style: GoogleFonts.rubik(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          // const Icon(Icons.filter_list),
                          onPressed: () {
                            _showNumberPicker(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: StreamBuilder<List<TimetableEntry>>(
                      stream: _service.getTimetableStream(_selectedDay),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(
                            child: Text('No lectures added for $_selectedDay'),
                          );
                        }
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final entry = snapshot.data![index];
                            return
                                // Padding(
                                //   padding: const EdgeInsets.all(
                                //       20.0), // Set the margin to 20 pixels on all sides
                                //   child:
                                //   Card(
                                // shape: RoundedRectangleBorder(
                                //   side: const BorderSide(
                                //     // color: Colors.black,
                                //     width: 1.0,
                                //   ),
                                //   borderRadius: BorderRadius.circular(
                                //       10.0), // Set the border radius
                                // ),
                                // margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                // child:
                                Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditSchedule(
                                                  doc: entry.doc,
                                                  semester: semester.toString(),
                                                  end: entry.endTime,
                                                  start: entry.startTime,
                                                  subject: entry.subject,
                                                  type: entry.type,
                                                  day: _selectedDay,
                                                )))
                                  },
                                  onLongPress: () async {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Confirm Delete"),
                                          content: const Text(
                                              "Are you sure you want to delete this Schedule?"),
                                          actions: [
                                            TextButton(
                                              child: const Text("Cancel"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: const Text("Delete"),
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection('Admin')
                                                    .doc(admin)
                                                    .collection('schedule')
                                                    .doc('${branch}_$semester')
                                                    .collection('timetable')
                                                    .doc(_selectedDay)
                                                    .collection('entries')
                                                    .doc(entry.doc)
                                                    .delete()
                                                    .then((value) => print(
                                                        'Schedule Deleted'))
                                                    .catchError((error) => print(
                                                        'Failed to Delete Schedule: $error'));
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      //   ListTile(
                                      // title:
                                      Text(
                                        '${entry.startTime}\n${entry.endTime}',
                                        style: GoogleFonts.rubik(
                                            fontSize: 15,
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // subtitle:
                                      // Text(
                                      //   entry.doc,
                                      //   style: GoogleFonts.rubik(
                                      //       fontSize: 15,
                                      //       color: kPrimaryColor,
                                      //       fontWeight: FontWeight.bold),
                                      // ),
                                      Container(
                                        // width: MediaQuery.of(context).size.width *
                                        //     0.40,
                                        // height: 40,
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: kPrimaryLightColor,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "${entry.subject} ${entry.type}",
                                            style: GoogleFonts.rubik(
                                                fontSize: 20,
                                                color: kPrimaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                    // ),
                                    // ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                )
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  // ListView(children: [
                  //   Text(
                  //     "Selected date: ${DateFormat.yMMMMd().format(dates[_selectedIndex])}",
                  //     style: const TextStyle(fontSize: 18, color: kPrimaryColor),
                  //   ),
                  // ]),
                ]),
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          // IconButton(
          //   icon: const Icon(
          //     Icons.add,
          //     size: 30,
          //   ),
          //   onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddSchedule())),
          //   },
          //   tooltip: 'Add',
          // ),
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TimetableEntry {
  final String subject;
  final String startTime;
  final String endTime;
  final String type;
  final String doc;

  TimetableEntry(
      {required this.doc,
      required this.type,
      required this.subject,
      required this.startTime,
      required this.endTime});
}

class TimetableService {
  // final String collegeId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // TimetableService({required this.collegeId});

  Stream<List<TimetableEntry>> getTimetableStream(String day) {
    return _firestore
        .collection('Admin')
        .doc(admin)
        .collection('schedule')
        .doc('${branch}_$semester')
        .collection('timetable')
        .doc(day)
        .collection('entries')
        .orderBy('start24')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return TimetableEntry(
            doc: doc.id,
            subject: data['subject'],
            startTime: data['startTime'],
            endTime: data['endTime'],
            type: data['type']);
      }).toList();
    });
  }

  Future<void> deleteSchedule(id, String day) async {
    await FirebaseFirestore.instance
        .collection('Admin')
        .doc(admin)
        .collection('schedule')
        .doc('${branch}_$semester')
        // .doc('${branch}_${semesterdropdownValue}_$daysdropdownValue')
        .collection('timetable')
        .doc(day)
        .collection('entries')
        .doc(id)
        .delete()
        .then((value) => print('Schedule Deleted'))
        .catchError((error) => print('Failed to Delete Schedule: $error'));
  }
  // Future<void> addTimetableEntry(String day, TimetableEntry entry) async {
  //   await _firestore
  //       .collection('Admin')
  //       .doc(admin)
  //       .collection('timetable')
  //       .doc(day)
  //       .collection('entries')
  //       .add({
  //     'subject': entry.subject,
  //     'startTime': entry.startTime,
  //     'endTime': entry.endTime,
  //   });
  // }
}
