import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_parents/components/constants.dart';
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

  Stream<QuerySnapshot> parentsStream =
      FirebaseFirestore.instance.collection('Admin/$admin/parents').snapshots();

  @override
  void initState() {
    super.initState();
    login();
  }

  // For Deleting User
  CollectionReference parents =
      FirebaseFirestore.instance.collection('Admin/$admin/parents');
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

          return
              // MaterialApp(
              // debugShowCheckedModeBanner: false,
              // theme: ThemeData(
              //   primarySwatch: Colors.lightBlue,
              // ),
              // home:
              Scaffold(
            appBar: AppBar(
              // backgroundColor: const Color.fromARGB(255, 207, 235, 255),
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                tooltip: "Back",
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: const Text("Parents Details",
                  style: TextStyle(fontSize: 30.0)),
            ),
            body: storedocs.isNotEmpty
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
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '${index + 1}',
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          '${storedocs[index]['number']}',
                                          // Enrollment[index],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0),
                                        ),
                                        Text(
                                          'Name: ${storedocs[index]['name']}',
                                          // Students[index],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      const Text("Delete"),
                                      IconButton(
                                        highlightColor: Colors.red,
                                        onPressed: () async {
                                          try {
                                            // await delete(storedocs[index]
                                            //         ['number'] +
                                            //     '@sps.com');
                                            deleteUser(storedocs[index]['id']);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content:
                                                      Text('Student deleted.')),
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
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => UpdateParentPage(
                                            id: storedocs[index]['id'])),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.grey[600],
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    fixedSize: const Size(200, 40),
                                    elevation: 5,
                                    textStyle: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500)),
                                child: const Text("Edit"),
                              )
                            ],
                          ),
                        ),
                      );
                    })
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
            floatingActionButton: FloatingActionButton(
              // backgroundColor: const Color.fromARGB(255, 207, 235, 255),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddParentPage(),
                  ),
                )
              },
              child: const Icon(Icons.add),
            ),
            // ),
          );
        });
  }
}
