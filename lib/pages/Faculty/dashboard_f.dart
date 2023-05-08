// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:smart_parents/pages/Faculty/Schedule/schedule_f.dart';
import 'package:smart_parents/pages/Faculty/attendencepages/attendencedropdownpage2.dart';
import 'package:smart_parents/pages/Faculty/chat_parents_f.dart';
import 'package:smart_parents/pages/Faculty/chat_student_f.dart';
import 'package:smart_parents/pages/Faculty/parents_f/parents_f.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16.0),
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
      children: [
        _buildCard('Add Attendence', Icons.calendar_month, Colors.green),
        _buildCard('Manage Parents', Icons.person_add_alt_1, Colors.blue),
        _buildCard('Chat With Student', Icons.chat, Colors.orange),
        _buildCard('Chat With Parents', Icons.chat, Colors.purple),
        _buildCard('Manage Schedule', Icons.schedule, Colors.teal),
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
            case 'Add Attendence':
              // Navigator.push(
              //     context, FadeAnimation(const AttendenceDropdownpage2()));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AttendenceDropdownpage2()),
              );
              break;
            case 'Manage Parents':
              // Navigator.push(context, FadeAnimation(const Parent()));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Parent()),
              );
              break;
            case 'Manage Schedule':
              // Navigator.push(context, FadeAnimation(const ShowSchedule()));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShowSchedule()),
              );
              break;
            case 'Chat With Parents':
              // Navigator.push(context, FadeAnimation(const ChatParent()));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatParent()),
              );
              break;
            case 'Chat With Student':
              // Navigator.push(context, FadeAnimation(const ChatStudent()));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatStudent()),
              );
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
