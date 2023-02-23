// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddFacultyPage extends StatefulWidget {
  const AddFacultyPage({Key? key}) : super(key: key);
// void initState() {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
//       // SystemUiOverlay.bottom,
//     ]);
// }
  @override
  _AddFacultyPageState createState() => _AddFacultyPageState();
}

class _AddFacultyPageState extends State<AddFacultyPage> {
  final _formKey = GlobalKey<FormState>();
  final _prefs = SharedPreferences.getInstance();
  String? email;
  // final email = FirebaseAuth.instance.currentUser!.email;
  var faculty = "";
  var name = "";
  var Branch;
  var password = "";

  @override
  void initState() {
    super.initState();
    login();
  }
  // Create a text controller and use it to retrieve the current value
  // of the TextField.

  final facultyController = TextEditingController();
  final nameController = TextEditingController();
  final branchController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    facultyController.dispose();
    nameController.dispose();
    branchController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  clearText() async {
    facultyController.clear();
    nameController.clear();
    branchController.clear();
    passwordController.clear();
  }

  // Adding Student
  CollectionReference facultys =
      FirebaseFirestore.instance.collection('faculty');

  Future<void> addUser() {
    return facultys
        .doc(faculty)
        .set({
          'faculty': faculty,
          'name': name,
          // 'department': department,
          'password': password,
          'admin': email,
          'branch': Branch,
          'status': true
        })
        .then((value) => print('faculty Added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }

  registration() async {
    try {
      FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: "$faculty@spf.com", password: password);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.lightBlueAccent,
          content: Text(
            "Faculty Added.",
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
        ),
      );
      addUser();
      clearText();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const Faculty(),
      //   ),
      // );
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'weak-password') {
        print("Password Provided is too Weak");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.lightBlueAccent,
            content: Text(
              "Password Provided is too Weak",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        print("Faculty Already exists");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.lightBlueAccent,
            content: Text(
              "Faculty Already exists",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      }
    }
    login();
    Navigator.pop(context);
  }

  login() async {
    FirebaseAuth.instance.signOut();
    final SharedPreferences prefs = await _prefs;
    email = prefs.getString('email');
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
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add New Faculty"),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: "Back",
            onPressed: () => Navigator.pop(context),
          ),
          // backgroundColor: const Color.fromARGB(255, 207, 235, 255),
        ),
        body: Center(
          child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('department').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                // final items = snapshot.data.docs.map((doc) => doc.data()['name']).toList();
                final items =
                    snapshot.data!.docs.map((doc) => doc.get('name')).toList();

                return Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: ListView(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                  width: 0.80),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(
                                    5.0,
                                    5.0,
                                  ),
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0,
                                ),
                              ]),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            // hint: Text(hint,style: TextStyle(color: Colors.black),),
                            value: Branch,
                            hint: const Text('Select an item'),
                            icon:
                                const Icon(Icons.keyboard_arrow_down_outlined),
                            elevation: 16,
                            dropdownColor: Colors.grey[100],
                            style: const TextStyle(color: Colors.black),
                            underline:
                                Container(height: 0, color: Colors.black),
                            onChanged: (value) {
                              setState(() {
                                Branch = value;
                              });
                            },
                            items: items.map((item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: TextFormField(
                            maxLength: 4,
                            autofocus: false,
                            decoration: const InputDecoration(
                              labelText: 'Faculty Id: ',
                              labelStyle: TextStyle(fontSize: 20.0),
                              border: OutlineInputBorder(),
                              errorStyle: TextStyle(
                                  color: Colors.lightBlueAccent, fontSize: 15),
                            ),
                            keyboardType: TextInputType.number,
                            controller: facultyController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Faculty Id';
                              } else if (value.length != 4) {
                                return 'Please Enter Valid Faculty Id';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: TextFormField(
                            autofocus: false,
                            decoration: const InputDecoration(
                              labelText: 'Name: ',
                              labelStyle: TextStyle(fontSize: 20.0),
                              border: OutlineInputBorder(),
                              errorStyle: TextStyle(
                                  color: Colors.lightBlueAccent, fontSize: 15),
                            ),
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Name';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: TextFormField(
                            autofocus: false,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Password: ',
                              labelStyle: TextStyle(fontSize: 20.0),
                              border: OutlineInputBorder(),
                              errorStyle: TextStyle(
                                  color: Colors.lightBlueAccent, fontSize: 15),
                            ),
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Password';
                              }
                              return null;
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Validate returns true if the form is valid, otherwise false.
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    faculty = facultyController.text;
                                    name = nameController.text;
                                    // department = departmentController.text;
                                    password = passwordController.text;

                                    // addUser();
                                    // clearText();
                                    registration();
                                    // Navigator.pop(context);
                                  });
                                }
                                login();
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => {clearText()},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueGrey),
                              child: const Text(
                                'Reset',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
        ));
  }
}
