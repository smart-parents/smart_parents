// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_parents/pages/Faculty/attendencepages/util/names.dart';
import 'package:smart_parents/widgest/dropDownWidget.dart';
import 'package:smart_parents/components/constants.dart';

class DropdownDemo extends StatefulWidget {
  const DropdownDemo({Key? key}) : super(key: key);
  @override
  State<DropdownDemo> createState() => _DropdownDemoState();
}

class _DropdownDemoState extends State<DropdownDemo> {
  String? Branch;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Notice ", style: TextStyle(fontSize: 30.0)),
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
              final items =
                  snapshot.data!.docs.map((doc) => doc.get('name')).toList();
              return ListView(
                  // Step 2.
                  // DropdownButton<String>(
                  //   // Step 3.
                  //   value: dropdownValue,
                  //   // Step 4.
                  //   items: <String>[
                  //     'Branch',
                  //     'It',
                  //     'Computer',
                  //     'Sivil',
                  //     'Mechanical',
                  //     'AutoMobile',
                  //     'Electric'
                  //   ].map<DropdownMenuItem<String>>((String value) {
                  //     return DropdownMenuItem<String>(
                  //       value: value,
                  //       child: Text(
                  //         value,
                  //         style: TextStyle(fontSize: 20),
                  //       ),
                  //     );
                  //   }).toList(),
                  //   // Step 5.
                  //   onChanged: (String? newValue) {
                  //     setState(() {
                  //       dropdownValue = newValue!;
                  //     });
                  //   },
                  // ),ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          // dropdown(
                          //     DropdownValue: items.toString(),
                          //     sTring: Branch,
                          //     Hint: "Branch"),
                          Column(
                            children: [
                              const Text(
                                "Branch",
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
                            ],
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
                          TextFormField(
                            // minLines: 1,
                            // maxLines: null,
                            // controller: project_description_controller_r,
                            decoration: const InputDecoration(
                                // enabledBorder: InputBorder.none,
                                // focusedBorder: InputBorder.none,
                                hintText: "Enter notice topic:",
                                hintStyle: TextStyle(fontSize: 18)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter notice topic:';
                              }
                              return null;
                            },
                            // keyboardType: TextInputType.multiline,
                          ),
                          // Column(
                          //   children: [
                          //     SizedBox(
                          //       height: 30,
                          //     ),
                          //     // Step 2.
                          //     DropdownButton<String>(
                          //       // Step 3.
                          //       value: dropdownValue2,
                          //       // Step 4.
                          //       items: <String>['Sem', '1', '2', '3', '4', '5', '6', '7', '8']
                          //           .map<DropdownMenuItem<String>>((String value) {
                          //         return DropdownMenuItem<String>(
                          //           value: value,
                          //           child: Text(
                          //             value,
                          //             style: TextStyle(fontSize: 20),
                          //           ),
                          //         );
                          //       }).toList(),
                          //       // Step 5.
                          //       onChanged: (String? newValue) {
                          //         setState(() {
                          //           dropdownValue = newValue!;
                          //         });
                          //       },
                          //     ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Text(
                          //   'Selected Value: $dropdownValue',
                          //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                          // )
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // const TextField(
                                //   maxLines: null,
                                //   keyboardType: TextInputType.multiline,
                                //   decoration: InputDecoration(
                                //     focusedBorder: OutlineInputBorder(),
                                //     border: OutlineInputBorder(),
                                //     // contentPadding: EdgeInsets.fromLTRB(10.0, 100.0, 10.0, 100.0),
                                //   ),
                                // ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  padding: const EdgeInsets.only(
                                      left: 15, bottom: 10),
                                  margin: const EdgeInsets.only(
                                      left: 20, top: 20, right: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        style: BorderStyle.solid,
                                        color: Colors.grey),
                                  ),
                                  child: TextFormField(
                                    minLines: 1,
                                    maxLines: null,
                                    // controller: project_description_controller_r,
                                    decoration: const InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: "Enter notice",
                                        hintStyle: TextStyle(fontSize: 18)),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter notice';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.multiline,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Add Notice",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]);
            }),
      ),
    );
  }
}
