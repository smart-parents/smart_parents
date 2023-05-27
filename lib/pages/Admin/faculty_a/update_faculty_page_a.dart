// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_parents/components/constants.dart';

class UpdateFacultyPage extends StatefulWidget {
  final String id;
  const UpdateFacultyPage({Key? key, required this.id}) : super(key: key);
  @override
  _UpdateFacultyPageState createState() => _UpdateFacultyPageState();
}

class _UpdateFacultyPageState extends State<UpdateFacultyPage> {
  final _form1Key = GlobalKey<FormState>();
  var Branch;
  // Updaing Student
  CollectionReference facultys =
      FirebaseFirestore.instance.collection('Admin/$admin/faculty');

  Future<void> updateUser(id, name, branch) {
    return facultys
        .doc(id)
        .update({
          'name': name,
          'branch': branch,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Faculty"),
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
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            // final items = snapshot.data.docs.map((doc) => doc.data()['name']).toList();
            final items =
                snapshot.data!.docs.map((doc) => doc.get('name')).toList();
            return Form(
              key: _form1Key,
              // Getting Specific Data by ID
              child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('Admin/$admin/faculty')
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
                  // Branch = data['branch'];
                  // var password = data['password'];
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
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            value: Branch,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            hint: const Text('Select an item'),
                            icon:
                                const Icon(Icons.keyboard_arrow_down_outlined),
                            elevation: 16,
                            dropdownColor: Colors.grey[100],
                            style: const TextStyle(color: Colors.black),
                            // underline:
                            //     Container(height: 0, color: Colors.black),
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
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a branch';
                              }
                              return null; // return null if there's no error
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: TextFormField(
                            readOnly: true,
                            maxLength: 4,
                            initialValue: faculty,
                            autofocus: false,
                            onChanged: (value) => faculty = value,
                            decoration: const InputDecoration(
                              labelText: 'Faculty Id: ',
                              labelStyle: TextStyle(fontSize: 20.0),
                              border: OutlineInputBorder(),
                              errorStyle: TextStyle(fontSize: 15),
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
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
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
                        // Container(
                        //   margin: const EdgeInsets.symmetric(vertical: 10.0),
                        //   child: TextFormField(
                        //     readOnly: true,
                        //     // maxLength: 2,
                        //     initialValue: branch,
                        //     autofocus: false,
                        //     onChanged: (value) => branch = value,
                        //     decoration: const InputDecoration(
                        //       labelText: 'Branch: ',
                        //       labelStyle: TextStyle(fontSize: 20.0),
                        //       border: OutlineInputBorder(),
                        //       errorStyle: TextStyle(fontSize: 15),
                        //     ),
                        //     validator: (value) {
                        //       if (value == null || value.isEmpty) {
                        //         return 'Please Enter Department Id';
                        //       }
                        //       return null;
                        //     },
                        //   ),
                        // ),
                        // Container(
                        //   margin: const EdgeInsets.symmetric(vertical: 10.0),
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Validate returns true if the form is valid, otherwise false.
                                if (_form1Key.currentState!.validate()) {
                                  updateUser(
                                    widget.id,
                                    name,
                                    Branch,
                                  );
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
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
