// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_parents/components/constants.dart';

class AttendanceDisplayPage extends StatefulWidget {
  // final String sub;
  const AttendanceDisplayPage({Key? key}) : super(key: key);

  @override
  _AttendanceDisplayPageState createState() => _AttendanceDisplayPageState();
}

class _AttendanceDisplayPageState extends State<AttendanceDisplayPage> {
  List<Map<String, dynamic>> lectures = [];

  @override
  void initState() {
    super.initState();
    _fetchAttendance();
  }

  Future<void> _fetchAttendance() async {
    final QuerySnapshot<Map<String, dynamic>> lecturesSnapshot =
        await FirebaseFirestore.instance
            .collection('Admin/$admin/attendance')
            // .doc(widget.sub)
            // .collection('lectures')
            .where('branch', isEqualTo: branch)
            .orderBy('date', descending: true)
            .get();
    setState(() {
      lectures = lecturesSnapshot.docs
          .map((doc) => doc.data())
          .toList()
          .cast<Map<String, dynamic>>();
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(lectures);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Attendance'),
      ),
      body: ListView.builder(
        itemCount: lectures.length,
        itemBuilder: (BuildContext context, int index) {
          final lecture = lectures[index];
          final date = lecture['date'] as String?;
          final start = lecture['start'] as String?;
          final end = lecture['end'] as String?;
          final sub = lecture['subject'] as String?;
          final attendance = lecture['attendance'];
          Map<String, dynamic>? sortedAttendance;
          if (attendance != null) {
            final sortedKeys = attendance.keys.toList()..sort();
            sortedAttendance = {
              for (var key in sortedKeys) key: attendance[key]
            };
            // use sortedAttendance for further processing
            print(sortedAttendance);
          }

          // print(attendance);
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      AttendanceDetailsPage(attendance: sortedAttendance),
                ),
              );
            },
            child: Card(
              //   DottedBorder(
              // color: Colors.black,
              // // gap: 3,
              // strokeWidth: 1,
              child: ListTile(
                textColor: Colors.white,
                leading: Text('$sub'),
                trailing: Text('$date, $start - $end'),
                // trailing: Text('${attendance?.length ?? 0}'),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AttendanceDetailsPage extends StatelessWidget {
  final Map<String, dynamic>? attendance;

  const AttendanceDetailsPage({Key? key, required this.attendance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Attendance Details'),
      ),
      body: attendance != null
          ? ListView.builder(
              itemCount: attendance!.length,
              itemBuilder: (BuildContext context, int index) {
                final student = attendance!.keys.elementAt(index);
                final present = attendance![student] as bool?;
                return Card(
                  child: ListTile(
                    title: Text(student),
                    textColor: Colors.white,
                    // splashColor: Colors.grey,
                    tileColor: present == true ? green : red,
                    trailing: present == true
                        ? const Icon(Icons.check)
                        : const Icon(Icons.close),
                  ),
                );
              },
            )
          : const Center(
              child: Text('No attendance data available'),
            ),
    );
  }
}

// class AttendanceCalendarPage extends StatefulWidget {
//   // final String sub;

//   const AttendanceCalendarPage({Key? key}) : super(key: key);

//   @override
//   _AttendanceCalendarPageState createState() => _AttendanceCalendarPageState();
// }

// class _AttendanceCalendarPageState extends State<AttendanceCalendarPage> {
//   final _prefs = SharedPreferences.getInstance();
//   var id;
//   void getUserName() async {
//     final SharedPreferences prefs = await _prefs;
//     id = prefs.getString('id');
//   }

//   @override
//   void initState() {
//     getUserName();
//     super.initState();
//   }

//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//   var day;
//   @override
//   Widget build(BuildContext context) {
//     print(_selectedDay);
//     return Scaffold(
//       appBar: AppBar(
//         leading: const BackButton(),
//         title: const Text('Attendance Calendar'),
//       ),
//       body: Column(
//         children: [
//           TableCalendar(
//             firstDay:
//                 DateTime.utc(2021, 1, 1), // replace with your desired first day
//             lastDay: DateTime.utc(
//                 2023, 12, 31), // replace with your desired last day
//             calendarFormat: _calendarFormat,
//             focusedDay: _focusedDay,
//             selectedDayPredicate: (day) {
//               // Use `selectedDayPredicate` to determine which day is currently selected.
//               // If this returns true, the day will be highlighted.
//               return isSameDay(_selectedDay, day);
//             },
//             onDaySelected: (selectedDay, focusedDay) {
//               setState(() {
//                 _selectedDay = selectedDay;
//                 day = DateFormat('dd-MM-yyyy').format(selectedDay);
//                 _focusedDay = focusedDay; // update `_focusedDay` here as well
//               });
//             },
//             onFormatChanged: (format) {
//               setState(() {
//                 _calendarFormat = format;
//               });
//             },
//           ),
//           Expanded(
//             child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//               stream: FirebaseFirestore.instance
//                   .collection('Admin/$admin/attendance')
//                   // .doc(widget.sub)
//                   // .collection('lectures')
//                   .where('date', isEqualTo: day)
//                   .where('branch', isEqualTo: branch)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   final documents = snapshot.data!.docs;
//                   return ListView.builder(
//                     itemCount: documents.length,
//                     itemBuilder: (context, index) {
//                       final data = documents[index].data();
//                       final attendanceData =
//                           data['attendance'] as Map<String, dynamic>?;
//                       final lecturePresent = attendanceData?[id] ?? false;
//                       return ListTile(
//                         tileColor: lecturePresent ? green : red,
//                         title: Text('Lecture ${index + 1}'),
//                         subtitle: Text('${data['start']} - ${data['end']}'),
//                         trailing: Text(lecturePresent ? 'Present' : 'Absent'),
//                       );
//                     },
//                   );
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
