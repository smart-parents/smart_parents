import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_parents/pages/student/add_student_page.dart';
import 'package:smart_parents/pages/student/update_student_page.dart';
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
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('students').snapshots();

  // For Deleting User
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');
  Future<void> deleteUser(id) {
    // print("User Deleted $id");
    return students
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
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
              // appBar: PreferredSize(
              //   preferredSize: Size.fromHeight(20.0), // here the desired height
              //   child: AppBar(
              //     title: Row(
              //       children: [
              //         Text("Student Data:"),
              //       ],
              //     ),
              //   ),
              // ),
              // appBar: AppBar(
              //   title: Container(
              //       child: Text("Student Data:"),
              //   ),
              // ),
              // appBar: AppBar(
              //   title: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text("Data:"),
              //       ElevatedButton(
              //         onPressed: () => {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => AddStudentPage(),
              //             ),
              //           )
              //         },
              //         child: Text('Add', style: TextStyle(fontSize: 20.0)),
              //         style: ElevatedButton.styleFrom(primary: Colors.lime),
              //       ),
              //     ],
              //   ),
              // ),
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 207, 235, 255),
                automaticallyImplyLeading: false,
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back),
                  tooltip: "Back",
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: const Text("Student Details",
                    style: TextStyle(fontSize: 30.0)),
              ),
              body: Center(
                  child: Column(children: <Widget>[
                // const Text("Student", style: TextStyle(fontSize: 30.0)),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Table(
                      border: TableBorder.all(),
                      columnWidths: const <int, TableColumnWidth>{
                        1: FixedColumnWidth(140),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        // TableRow(
                        //   children: [
                        //     TableCell(
                        //       child: Container(
                        //         color: Colors.lightBlueAccent,
                        //         child: Center(
                        //           child: Text(
                        //             'Data:',
                        //             style: TextStyle(
                        //               fontSize: 20.0,
                        //               fontWeight: FontWeight.bold,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     TableCell(
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           IconButton(
                        //             onPressed: () => {
                        //               Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                   builder: (context) => AddStudentPage(),
                        //                 ),
                        //               )
                        //             },
                        //             icon: Icon(
                        //               Icons.add,
                        //               color: Colors.lightBlueAccent,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                color: const Color.fromARGB(255, 207, 235, 255),
                                child: Center(
                                  child: Text(
                                    'Name',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                color: const Color.fromARGB(255, 207, 235, 255),
                                child: Center(
                                  child: Text(
                                    'Enrollment',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                color: const Color.fromARGB(255, 207, 235, 255),
                                child: Center(
                                  child: Text(
                                    'Action',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        for (var i = 0; i < storedocs.length; i++) ...[
                          TableRow(
                            children: [
                              TableCell(
                                child: Center(
                                    child: Text(storedocs[i]['name'],
                                        style: TextStyle(fontSize: 18.0))),
                              ),
                              TableCell(
                                child: Center(
                                    child: Text(storedocs[i]['number'],
                                        style: TextStyle(fontSize: 18.0))),
                              ),
                              TableCell(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () => {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateStudentPage(
                                                    id: storedocs[i]['id']),
                                          ),
                                        )
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.orangeAccent,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () =>
                                          {deleteUser(storedocs[i]['id'])},
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ])),
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
