// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, non_constant_identifier_names, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/pages/Faculty/Show_Stu/student_f.dart';
import 'package:smart_parents/pages/Faculty/attendencepages/util/names.dart';
import 'package:smart_parents/widgest/dropDownWidget.dart';

class Show_stu extends StatefulWidget {
  const Show_stu({Key? key}) : super(key: key);

  @override
  _Show_stuState createState() => _Show_stuState();
}

class _Show_stuState extends State<Show_stu> {
  // DateTime selectedDate = DateTime.now();
  // TimeOfDay selectedStartTime = TimeOfDay.now();
  // TimeOfDay selectedEndTime = TimeOfDay.now();

// bool _chooseClass = true;
  // final DateTime _current = DateTime.now();
  // String _date = '';
  // String _start = '';
  // String _end = '';
  String? Branch;
  // String? Semester;
  @override
  Widget build(BuildContext context) {
    // String semesterdropdownValue = Semester[0];
    // String batchdropdownValue = Batch[0];
    // String schooldropdownValue = School[0];
    // String subjectdropdownValue = Subject[0];
    // String datedropdownValue = Date[0];
    // String monthdropdownValue = Month[0];
    // String yeardropdownValue = Year[0];
    // dynamic fieldTextStyle = const TextStyle(
    //     color: Colors.cyan, fontSize: 17, fontWeight: FontWeight.w400);

// Initialize the Cloud Firestore

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Student Details"),
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
              // final semester =
              //     snapshot.data!.docs.map((doc) => doc.get('semno')).toList();
              return ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(children: [
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
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

                        // Container(
                        //   child: Column(
                        //     children: [
                        //       const Text(
                        //         "Semester",
                        //         style: TextStyle(fontSize: 20),
                        //       ),
                        //       SizedBox(
                        //         height: 5,
                        //       ),
                        //       Container(
                        //         padding: EdgeInsets.symmetric(horizontal: 10.0),
                        //         decoration: BoxDecoration(
                        //             color: Colors.grey[100],
                        //             borderRadius: BorderRadius.circular(15.0),
                        //             border: Border.all(
                        //                 color: Colors.grey,
                        //                 style: BorderStyle.solid,
                        //                 width: 0.80),
                        //             boxShadow: [
                        //               BoxShadow(
                        //                 color: Colors.grey,
                        //                 offset: const Offset(
                        //                   5.0,
                        //                   5.0,
                        //                 ),
                        //                 blurRadius: 5.0,
                        //                 spreadRadius: 1.0,
                        //               ),
                        //             ]),
                        //         child: DropdownButton<String>(
                        //           isExpanded: true,
                        //           // hint: Text(hint,style: TextStyle(color: Colors.black),),
                        //           value: Semester,
                        //           hint: const Text('Select an item'),
                        //           icon: const Icon(
                        //               Icons.keyboard_arrow_down_outlined),
                        //           elevation: 16,
                        //           dropdownColor: Colors.grey[100],
                        //           style: const TextStyle(color: Colors.black),
                        //           underline:
                        //               Container(height: 0, color: Colors.black),
                        //           onChanged: (value) {
                        //             setState(() {
                        //               Semester = value;
                        //             });
                        //           },
                        //           items: semester.map((item) {
                        //             return DropdownMenuItem<String>(
                        //               value: item,
                        //               child: Text(item),
                        //             );
                        //           }).toList(),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        dropdown(
                            DropdownValue: semesterdropdownValue,
                            sTring: Semester,
                            Hint: "Semester"),
                        const SizedBox(
                          height: 20,
                        ),
                        dropdown(
                            DropdownValue: yeardropdownValue,
                            sTring: CollegeYear,
                            Hint: "Year"),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => StudentF(
                                                branch: "$Branch",
                                                sem: semesterdropdownValue)),
                                      );
                                    },
                                    child: const Text("Show Student")),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    )
                  ]);
            }),
      ),
    );
  }
}
