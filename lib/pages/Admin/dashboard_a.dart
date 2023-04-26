// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_parents/pages/Admin/department_a/depart_a.dart';
import 'package:smart_parents/pages/Admin/faculty_a/faculty_a.dart';
import 'package:smart_parents/pages/Admin/fees.dart';
import 'package:smart_parents/pages/Admin/notice_a/notice_a.dart';
import 'package:smart_parents/pages/Admin/student_a/student_a.dart';
import 'package:smart_parents/widgest/animation.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    // login();
    // return
    //     // Container(
    //     //   decoration: const BoxDecoration(
    //     //     color: Colors.transparent,
    //     //     // image: DecorationImage(
    //     //     //   image: AssetImage("assets/images/background.jpg"),
    //     //     //   fit: BoxFit.cover,
    //     //     // ),
    //     //   ),
    //     //   child:
    //     Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Container(
    //         // margin: const EdgeInsets.all(20),
    //         margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
    //         child: ElevatedButton(
    //           onPressed: () => {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) {
    //                   return const Student();
    //                 },
    //               ),
    //             )
    //           },
    //           style: ElevatedButton.styleFrom(
    //             shape: const StadiumBorder(),
    //             // backgroundColor: const Color.fromARGB(255, 37, 86, 116),
    //             minimumSize: const Size(200, 50),
    //           ),
    //           child: const Text(
    //             'Manage Student',
    //             style: TextStyle(fontSize: 20.0, color: Colors.white),
    //           ),
    //         ),
    //       ),
    //       Container(
    //         // margin: const EdgeInsets.all(20),
    //         margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
    //         child: ElevatedButton(
    //           onPressed: () => {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) {
    //                   return const Faculty();
    //                 },
    //               ),
    //             )
    //           },
    //           style: ElevatedButton.styleFrom(
    //             shape: const StadiumBorder(),
    //             // backgroundColor: const Color.fromARGB(255, 37, 86, 116),
    //             minimumSize: const Size(200, 50),
    //           ),
    //           child: const Text(
    //             'Manage Faculty',
    //             style: TextStyle(fontSize: 20.0, color: Colors.white),
    //           ),
    //         ),
    //       ),
    //       Container(
    //         // margin: const EdgeInsets.all(20),
    //         margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
    //         child: ElevatedButton(
    //           onPressed: () => {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) {
    //                   return const Department();
    //                 },
    //               ),
    //             )
    //           },
    //           style: ElevatedButton.styleFrom(
    //             shape: const StadiumBorder(),
    //             // backgroundColor: const Color.fromARGB(255, 37, 86, 116),
    //             minimumSize: const Size(200, 50),
    //           ),
    //           child: const Text(
    //             'Manage Department',
    //             style: TextStyle(fontSize: 20.0, color: Colors.white),
    //           ),
    //         ),
    //       ),
    //       Container(
    //         // margin: const EdgeInsets.all(20),
    //         margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
    //         child: ElevatedButton(
    //           onPressed: () => {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(builder: (context) => const Notice()),
    //             ),
    //           },
    //           style: ElevatedButton.styleFrom(
    //             shape: const StadiumBorder(),
    //             // backgroundColor: const Color.fromARGB(255, 37, 86, 116),
    //             minimumSize: const Size(200, 50),
    //           ),
    //           child: const Text(
    //             'Manage Notice',
    //             style: TextStyle(fontSize: 20.0, color: Colors.white),
    //           ),
    //         ),
    //       ),
    //       Container(
    //         // margin: const EdgeInsets.all(20),
    //         margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
    //         child: ElevatedButton(
    //           onPressed: () => {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(builder: (context) => const Fees()),
    //             ),
    //           },
    //           style: ElevatedButton.styleFrom(
    //             shape: const StadiumBorder(),
    //             // backgroundColor: const Color.fromARGB(255, 37, 86, 116),
    //             minimumSize: const Size(200, 50),
    //           ),
    //           child: const Text(
    //             'Fee Details',
    //             style: TextStyle(fontSize: 20.0, color: Colors.white),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    //   // ),
    // );
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16.0),
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
      children: [
        _buildCard('Manage Students', Icons.people, Colors.green),
        _buildCard('Manage Faculty', Icons.person, Colors.blue),
        _buildCard('Manage Departments', Icons.account_balance, Colors.orange),
        _buildCard('Manage Notice', Icons.notifications, Colors.purple),
        _buildCard('Manage Fees', Icons.monetization_on, Colors.teal),
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
            case 'Manage Students':
              Navigator.push(context, FadeAnimation(const Student()));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const Student()),
              // );
              break;
            case 'Manage Faculty':
              Navigator.push(context, FadeAnimation(const Faculty()));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const Faculty()),
              // );
              break;
            case 'Manage Departments':
              Navigator.push(context, FadeAnimation(const Department()));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const Department()),
              // );
              break;
            case 'Manage Notice':
              Navigator.push(context, FadeAnimation(const Notice()));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const Notice()),
              // );
              break;
            case 'Manage Fees':
              Navigator.push(context, FadeAnimation(const Fees()));
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
