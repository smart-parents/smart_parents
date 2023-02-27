import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_parents/pages/Admin/faculty_a/add_faculty_page_a.dart';
import 'package:smart_parents/pages/Admin/faculty_a/update_faculty_page_a.dart';
import 'package:flutter/material.dart';
import 'package:smart_parents/components/constants.dart';

class Faculty extends StatefulWidget {
  const Faculty({Key? key}) : super(key: key);

  @override
  State<Faculty> createState() => _FacultyState();
}

class _FacultyState extends State<Faculty> {
  @override
  void initState() {
    super.initState();
    login();
  }

  Stream<QuerySnapshot>? facultyStream =
      FirebaseFirestore.instance.collection('Admin/$admin/faculty').snapshots();

  // For Deleting User
  CollectionReference facultys =
      FirebaseFirestore.instance.collection('Admin/$admin/faculty');
  Future<void> deleteUser(id) {
    // print("User Deleted $id");
    return facultys
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  Future<void> updateStatus(id, status) async {
    facultys
        .doc(id)
        .update({'status': status})
        .then((value) => print('Status: $status'))
        .catchError((error) => print('Failed to update status: $error'));
    users
        .doc(id)
        .update({'status': status})
        .then((value) => print('Status: $status'))
        .catchError((error) => print('Failed to update status: $error'));
  }

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
    return StreamBuilder<QuerySnapshot>(
        stream: facultyStream,
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
              //  MaterialApp(
              // debugShowCheckedModeBanner: false,
              // theme: ThemeData(
              //   primarySwatch: Colors.lightBlue,
              // ),
              // home:
              Scaffold(
            appBar: AppBar(
              // backgroundColor: const Color.fromARGB(255, 207, 235, 255),
              // automaticallyImplyLeading: false,
              leading: const BackButton(),
              // leading: IconButton(
              //   icon: const Icon(Icons.arrow_back),
              //   tooltip: "Back",
              //   onPressed: () => Navigator.of(context).pop(),
              // ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Faculty Details", style: TextStyle(fontSize: 30.0)),
                  //    IconButton(
                  //   icon: const Icon(Icons.sort_rounded),
                  //   tooltip: "Filter",
                  //   onPressed: () => AlertDialog(

                  //   ),
                  // ),
                ],
              ),
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
                                          '${storedocs[index]['faculty']}',
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
                                      Switch(
                                        value: storedocs[index]['status'],
                                        onChanged: (value) {
                                          setState(() {
                                            // _status = value;
                                            updateStatus(
                                                storedocs[index]['id'], value);
                                          });
                                        },
                                      ),
                                      Text(
                                        storedocs[index]['status']
                                            ? 'Active'
                                            : 'Disactive',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: storedocs[index]['status']
                                                ? Colors.green
                                                : Colors.red),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          'email : ${storedocs[index]['email']}',
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                        Text(
                                          'Mo: ${storedocs[index]['mono']}',
                                          style: const TextStyle(fontSize: 13),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Branch : ${storedocs[index]['branch']}',
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    ),
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
                                        builder: (context) => UpdateFacultyPage(
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
                    builder: (context) => const AddFacultyPage(),
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
