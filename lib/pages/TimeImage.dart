// ignore_for_file: file_names

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:smart_parents/pages/Welcome/welcome_screen.dart';

// class TimeImage extends StatefulWidget {
//   const TimeImage({Key? key}) : super(key: key);
//   @override
//   State<TimeImage> createState() => _TimeImageState();
// }

// class _TimeImageState extends State<TimeImage> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(
//         const Duration(seconds: 3),
//         () => Navigator.of(context).pushReplacement(
//             MaterialPageRoute(builder: (context) => const WelcomeScreen())));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         child: Stack(
//           alignment: AlignmentDirectional.center,
//           children: [
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 10.0),
//                   child: Image.asset(
//                     "assets/images/Final.png",
//                     fit: BoxFit.cover,
//                     height: 350,
//                     width: 350,
//                   ),
//                 ),
//                 // SizedBox(
//                 //   height: 100,
//                 // ),
//                 // Text(
//                 //   "SMART PARENTS",
//                 //   style: TextStyle(
//                 //     color: Colors.white,
//                 //     fontSize: 40,
//                 //   ),
//                 // ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
