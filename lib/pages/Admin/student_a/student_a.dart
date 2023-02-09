import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_parents/pages/Admin/student_a/add_student_page_a.dart';
import 'package:smart_parents/pages/Admin/student_a/update_student_page_a.dart';
import 'package:flutter/material.dart';

class Student extends StatefulWidget {
  const Student({Key? key}) : super(key: key);

  // void initState() {
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
  //     // SystemUiOverlay.bottom,
  //   ]);
  // }

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  // final email = FirebaseAuth.instance.currentUser!.email;

  // static Stream<QuerySnapshot> studentsStream =
  //     FirebaseFirestore.instance.collection('students').snapshots();
  late Stream<QuerySnapshot> studentsStream;
  void myMethod() {
    if (FirebaseAuth.instance.currentUser != null) {
      final email = FirebaseAuth.instance.currentUser!.email;
      studentsStream = FirebaseFirestore.instance
          .collection('students')
          .where("admin", isEqualTo: email)
          .snapshots();
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    login();
    myMethod();
  }

  // For Deleting User
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');
  Future<void> deleteUser(id) async {
    // print("User Deleted $id");
    // var student = await _auth.getUserByEmail( '@example.com');
    // final stu = await "$id@example.com";

    return students
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  // Future<void> delete(id) async {
  //   // print("User Deleted $id");
  //   // var student = await _auth.getUserByEmail( '@example.com');
  //   // final stu = await "$id@example.com";
  //   print(id);
  //   await id?.delete();
  // }

  final _prefs = SharedPreferences.getInstance();
  login() async {
    FirebaseAuth.instance.signOut();
    final SharedPreferences prefs = await _prefs;
    String? email = prefs.getString('email');
    String? pass = prefs.getString('pass');
    print("signout");
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: "$email", password: "$pass")
          .then(
            (value) => print("login $email"),
          );
      print("login");
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // login();
    // myMethod();
    return StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.lightBlue,
            ),
            home: Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 207, 235, 255),
                automaticallyImplyLeading: false,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  tooltip: "Back",
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: const Text("Student Details",
                    style: TextStyle(fontSize: 30.0)),
              ),
              body:
                  // Center(
                  //     child: Column(
                  //         // mainAxisAlignment: MainAxisAlignment.center,
                  //         children: <Widget>[
                  // const Text("Student", style: TextStyle(fontSize: 30.0)),
                  storedocs.isNotEmpty
                      ? ListView.builder(
                          itemCount: storedocs.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 5,
                              shadowColor: Colors.grey[200],
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${index + 1}',
                                        ),
                                        // SizedBox(
                                        //   width: 10,
                                        // ),
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                '${storedocs[index]['number']}',
                                                // Enrollment[index],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0),
                                              ),
                                              Text(
                                                'Name: ${storedocs[index]['name']}',
                                                // Students[index],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17.0),
                                              ),
                                              // Text(
                                              //   studentvar[index].studentemail,
                                              //   // StudentEmail[index],
                                              //   style: TextStyle(
                                              //       fontWeight: FontWeight.bold, fontSize: 13.0),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        // SizedBox(
                                        //   width: 10,
                                        // ),
                                        // ElevatedButton(
                                        //   onPressed: () {},
                                        //   child: Text("Remove"),
                                        //   style: ElevatedButton.styleFrom(
                                        //     primary: Colors.white,
                                        //     onPrimary: Colors.grey[600],
                                        //   ),
                                        // ),
                                        Column(
                                          children: [
                                            Text("Delete"),
                                            IconButton(
                                              highlightColor: Colors.red,
                                              onPressed: () async {
                                                try {
                                                  // await delete(storedocs[index]
                                                  //         ['number'] +
                                                  //     '@sps.com');
                                                  deleteUser(
                                                      storedocs[index]['id']);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        content: Text(
                                                            'Student deleted.')),
                                                  );
                                                } catch (e) {
                                                  print(e);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Text(
                                                            'Failed to delete student: $e')),
                                                  );
                                                }
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                            // Switch(
                                            //   value: isActive[index],
                                            //   onChanged: (bool newValue) {
                                            //     setState(() {
                                            //       isActive[index] = !isActive[index];
                                            //     });
                                            //   },
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    // Row(
                                    //   children: [
                                    //     Expanded(
                                    //       child: Column(
                                    //         children: [
                                    //           Text(
                                    //             "Program : " + studentvar[index].program,
                                    //             style: TextStyle(fontSize: 13),
                                    //           ),
                                    //           Text(
                                    //             "Batch : " + studentvar[index].batch,
                                    //             style: TextStyle(fontSize: 13),
                                    //           )
                                    //         ],
                                    //       ),
                                    //     ),
                                    //     Expanded(
                                    //       child: Column(
                                    //         children: [
                                    //           Text(
                                    //             "Branch : " + studentvar[index].branch,
                                    //             style: TextStyle(fontSize: 13),
                                    //           ),
                                    //           Text(
                                    //             "Semester : " + studentvar[index].semester,
                                    //             style: TextStyle(fontSize: 13),
                                    //           )
                                    //         ],
                                    //       ),
                                    //     ),
                                    //     Expanded(
                                    //       child: Column(
                                    //         children: [
                                    //           Text(
                                    //             "Year : " + studentvar[index].studingInYear,
                                    //             style: TextStyle(fontSize: 13),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: 15,
                                    // ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateStudentPage(
                                                      id: storedocs[index]
                                                          ['id'])),
                                        );
                                      },
                                      child: Text("Edit"),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          onPrimary: Colors.grey[600],
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      10.0)),
                                          fixedSize: Size(200, 40),
                                          elevation: 5,
                                          textStyle: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500)),
                                    )
                                  ],
                                ),
                              ),
                            );
                            // return Card(
                            //   semanticContainer: true,
                            //   // shadowColor: Colors.black,
                            //   margin: EdgeInsets.all(10),
                            //   child: Container(
                            //     padding: EdgeInsets.all(10),
                            //     child: Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: <Widget>[
                            //         Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.spaceBetween,
                            //           children: <Widget>[
                            //             Text(
                            //               '${storedocs[index]['number']}',
                            //               style: TextStyle(
                            //                 fontSize: 20,
                            //                 fontWeight: FontWeight.bold,
                            //               ),
                            //             ),
                            //             IconButton(
                            //               onPressed: () => {
                            //                 Navigator.push(
                            //                   context,
                            //                   MaterialPageRoute(
                            //                     builder: (context) =>
                            //                         UpdateStudentPage(
                            //                             id: storedocs[index]
                            //                                 ['id']),
                            //                   ),
                            //                 )
                            //               },
                            //               icon: const Icon(
                            //                 Icons.edit,
                            //                 color: Colors.orangeAccent,
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //         // SizedBox(
                            //         //   height: 10,
                            //         // ),
                            //         Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.spaceBetween,
                            //           children: <Widget>[
                            //             Text(
                            //               'Name: ${storedocs[index]['name']}',
                            //               style: TextStyle(
                            //                 fontSize: 15,
                            //               ),
                            //             ),
                            //             IconButton(
                            //               highlightColor: Colors.red,
                            //               onPressed: () async {
                            //                 try {
                            //                   // await delete(storedocs[index]
                            //                   //         ['number'] +
                            //                   //     '@sps.com');
                            //                   deleteUser(
                            //                       storedocs[index]['id']);
                            //                   ScaffoldMessenger.of(context)
                            //                       .showSnackBar(
                            //                     const SnackBar(
                            //                         content: Text(
                            //                             'Student deleted.')),
                            //                   );
                            //                 } catch (e) {
                            //                   print(e);
                            //                   ScaffoldMessenger.of(context)
                            //                       .showSnackBar(
                            //                     SnackBar(
                            //                         content: Text(
                            //                             'Failed to delete student: $e')),
                            //                   );
                            //                 }
                            //               },
                            //               icon: const Icon(
                            //                 Icons.delete,
                            //                 color: Colors.red,
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //         // SizedBox(
                            //   height: 10,
                            // ),
                            // Text(
                            //   'Gender: ${studentList![index].gender}',
                            //   style: TextStyle(
                            //     fontSize: 16,
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Text(
                            //   'Address: ${studentList![index].address}',
                            //   style: TextStyle(
                            //     fontSize: 16,
                            //   ),
                            // ),
                            //       ],
                            //     ),
                            //   ),
                            // );
                          })
                      // Container(
                      //   margin: const EdgeInsets.symmetric(
                      //       horizontal: 10.0, vertical: 20.0),
                      //   child: SingleChildScrollView(
                      //     scrollDirection: Axis.vertical,
                      //     child: Table(
                      //       border: TableBorder.all(),
                      //       columnWidths: const <int, TableColumnWidth>{
                      //         1: FixedColumnWidth(140),
                      //       },
                      //       defaultVerticalAlignment:
                      //           TableCellVerticalAlignment.middle,
                      //       children: [
                      //         // if (storedocs.isNotEmpty) ...{
                      //         TableRow(
                      //           children: [
                      //             TableCell(
                      //               child: Container(
                      //                 color: const Color.fromARGB(
                      //                     255, 207, 235, 255),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'Name',
                      //                     style: TextStyle(
                      //                       fontSize: 20.0,
                      //                       fontWeight: FontWeight.bold,
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             TableCell(
                      //               child: Container(
                      //                 color: const Color.fromARGB(
                      //                     255, 207, 235, 255),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'Enrollment',
                      //                     style: TextStyle(
                      //                       fontSize: 20.0,
                      //                       fontWeight: FontWeight.bold,
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             TableCell(
                      //               child: Container(
                      //                 color: const Color.fromARGB(
                      //                     255, 207, 235, 255),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'Action',
                      //                     style: TextStyle(
                      //                       fontSize: 20.0,
                      //                       fontWeight: FontWeight.bold,
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         for (var i = 0; i < storedocs.length; i++) ...[
                      //           TableRow(
                      //             children: [
                      //               TableCell(
                      //                 child: Center(
                      //                     child: Text(storedocs[i]['name'],
                      //                         style:
                      //                             TextStyle(fontSize: 18.0))),
                      //               ),
                      //               TableCell(
                      //                 child: Center(
                      //                     child: Text(storedocs[i]['number'],
                      //                         style:
                      //                             TextStyle(fontSize: 18.0))),
                      //               ),
                      //               TableCell(
                      //                 child: Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.center,
                      //                   children: [
                      //                     IconButton(
                      //                       onPressed: () => {
                      //                         Navigator.push(
                      //                           context,
                      //                           MaterialPageRoute(
                      //                             builder: (context) =>
                      //                                 UpdateStudentPage(
                      //                                     id: storedocs[i]
                      //                                         ['id']),
                      //                           ),
                      //                         )
                      //                       },
                      //                       icon: const Icon(
                      //                         Icons.edit,
                      //                         color: Colors.orangeAccent,
                      //                       ),
                      //                     ),
                      //                     IconButton(
                      //                       onPressed: () => {
                      //                         deleteUser(storedocs[i]['id'])
                      //                       },
                      //                       icon: const Icon(
                      //                         Icons.delete,
                      //                         color: Colors.red,
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ],
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      : Center(
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                "assets/images/No data.png",
                              ),
                              const Text(
                                "No data",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),

              // )),
              floatingActionButton: FloatingActionButton(
                // backgroundColor: const Color.fromARGB(255, 207, 235, 255),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddStudentPage(),
                    ),
                  )
                },
                child: const Icon(Icons.add),
              ),
            ),
          );
        });
  }
}
