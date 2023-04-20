// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceCalendarPage extends StatefulWidget {
  const AttendanceCalendarPage({Key? key}) : super(key: key);

  @override
  _AttendanceCalendarPageState createState() => _AttendanceCalendarPageState();
}

class _AttendanceCalendarPageState extends State<AttendanceCalendarPage> {
  @override
  void initState() {
    super.initState();
  }

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  var day = DateFormat('dd-MM-yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Attendance Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: kPrimaryColor,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: kPrimaryLightColor,
                shape: BoxShape.circle,
              ),
              // change the color of the selected day's text
              selectedTextStyle: TextStyle(color: Colors.white),
              // change the color of the focused day's text
              todayTextStyle: TextStyle(color: Colors.black),
            ),

            firstDay:
                DateTime(2021, 1, 1), // replace with your desired first day
            lastDay: DateTime.now(), // replace with your desired last day
            calendarFormat: _calendarFormat,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              // Use `selectedDayPredicate` to determine which day is currently selected.
              // If this returns true, the day will be highlighted.
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                day = DateFormat('dd-MM-yyyy').format(selectedDay);
                _focusedDay = focusedDay; // update `_focusedDay` here as well
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('Admin/$admin/attendance')
                  // .doc(widget.sub)
                  // .collection('lectures')
                  .where('date', isEqualTo: day)
                  .where('batch', isEqualTo: batch)
                  .where('branch', isEqualTo: branch)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final documents = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final data = documents[index].data();
                      final attendanceData =
                          data['attendance'] as Map<String, dynamic>?;
                      final lecturePresent = attendanceData?[child] ?? false;
                      return Card(
                        color: lecturePresent ? green : red,
                        elevation: 5,
                        shadowColor: Colors.grey[200],
                        child: ListTile(
                          textColor: Colors.white,
                          // tileColor: lecturePresent ? green : red,
                          title: Text('${data['subject']} '),
                          subtitle: Text('${data['start']} - ${data['end']}'),
                          trailing: Text(lecturePresent ? 'Present' : 'Absent'),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
