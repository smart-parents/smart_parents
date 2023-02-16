import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddDepartPage extends StatefulWidget {
  const AddDepartPage({Key? key}) : super(key: key);
// void initState() {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
//       // SystemUiOverlay.bottom,
//     ]);
// }
  @override
  _AddDepartPageState createState() => _AddDepartPageState();
}

class _AddDepartPageState extends State<AddDepartPage> {
  final _formKey = GlobalKey<FormState>();
  // final _prefs = SharedPreferences.getInstance();
  String? email;
  // final email = FirebaseAuth.instance.currentUser!.email;
  var name = "";
  var departmentId = "";

  @override
  void initState() {
    login();
    super.initState();
  }
  // Create a text controller and use it to retrieve the current value
  // of the TextField.

  final nameController = TextEditingController();
  final departmentController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    departmentController.dispose();
    super.dispose();
  }

  clearText() async {
    nameController.clear();
    departmentController.clear();
  }

  final _prefs = SharedPreferences.getInstance();
  login() async {
    final SharedPreferences prefs = await _prefs;
    email = prefs.getString('email');
  }

  // Adding Student
  CollectionReference department =
      FirebaseFirestore.instance.collection('department');

  Future<void> addUser() {
    return department
        .doc("${departmentId}_$email")
        .set({'name': name, 'departmentId': departmentId, 'admin': email})
        .then((value) => print('department Added'))
        .catchError((error) => print('Failed to Add department: $error'));
  }

  // registration() async {
  //   // FirebaseAuth.instance.createUserWithEmailAndPassword(
  //   //     email: "$faculty@spf.com", password: password);

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       backgroundColor: Colors.lightBlueAccent,
  //       content: Text(
  //         "Faculty Added.",
  //         style: TextStyle(fontSize: 20.0, color: Colors.black),
  //       ),
  //     ),
  //   );
  //   addUser();
  //   clearText();
  //   // Navigator.push(
  //   //   context,
  //   //   MaterialPageRoute(
  //   //     builder: (context) => const Faculty(),
  //   //   ),
  //   // );

  //   Navigator.pop(context);
  // }

  // login() async {
  //   FirebaseAuth.instance.signOut();
  //   final SharedPreferences prefs = await _prefs;
  //   email = prefs.getString('email');
  //   String? pass = prefs.getString('pass');
  //   print("signout");
  //   try {
  //     FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: "$email", password: "$pass")
  //         .then(
  //           (value) => print("login $email"),
  //         );
  //     print("login");
  //   } on FirebaseAuthException catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // login();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Department"),
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          tooltip: "Back",
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color.fromARGB(255, 207, 235, 255),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  maxLength: 2,
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Department Id: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.lightBlueAccent, fontSize: 15),
                  ),
                  keyboardType: TextInputType.number,
                  controller: departmentController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Faculty Id';
                    } else if (value.length != 2) {
                      return 'Please Enter Valid Faculty Id';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Department Name: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.lightBlueAccent, fontSize: 15),
                  ),
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Department Name';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            name = nameController.text;
                            departmentId = departmentController.text;
                            addUser();
                            clearText();
                            // registration();
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Department Added.')));
                          });
                        }
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => {clearText()},
                      child: Text(
                        'Reset',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
