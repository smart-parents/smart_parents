// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_parents/pages/Admin/department_a/depart_a.dart';
import 'package:smart_parents/pages/Admin/faculty_a/faculty_a.dart';
import 'package:smart_parents/pages/Admin/fees.dart';
import 'package:smart_parents/pages/Admin/notice_dash.dart';
import 'package:smart_parents/pages/Admin/student_a/student_a.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    // login();
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
                      return const Student();
                    },
                  ),
                )
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                // backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                minimumSize: const Size(200, 50),
              ),
              child: const Text(
                'Manage Student',
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
                      return const Faculty();
                    },
                  ),
                )
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                // backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                minimumSize: const Size(200, 50),
              ),
              child: const Text(
                'Manage Faculty',
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
                      return const Department();
                    },
                  ),
                )
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                // backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                minimumSize: const Size(200, 50),
              ),
              child: const Text(
                'Manage Department',
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
                  MaterialPageRoute(builder: (context) => const Notice()),
                ),
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                // backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                minimumSize: const Size(200, 50),
              ),
              child: const Text(
                'Manage Notice',
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
                  MaterialPageRoute(builder: (context) => const Fees()),
                ),
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                // backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                minimumSize: const Size(200, 50),
              ),
              child: const Text(
                'Fee Details',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';

// class Dashboard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return
//         // Scaffold(
//         //   appBar: AppBar(
//         //     title: Text("Admin Dashboard"),
//         //     centerTitle: true,
//         //     elevation: 0.0,
//         //     backgroundColor: Colors.teal[800],
//         //   ),
//         //   body:
//         Container(
//       alignment: Alignment.center,
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             Color.fromARGB(255, 0, 105, 92),Color.fromARGB(255, 128, 203, 196),
//             // Colors.blue,Colors.green,
//             // Colors.orange,Colors.blue,
//           ],
//         ),
//       ),
//       child: Column(
//         // crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Container(
//             padding: EdgeInsets.all(20.0),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20.0),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   offset: Offset(0.0, 15.0),
//                   blurRadius: 15.0,
//                 ),
//                 BoxShadow(
//                   color: Colors.black12,
//                   offset: Offset(0.0, -10.0),
//                   blurRadius: 10.0,
//                 ),
//               ],
//             ),
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   padding: EdgeInsets.only(top: 20.0),
//                   child: Text(
//                     "Manage",
//                     style: TextStyle(
//                       fontSize: 30.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.teal[800],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(top: 20.0),
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 15.0,
//                         horizontal: 30.0,
//                       ),
//                       backgroundColor: Colors.teal[800],
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                       ),
//                     ),
//                     child: Text(
//                       "Students",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20.0,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(top: 20.0),
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 15.0,
//                         horizontal: 30.0,
//                       ),
//                       backgroundColor: Colors.teal[800],
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                       ),
//                     ),
//                     child: Text(
//                       "Faculty",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20.0,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(top: 20.0),
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 15.0,
//                         horizontal: 30.0,
//                       ),
//                       backgroundColor: Colors.teal[800],
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                       ),
//                     ),
//                     child: Text(
//                       "Notices",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20.0,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(top: 20.0),
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 15.0,
//                         horizontal: 30.0,
//                       ),
//                       backgroundColor: Colors.teal[800],
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                       ),
//                     ),
//                     child: Text(
//                       "Fees",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20.0,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(top: 20.0),
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 15.0,
//                         horizontal: 30.0,
//                       ),
//                       backgroundColor: Colors.teal[800],
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                       ),
//                     ),
//                     child: const Text(
//                       "Departments",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20.0,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       // ),
//     );
//   }
// }
