import 'package:flutter/material.dart';

class Attendance_screen extends StatefulWidget {
  const Attendance_screen({super.key});

  @override
  State<Attendance_screen> createState() => _Attendance_screenState();
}

class _Attendance_screenState extends State<Attendance_screen> {
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return const Student();
                //     },
                //   ),
                // )
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                minimumSize: const Size(250, 50),
              ),
              child: const Text(
                'Today Attendance',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
          Container(
            // margin: const EdgeInsets.all(20),
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: ElevatedButton(
              onPressed: () => {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return const Faculty();
                //     },
                //   ),
                // )
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                minimumSize: const Size(250, 50),
              ),
              child: const Text(
                'Monthly Attendance',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
          Container(
            // margin: const EdgeInsets.all(20),
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: ElevatedButton(
              onPressed: () => {},
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                minimumSize: const Size(250, 50),
              ),
              child: const Text(
                ' Attendance Report',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
