// // ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:smart_parents/components/constants.dart';

// class ParentDashboard extends StatefulWidget {
//   const ParentDashboard({super.key});

//   @override
//   _ParentDashboardState createState() => _ParentDashboardState();
// }

// class _ParentDashboardState extends State<ParentDashboard> {
//   // Define the parent and children data as instance variables
//   // Map<String, dynamic> parentData = {};
//   // Map<String, dynamic> childrenData = {};
//   // List<Map<String, dynamic>> attendanceData = [];
//   // List<Map<String, dynamic>> gradesData = [];

//   @override
//   void initState() {
//     super.initState();
//     // Call the functions to retrieve the parent and children data
//     // from Firestore
//     _getParentData();
//     // _getChildrenData();
//     // _getAttendanceData();
//     // _getGradesData();
//   }

//   String? id;
//   final _prefs = SharedPreferences.getInstance();
//   // Function to retrieve the parent's data from Firestore
//   void _getParentData() async {
//     final SharedPreferences prefs = await _prefs;
//     id = prefs.getString('id');
//     // Retrieve the parent's data from Firestore
//     // if (id == null) {
//     //   var documentRef = await FirebaseFirestore.instance
//     //       .collection('Admin/$admin/parents')
//     //       .doc(id)
//     //       .get();
//     //   parentData = documentRef.data()!;
//     // DocumentSnapshot parentSnapshot = await FirebaseFirestore.instance
//     //     .collection('Admin/$admin/parents')
//     //     .doc(id)
//     //     .get();

//     // // Convert the parent data to a map
//     // parentData = parentSnapshot.data() as Map<String, dynamic>;
//     // }
//   }

//   // Function to retrieve the children's data from Firestore
//   // void _getChildrenData() async {
//   //   // Retrieve the children's data from Firestore
//   //   var childrenSnapshot = await FirebaseFirestore.instance
//   //       .collection('Admin/$admin/students')
//   //       .doc(child)
//   //       .get();
//   //   // if (childrenSnapshot == null) {
//   //   // Convert the children data to a list of maps
//   //   childrenData = childrenSnapshot.data()!;
//   //   // }
//   // }

//   // // Function to retrieve the attendance data from Firestore
//   // void _getAttendanceData() async {
//   //   // Retrieve the attendance data from Firestore
//   //   QuerySnapshot attendanceSnapshot = await FirebaseFirestore.instance
//   //       .collection('parents')
//   //       .doc('parent-id')
//   //       .collection('attendance')
//   //       .get();

//   //   // Convert the attendance data to a list of maps
//   //   attendanceData = attendanceSnapshot.docs
//   //       .map((doc) => doc.data())
//   //       .toList()
//   //       .cast<Map<String, dynamic>>();
//   // }

//   // // Function to retrieve the grades data from Firestore
//   // void _getGradesData() async {
//   //   // Retrieve the grades data from Firestore
//   //   QuerySnapshot gradesSnapshot = await FirebaseFirestore.instance
//   //       .collection('parents')
//   //       .doc('parent-id')
//   //       .collection('grades')
//   //       .get();

