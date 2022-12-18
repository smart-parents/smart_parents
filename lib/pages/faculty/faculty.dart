import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_parents/pages/faculty/add_faculty_page.dart';
import 'package:smart_parents/pages/faculty/update_faculty_page.dart';
import 'package:flutter/material.dart';

class Faculty extends StatefulWidget {
  const Faculty({Key? key}) : super(key: key);

  @override
  State<Faculty> createState() => _FacultyState();
}

class _FacultyState extends State<Faculty> {
  final Stream<QuerySnapshot> facultyStream =
      FirebaseFirestore.instance.collection('faculty').snapshots();

  // For Deleting User
  CollectionReference facultys =
      FirebaseFirestore.instance.collection('faculty');
  Future<void> deleteUser(id) {
    // print("User Deleted $id");
    return facultys
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: facultyStream,
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
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 207, 235, 255),
                automaticallyImplyLeading: false,
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back),
                  tooltip: "Back",
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: const Text("Faculty Details",
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
                        
                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                color: const Color.fromARGB(255, 207, 235, 255),
                                child: Center(
                                  child: Text(
                                    'Faculty',
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
                                    'Name',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // TableCell(
                            //   child: Container(
                            //     color: const Color.fromARGB(255, 207, 235, 255),
                            //     child: Center(
                            //       child: Text(
                            //         'Department',
                            //         style: TextStyle(
                            //           fontSize: 20.0,
                            //           fontWeight: FontWeight.bold,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
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
                                    child: Text(storedocs[i]['faculty'],
                                        style: TextStyle(fontSize: 18.0))),
                              ),
                              TableCell(
                                child: Center(
                                    child: Text(storedocs[i]['name'],
                                        style: TextStyle(fontSize: 18.0))),
                              ),
                              // TableCell(
                              //   child: Center(
                              //       child: Text(storedocs[i]['department'],
                              //           style: TextStyle(fontSize: 18.0))),
                              // ),
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
                                                UpdateFacultyPage(
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
                      builder: (context) => AddFacultyPage(),
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
