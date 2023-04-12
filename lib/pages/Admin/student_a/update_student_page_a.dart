// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/widgest/dropDownWidget.dart';

class UpdateStudentPage extends StatefulWidget {
  final String id;
  const UpdateStudentPage({Key? key, required this.id}) : super(key: key);
  @override
  _UpdateStudentPageState createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  final _formKey = GlobalKey<FormState>();
  String? Branch;

  // Updaing Student
  CollectionReference students =
      FirebaseFirestore.instance.collection('Admin/$admin/students');

  Future<void> updateUser(id, name, branch, sem) async {
    students
        .doc(id)
        .update({'name': name, 'branch': Branch, 'sem': semesterdropdownValue})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Update Student"),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: "Back",
            onPressed: () => Navigator.of(context).pop(),
          ),
          // backgroundColor: const Color.fromARGB(255, 207, 235, 255),
        ),
        body: Center(
            child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('Admin/$admin/department')
                    .where("number")
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  // final items = snapshot.data.docs.map((doc) => doc.data()['name']).toList();
                  final items = snapshot.data!.docs
                      .map((doc) => doc.get('name'))
                      .toList();
                  return Form(
                      key: _formKey,
                      // Getting Specific Data by ID
                      child:
                          FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        future: FirebaseFirestore.instance
                            .collection('Admin/$admin/students')
                            .doc(widget.id)
                            .get(),
                        builder: (_, snapshot) {
                          if (snapshot.hasError) {
                            print('Something Went Wrong');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          var data = snapshot.data!.data();
                          var name = data!['name'];
                          var number = data['number'];
                          // var password = data['password'];
                          // Branch = data['branch'];
                          semesterdropdownValue = data['sem'];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 30),
                            child: ListView(
                              children: [
                                const Text(
                                  'Branch',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
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
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_outlined),
                                    elevation: 16,
                                    dropdownColor: Colors.grey[100],
                                    style: const TextStyle(color: Colors.black),
                                    underline: Container(
                                        height: 0, color: Colors.black),
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
                                dropdown(
                                    DropdownValue: semesterdropdownValue,
                                    sTring: Semester,
                                    Hint: "Semester"),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: TextFormField(
                                    initialValue: name,
                                    autofocus: false,
                                    onChanged: (value) => name = value,
                                    decoration: const InputDecoration(
                                      labelText: 'Name: ',
                                      labelStyle: TextStyle(fontSize: 20.0),
                                      border: OutlineInputBorder(),
                                      errorStyle: TextStyle(fontSize: 15),
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
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: TextFormField(
                                    readOnly: true,
                                    maxLength: 12,
                                    initialValue: number,
                                    autofocus: false,
                                    onChanged: (value) => number = value,
                                    decoration: const InputDecoration(
                                      labelText: 'Enrollment Number: ',
                                      labelStyle: TextStyle(fontSize: 20.0),
                                      border: OutlineInputBorder(),
                                      errorStyle: TextStyle(fontSize: 15),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Enrollment Number';
                                      } else if (value.length != 12) {
                                        return 'Please Enter Valid Enrollment Number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                // Container(
                                //   margin: const EdgeInsets.symmetric(
                                //       vertical: 10.0),
                                //   child: TextFormField(
                                //     initialValue: password,
                                //     autofocus: false,
                                //     onChanged: (value) => password = value,
                                //     obscureText: true,
                                //     decoration: const InputDecoration(
                                //       labelText: 'Password: ',
                                //       labelStyle: TextStyle(fontSize: 20.0),
                                //       border: OutlineInputBorder(),
                                //       errorStyle: TextStyle(fontSize: 15),
                                //     ),
                                //     validator: (value) {
                                //       if (value == null || value.isEmpty) {
                                //         return 'Please Enter Password';
                                //       }
                                //       return null;
                                //     },
                                //   ),
                                // ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Validate returns true if the form is valid, otherwise false.
                                        if (_formKey.currentState!.validate()) {
                                          updateUser(widget.id, name, Branch,
                                              semesterdropdownValue);
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: const Text(
                                        'Update',
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                    ),
                                    // ElevatedButton(
                                    //   onPressed: () => {},
                                    //   style: ElevatedButton.styleFrom(
                                    //       backgroundColor: Colors.blueGrey),
                                    //   child: const Text(
                                    //     'Reset',
                                    //     style: TextStyle(fontSize: 18.0),
                                    //   ),
                                    // ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ));
                })));
  }
}
