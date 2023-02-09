import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_parents/pages/Faculty/parents_a/add_parents_page_a.dart';
import 'package:smart_parents/pages/Faculty/parents_a/update_parents_page_a.dart';

class Parent extends StatefulWidget {
  const Parent({Key? key}) : super(key: key);

  // void initState() {
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
  //     // SystemUiOverlay.bottom,
  //   ]);
  // }

  @override
  State<Parent> createState() => _ParentState();
}

class _ParentState extends State<Parent> {
  // final email = FirebaseAuth.instance.currentUser!.email;

  // static Stream<QuerySnapshot> parentsStream =
  //     FirebaseFirestore.instance.collection('students').snapshots();
  late Stream<QuerySnapshot> parentsStream;
  void myMethod() {
    if (FirebaseAuth.instance.currentUser != null) {
      final email = FirebaseAuth.instance.currentUser!.email;
      parentsStream = FirebaseFirestore.instance
          .collection('parents')
          .where("admin", isEqualTo: email)
          .snapshots();
    }
  }

  @override
  void initState() {
    super.initState();
    login();
    myMethod();
  }

  // For Deleting User
  CollectionReference parents =
      FirebaseFirestore.instance.collection('parents');
  Future<void> deleteUser(id) {
    // print("User Deleted $id");
    return parents
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  final _prefs = SharedPreferences.getInstance();
  login() async {
    FirebaseAuth.instance.signOut();
    final SharedPreferences prefs = await _prefs;
    String? email = prefs.getString('faculty');
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
    // myMethod();
    return StreamBuilder<QuerySnapshot>(
        stream: parentsStream,
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
                title: const Text("Parents Details",
                    style: TextStyle(fontSize: 30.0)),
              ),
              body: Center(
                  child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    // const Text("Student", style: TextStyle(fontSize: 30.0)),
                    if (storedocs.isNotEmpty) ...{
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
                              // if (storedocs.isNotEmpty) ...{
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      color: const Color.fromARGB(
                                          255, 207, 235, 255),
                                      child: const Center(
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
                                      color: const Color.fromARGB(
                                          255, 207, 235, 255),
                                      child: const Center(
                                        child: Text(
                                          'Mobile Number',
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
                                      color: const Color.fromARGB(
                                          255, 207, 235, 255),
                                      child: const Center(
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
                                              style:
                                                  TextStyle(fontSize: 18.0))),
                                    ),
                                    TableCell(
                                      child: Center(
                                          child: Text(storedocs[i]['number'],
                                              style:
                                                  TextStyle(fontSize: 18.0))),
                                    ),
                                    TableCell(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () => {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateParentPage(
                                                          id: storedocs[i]
                                                              ['id']),
                                                ),
                                              )
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Colors.orangeAccent,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () => {
                                              deleteUser(storedocs[i]['id'])
                                            },
                                            icon: const Icon(
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
                    } else ...{
                      Image.asset(
                        "assets/images/No data.png",
                      ),
                      const Text(
                        "No data",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    }
                  ])),
              floatingActionButton: FloatingActionButton(
                // backgroundColor: const Color.fromARGB(255, 207, 235, 255),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddParentPage(),
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
