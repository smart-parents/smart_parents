// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:smart_parents/pages/Parents/attendance_show.dart';
import 'package:smart_parents/pages/Parents/chat_parents_f.dart';
import 'package:smart_parents/pages/Parents/contact_faculty.dart';
import 'package:smart_parents/pages/Parents/exam_p/exam.dart';
import 'package:smart_parents/pages/Parents/fees.dart';
import 'package:smart_parents/pages/Parents/livelocation.dart';
import 'package:smart_parents/pages/Parents/notice_p/notice_dash.dart';
import 'package:smart_parents/pages/Parents/result_p.dart';

import '../../widgest/animation.dart';

class Parents_home extends StatefulWidget {
  const Parents_home({super.key});

  @override
  State<Parents_home> createState() => _Parents_homeState();
}

class _Parents_homeState extends State<Parents_home> {
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16.0),
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
      children: [
        _buildCard('Get Your Child Location', Icons.location_on, Colors.green),
        _buildCard('View Attendance', Icons.calendar_month, Colors.blue),
        _buildCard('View Notice', Icons.notifications, Colors.orange),
        _buildCard('View Result', Icons.assignment, Colors.purple),
        _buildCard('Chat With Faculty', Icons.chat, Colors.teal),
      ],
    );
  }

  Widget _buildCard(String title, IconData iconData, Color color) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
          switch (title) {
            case 'Get Your Child Location':
              Navigator.push(context, FadeAnimation(const ChildLocation()));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const Student()),
              // );
              break;
            case 'View Attendance':
              Navigator.push(
                  context, FadeAnimation(const AttendanceCalendarPage()));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const Faculty()),
              // );
              break;
            case 'View Notice':
              Navigator.push(context, FadeAnimation(const Notice()));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const Department()),
              // );
              break;
            case 'Chat With Faculty':
              Navigator.push(context, FadeAnimation(const ChatParent ()));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const Notice()),
              // );
              break;
            case 'View Result':
              Navigator.push(context, FadeAnimation(const Result()));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const Fees()),
              // );
              break;
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: color,
              size: 64.0,
            ),
            const SizedBox(height: 16.0),
            Text(
              title,
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