//   //   // Convert the grades data to a list of maps
//   //   gradesData = gradesSnapshot.docs
//   //       .map((doc) => doc.data())
//   //       .toList()
//   //       .cast<Map<String, dynamic>>();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // appBar: AppBar(
//         //   title: const Text('Parent Dashboard'),
//         // ),
//         body: SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//                 stream: FirebaseFirestore.instance
//                     .collection('Admin/$admin/parents')
//                     .doc(id)
//                     .snapshots(),
//                 builder: (_, snapShot) {
//                   if (snapShot.hasError) {
//                     print('Something Went Wrong');
//                   }
//                   if (snapShot.connectionState == ConnectionState.waiting) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                   if (snapShot.hasData) {
//                     var data = snapShot.data!.data();
//                     var number = data!['number'];
//                     var name = data['name'];
//                     return StreamBuilder<
//                             DocumentSnapshot<Map<String, dynamic>>>(
//                         stream: FirebaseFirestore.instance
//                             .collection('Admin/$admin/students')
//                             .doc(child)
//                             .snapshots(),
//                         builder: (_, snapshot) {
//                           if (snapshot.hasError) {
//                             print('Something Went Wrong');
//                           }
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return const Center(
//                               child: CircularProgressIndicator(),
//                             );
//                           }
//                           if (snapShot.hasData) {
//                             var data = snapshot.data!.data();
//                             var names = data!['name'];
//                             var batch = data['batch'];
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Welcome, $name}!',
//                                   style: Theme.of(context).textTheme.titleLarge,
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Text(
//                                   'Mobile No.: $number}',
//                                   style: const TextStyle(fontSize: 16),
//                                 ),
//                                 const SizedBox(height: 20),
//                                 Text(
//                                   'Children',
//                                   style: Theme.of(context).textTheme.titleLarge,
//                                 ),
//                                 const SizedBox(height: 10),
//                                 ListTile(
//                                   title: Text(names),
//                                   subtitle: Text(batch),
//                                 ),
//                                 // ListView.builder(
//                                 //   shrinkWrap: true,
//                                 //   physics: const NeverScrollableScrollPhysics(),
//                                 //   itemCount: childrenData.length,
//                                 //   itemBuilder: (BuildContext context, int index) {
//                                 //     Map<String, dynamic> child = childrenData[index];
//                                 //     return ListTile(
//                                 //       title: Text(child['name']),
//                                 //       subtitle: Text(child['batch']),
//                                 //     );
//                                 //   },
//                                 // ),
//                                 // _buildChildList(context),
//                                 // const SizedBox(height: 20),
//                                 // _buildAttendance(context),
//                                 // const SizedBox(height: 20),
//                                 // _buildGrades(context),
//                               ],
//                             );
//                           }
//                           return Container();
//                         });
//                   }
//                   return Container();
//                 })));
//   }

//   // Widget _buildHeader(BuildContext context) {
//   //   return Column(
//   //     crossAxisAlignment: CrossAxisAlignment.start,
//   //     children: [
//   //       Text(
//   //         'Welcome, ${parentData['name']}!',
//   //         style: Theme.of(context).textTheme.titleLarge,
//   //       ),
//   //       const SizedBox(height: 10),
//   //       Text(
//   //         'Mobile No.: ${parentData['number']}',
//   //         style: const TextStyle(fontSize: 16),
//   //       ),
//   //     ],
//   //   );
//   // }

//   // Widget _buildChildList(BuildContext context) {
//   //   return Column(
//   //     crossAxisAlignment: CrossAxisAlignment.start,
//   //     children: [
//   //       Text(
//   //         'Children',
//   //         style: Theme.of(context).textTheme.titleLarge,
//   //       ),
//   //       const SizedBox(height: 10),
//   //       // ListTile(
//   //       //   title: Text(childrenData['name']),
//   //       //   subtitle: Text(childrenData['batch']),
//   //       // ),
//   //       ListView.builder(
//   //         shrinkWrap: true,
//   //         physics: const NeverScrollableScrollPhysics(),
//   //         itemCount: childrenData.length,
//   //         itemBuilder: (BuildContext context, int index) {
//   //           Map<String, dynamic> child = childrenData[index];
//   //           return ListTile(
//   //             title: Text(child['name']),
//   //             subtitle: Text(child['batch']),
//   //           );
//   //         },
//   //       ),
//   //     ],
//   //   );
//   // }

//   // Widget _buildAttendance(BuildContext context) {
//   //   return Column(
//   //     crossAxisAlignment: CrossAxisAlignment.start,
//   //     children: [
//   //       Text(
//   //         'Attendance',
//   //         style: Theme.of(context).textTheme.titleLarge,
//   //       ),
//   //       const SizedBox(height: 10),
//   //       if (attendanceData.isEmpty)
//   //         const Text('No attendance data available.')
//   //       else
//   //         ListView.builder(
//   //           shrinkWrap: true,
//   //           physics: const NeverScrollableScrollPhysics(),
//   //           itemCount: attendanceData.length,
//   //           itemBuilder: (BuildContext context, int index) {
//   //             Map<String, dynamic> attendance = attendanceData[index];
//   //             return ListTile(
//   //               title: Text(attendance['date']),
//   //               subtitle: Text(attendance['status']),
//   //             );
//   //           },
//   //         ),
//   //     ],
//   //   );
//   // }

// //   Widget _buildGrades(BuildContext context) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           'Grades',
// //           style: Theme.of(context).textTheme.titleLarge,
// //         ),
// //         const SizedBox(height: 10),
// //         if (gradesData.isEmpty)
// //           const Text('No grades data available.')
// //         else
// //           ListView.builder(
// //             shrinkWrap: true,
// //             physics: const NeverScrollableScrollPhysics(),
// //             itemCount: gradesData.length,
// //             itemBuilder: (BuildContext context, int index) {
// //               Map<String, dynamic> grade = gradesData[index];
// //               return ListTile(
// //                 title: Text(grade['subject']),
// //                 subtitle: Text(grade['grade']),
// //               );
// //             },
// //           ),
// //       ],
// //     );
// //   }
// }
