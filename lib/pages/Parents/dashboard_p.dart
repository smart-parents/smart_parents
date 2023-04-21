// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:smart_parents/pages/Parents/contact_faculty.dart';
import 'package:smart_parents/pages/Parents/exam_p/exam.dart';
import 'package:smart_parents/pages/Parents/fees.dart';
import 'package:smart_parents/pages/Parents/livelocation.dart';
import 'package:smart_parents/pages/Parents/result_p.dart';

class Parents_home extends StatefulWidget {
  const Parents_home({super.key});

  @override
  State<Parents_home> createState() => _Parents_homeState();
}

class _Parents_homeState extends State<Parents_home> {
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // margin: const EdgeInsets.all(20),
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: ElevatedButton(
              onPressed: () => {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Result(),
                ))
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                // backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                minimumSize: const Size(250, 50),
              ),
              child: const Text(
                'View Results',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
          Container(
            // margin: const EdgeInsets.all(20),
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: ElevatedButton(
              onPressed: () => {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ContactF(),
                ))
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                // backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                minimumSize: const Size(250, 50),
              ),
              child: const Text(
                'Contact Faculty',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
          Container(
            // margin: const EdgeInsets.all(20),
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: ElevatedButton(
              onPressed: () => {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Fees(),
                ))
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                // backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                minimumSize: const Size(250, 50),
              ),
              child: const Text(
                'View Fees Details',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
          Container(
            // margin: const EdgeInsets.all(20),
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: ElevatedButton(
              onPressed: () => {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Exam(),
                ))
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                // backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                minimumSize: const Size(250, 50),
              ),
              child: const Text(
                'View Exams',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
          Container(
            // margin: const EdgeInsets.all(20),
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ElevatedButton(
              onPressed: () => {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ChildLocation(),
                ))
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                // backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                minimumSize: const Size(250, 50),
              ),
              child: const Text(
                'Get Your child location',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
