import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateFacultyPage extends StatefulWidget {
  final String id;
  UpdateFacultyPage({Key? key, required this.id}) : super(key: key);
// void initState() {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
//       // SystemUiOverlay.bottom,
//     ]);
// }
  @override
  _UpdateFacultyPageState createState() => _UpdateFacultyPageState();
}

class _UpdateFacultyPageState extends State<UpdateFacultyPage> {
  final _form1Key = GlobalKey<FormState>();

  // Updaing Student
  CollectionReference facultys =
      FirebaseFirestore.instance.collection('faculty');

  Future<void> updateUser(id, faculty, name, department, password) {
    return facultys
        .doc(id)
        .update({
          'faculty': faculty,
          'name': name,
          'department': department,
          'password': password
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Faculty"),
        automaticallyImplyLeading: false,
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back),
                  tooltip: "Back",
                  onPressed: () => Navigator.of(context).pop(),
                ),
        backgroundColor: const Color.fromARGB(255, 207, 235, 255),
      ),
      body: Form(
          key: _form1Key,
          // Getting Specific Data by ID
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('faculty')
                .doc(widget.id)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print('Something Went Wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.data();
              var name = data!['name'];
              var faculty = data['faculty'];
              var department = data['department'];
              var password = data['password'];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        maxLength: 4,
                        initialValue: faculty,
                        autofocus: false,
                        onChanged: (value) => faculty = value,
                        decoration: InputDecoration(
                          labelText: 'Faculty Id: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(
                              color: Colors.lightBlueAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Faclty Id';
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
                        initialValue: name,
                        autofocus: false,
                        onChanged: (value) => name = value,
                        decoration: InputDecoration(
                          labelText: 'Name: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(
                              color: Colors.lightBlueAccent, fontSize: 15),
                        ),
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
                        initialValue: department,
                        autofocus: false,
                        onChanged: (value) => department = value,
                        decoration: InputDecoration(
                          labelText: 'Department Id: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(
                              color: Colors.lightBlueAccent, fontSize: 15),
                        ),
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
                        initialValue: password,
                        autofocus: false,
                        onChanged: (value) => password = value,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(
                              color: Colors.lightBlueAccent, fontSize: 15),
                        ),
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
                              if (_form1Key.currentState!.validate()) {
                                updateUser(widget.id, faculty, name, department,
                                    password);
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              'Update',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          // ElevatedButton(
                          //   onPressed: () => {clearText()},
                          //   style: ElevatedButton.styleFrom(
                          //       backgroundColor: Colors.blueGrey),
                          //   child: const Text(
                          //     'Reset',
                          //     style: TextStyle(fontSize: 18.0),
                          //   ),
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
