import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddFacultyPage extends StatefulWidget {
  AddFacultyPage({Key? key}) : super(key: key);
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

  var faculty = "";
  var name = "";
  var department = "";
  var password = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.

  final facultyController = TextEditingController();
  final nameController = TextEditingController();
  final departmentController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    facultyController.dispose();
    nameController.dispose();
    departmentController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  clearText() {
    facultyController.clear();
    nameController.clear();
    departmentController.clear();
    passwordController.clear();
  }

  // Adding Student
  CollectionReference facultys =
      FirebaseFirestore.instance.collection('faculty');

  Future<void> addUser() {
    return facultys
        .add({'faculty': faculty, 'name': name, 'department': department, 'password': password})
        .then((value) => print('User Added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Faculty"),
        automaticallyImplyLeading: false,
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back),
                  tooltip: "Back",
                  onPressed: () => Navigator.of(context).pop(),
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
                  maxLength: 4,
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Faculty Id: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.lightBlueAccent, fontSize: 15),
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
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Name: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.lightBlueAccent, fontSize: 15),
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
                      return 'Please Enter Department Id';
                    } else if (value.length != 2) {
                      return 'Please Enter Valid Department Id';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.lightBlueAccent, fontSize: 15),
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
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            faculty = facultyController.text;
                            name = nameController.text;
                            department = departmentController.text;
                            password = passwordController.text;
                            addUser();
                            clearText();
                            Navigator.pop(context);
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
