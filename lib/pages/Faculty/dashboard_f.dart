// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:smart_parents/pages/Faculty/attendencepages/attendencedropdownpage2.dart';
import 'package:smart_parents/pages/Faculty/parents_f/parents_f.dart';
import 'package:smart_parents/pages/Faculty/report_f/reportGenration.dart';
import 'package:smart_parents/pages/Faculty/Schedule/schedule_f.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // margin: const EdgeInsets.all(20),
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const AttendenceDropdownpage2();
                    },
                  ),
                )
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                // backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                minimumSize: const Size(250, 50),
              ),
              child: const Text(
                "Add Today's Attendence",
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
          Container(
            // margin: const EdgeInsets.all(20),
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ReportGenration();
                    },
                  ),
                )
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                // backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                minimumSize: const Size(250, 50),
              ),
              child: const Text(
                'Attendence Reports',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
          Container(
            // margin: const EdgeInsets.all(20),
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const Parent();
                    },
                  ),
                )
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                // backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                minimumSize: const Size(250, 50),
              ),
              child: const Text(
                'Manage Parents',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
          Container(
            // margin: const EdgeInsets.all(20),
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ShowSchedule();
                    },
                  ),
                )
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                // backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                minimumSize: const Size(250, 50),
              ),
              child: const Text(
                'Schedule',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
