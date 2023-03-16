// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_parents/components/constants.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'College Timetable',
//       home: TimetablePage(),
//     );
//   }
// }

class TimetablePage extends StatefulWidget {
  const TimetablePage({super.key});

  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  final _service = TimetableService();
  final _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _startController = TextEditingController();
  final _endController = TextEditingController();
  String _selectedDay = 'Monday';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('College Timetable'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          const Text('Select day:'),
          DropdownButton<String>(
            value: _selectedDay,
            onChanged: (value) {
              setState(() {
                _selectedDay = value!;
              });
            },
            items: _days.map((day) {
              return DropdownMenuItem<String>(
                value: day,
                child: Text(day),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
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
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final entry = snapshot.data![index];
                    return ListTile(
                      title: Text(entry.subject),
                      subtitle: Text('${entry.startTime} - ${entry.endTime}'),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          const Text('Add lecture:'),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _subjectController,
                  decoration: const InputDecoration(hintText: 'Subject'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a subject';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _startController,
                  decoration: const InputDecoration(hintText: 'Start time'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a start time';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _endController,
                  decoration: const InputDecoration(hintText: 'End time'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an end time';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
// Incomplete code, add functionality to save lecture to Firebase Firestore
                      final subject = _subjectController.text;
                      final start = _startController.text;
                      final end = _endController.text;
                      final timetableEntry = TimetableEntry(
                          subject: subject, startTime: start, endTime: end);
                      await _service.addTimetableEntry(
                          _selectedDay, timetableEntry);
                      _subjectController.clear();
                      _startController.clear();
                      _endController.clear();
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TimetableEntry {
  final String subject;
  final String startTime;
  final String endTime;

  TimetableEntry(
      {required this.subject, required this.startTime, required this.endTime});
}

class TimetableService {
  // final String collegeId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // TimetableService({required this.collegeId});

  Stream<List<TimetableEntry>> getTimetableStream(String day) {
    return _firestore
        .collection('Admin')
        .doc(admin)
        .collection('timetable')
        .doc(day)
        .collection('entries')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return TimetableEntry(
            subject: data['subject'],
            startTime: data['startTime'],
            endTime: data['endTime']);
      }).toList();
    });
  }

  Future<void> addTimetableEntry(String day, TimetableEntry entry) async {
    await _firestore
        .collection('Admin')
        .doc(admin)
        .collection('timetable')
        .doc(day)
        .collection('entries')
        .add({
      'subject': entry.subject,
      'startTime': entry.startTime,
      'endTime': entry.endTime,
    });
  }
}


// Stack(
//           children: [
//             Container(
//               height: 300,
//               color: Colors.blue,
//             ),
//             Positioned(
//               top: 50,
//               left: 20,
//               child: Container(
//                 width: 100,
//                 height: 100,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(color: Colors.black, width: 2),
//                 ),
//                 child: const Icon(Icons.person),
//               ),
//             ),
//             const Positioned(
//               top: 50,
//               left: 150,
//               child: Text(
//                 'John Doe',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Positioned(
//               top: 100,
//               left: 150,
//               child: Row(
//                 children: const [
//                   Icon(Icons.location_on),
//                   SizedBox(width: 5),
//                   Text('New York'),
//                 ],
//               ),
//             ),
//             Positioned(
//               top: 150,
//               left: 150,
//               child: Row(
//                 children: const [
//                   Icon(Icons.star),
//                   SizedBox(width: 5),
//                   Text('4.5'),
//                 ],
//               ),
//             ),
//             Positioned(
//               top: 200,
//               left: 150,
//               child: Row(
//                 children: const [
//                   Icon(Icons.work),
//                   SizedBox(width: 5),
//                   Text('Software Engineer'),
//                 ],
//               ),
//             ),
//             Positioned(
//               top: 250,
//               left: 20,
//               right: 20,
//               child: Container(
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Text(
//                       'About Me',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec gravida convallis vestibulum. Nullam euismod fringilla purus, et egestas felis pellentesque sed. Duis id lacus vel erat aliquam placerat.',
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         )