// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/pages/Faculty/attendencepages/attendencePage.dart';
import 'package:smart_parents/pages/Faculty/attendencepages/util/names.dart';
import 'package:smart_parents/widgest/dropDownWidget.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class Department {
  final String id;
  final String name;

  Department(this.id, this.name);
}

class Subject {
  final String id;
  final String name;

  Subject(this.id, this.name);
}

class AttendenceDropdownpage2 extends StatefulWidget {
  const AttendenceDropdownpage2({Key? key}) : super(key: key);

  @override
  _AttendenceDropdownpage2State createState() =>
      _AttendenceDropdownpage2State();
}

class _AttendenceDropdownpage2State extends State<AttendenceDropdownpage2> {
  // DateTime selectedDate = DateTime.now();
  // TimeOfDay selectedStartTime = TimeOfDay.now();
  // TimeOfDay selectedEndTime = TimeOfDay.now();

// bool _chooseClass = true;
  final DateTime _current = DateTime.now();
  String _date = '';
  String _start = '';
  String _end = '';
  String? Branch;
  String? Sub;
  List<Department> _departments = [];
  List<Subject> _subjects = [];

  @override
  void initState() {
    super.initState();
    _fetchDepartments();
    _fetchSubjects();
  }

  // late String _selectedDepartmentId;
  // late String _selectedSubjectId;
  Future<void> _fetchDepartments() async {
    final QuerySnapshot<Map<String, dynamic>> departmentsSnapshot =
        await FirebaseFirestore.instance
            .collection('Admin/$admin/department')
            .get();

    final List<Department> departments = [];

    for (final DocumentSnapshot<Map<String, dynamic>> departmentSnapshot
        in departmentsSnapshot.docs) {
      final Department department =
          Department(departmentSnapshot.id, departmentSnapshot.data()!['name']);
      departments.add(department);
    }

    setState(() {
      _departments = departments;
      // _selectedDepartmentId = _departments[0].id;
    });
  }

  Future<void> _fetchSubjects() async {
    final QuerySnapshot<Map<String, dynamic>> subjectSnapshot =
        await FirebaseFirestore.instance
            .collection('Admin/$admin/subject')
            .get();

    final List<Subject> subjects = [];

    for (final DocumentSnapshot<Map<String, dynamic>> subjectSnapshot
        in subjectSnapshot.docs) {
      final Subject subject =
          Subject(subjectSnapshot.id, subjectSnapshot.data()!['sub_name']);
      subjects.add(subject);
    }

    setState(() {
      _subjects = subjects;
      // _selectedSubjectId = _subjects[0].id;
    });
  }

  @override
  Widget build(BuildContext context) {
    // String semesterdropdownValue = Semester[0];
    // String batchdropdownValue = Batch[0];
    // String schooldropdownValue = School[0];
    // String subjectdropdownValue = Subject[0];
    // String datedropdownValue = Date[0];
    // String monthdropdownValue = Month[0];
    // String yeardropdownValue = Year[0];
    dynamic fieldTextStyle = const TextStyle(
        color: Colors.cyan, fontSize: 17, fontWeight: FontWeight.w400);

// Initialize the Cloud Firestore

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Attendence"),
      ),
      body: Center(
        child: ListView(
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
                        icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        elevation: 16,
                        dropdownColor: Colors.grey[100],
                        style: const TextStyle(color: Colors.black),
                        underline: Container(height: 0, color: Colors.black),
                        onChanged: (value) {
                          setState(() {
                            Branch = value;
                          });
                        },
                        items: _departments.map((item) {
                          return DropdownMenuItem<String>(
                            value: item.name,
                            child: Text(item.name),
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
                dropdown(
                    DropdownValue: batchdropdownValue,
                    sTring: Batch,
                    Hint: "Batch"),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    const Text(
                      "Subject",
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
                      child: DropdownButton<String>(
                        isExpanded: true,
                        // hint: Text(hint,style: TextStyle(color: Colors.black),),
                        value: Sub,
                        hint: const Text('Select an item'),
                        icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        elevation: 16,
                        dropdownColor: Colors.grey[100],
                        style: const TextStyle(color: Colors.black),
                        underline: Container(height: 0, color: Colors.black),
                        onChanged: (value) {
                          setState(() {
                            Sub = value;
                          });
                        },
                        items: _subjects.map((item) {
                          return DropdownMenuItem<String>(
                            value: item.name,
                            child: Text(item.name),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.calendar_today,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: _date.isEmpty
                            ? Text(
                                'Choose Date',
                                style: fieldTextStyle,
                              )
                            : Text(_date, style: fieldTextStyle)),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.grey[700],
                      ),
                      onPressed: () {
                        DatePicker.showDatePicker(
                          context,
                          theme: const DatePickerTheme(
                            containerHeight: 350,
                            backgroundColor: Colors.white,
                          ),
                          showTitleActions: true,
                          minTime: DateTime(
                              _current.year, _current.month - 1, _current.day),
                          maxTime: DateTime(
                              _current.year, _current.month, _current.day),
                          onConfirm: (dt) {
                            setState(() {
                              _date = dt.toString().substring(0, 10);
                            });
                          },
                        );
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.access_time,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: _start.isEmpty
                            ? Text(
                                'Choose Start Time',
                                style: fieldTextStyle,
                              )
                            : Text(
                                _start,
                                style: fieldTextStyle,
                              )),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.grey[700],
                      ),
                      onPressed: () {
                        DatePicker.showTime12hPicker(
                          context,
                          theme: const DatePickerTheme(
                            containerHeight: 300,
                            backgroundColor: Colors.white,
                          ),
                          showTitleActions: true,
                          onConfirm: (time) {
                            setState(() {
                              _start = DateFormat.jm().format(time);
                            });
                          },
                        );
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.access_time,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: _end.isEmpty
                            ? Text(
                                'Choose Stop Time',
                                style: fieldTextStyle,
                              )
                            : Text(
                                _end,
                                style: fieldTextStyle,
                              )),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.grey[700],
                      ),
                      onPressed: () {
                        DatePicker.showTime12hPicker(
                          context,
                          theme: const DatePickerTheme(
                            containerHeight: 240,
                            backgroundColor: Colors.white,
                          ),
                          showTitleActions: true,
                          // showSecondsColumn: false,
                          onConfirm: (time) {
                            setState(() {
                              _end = DateFormat.jm().format(time);
                            });
                          },
                        );
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    // height: 300,
                    width: 350,
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
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ),
                        ]),
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          // Text("Time",style: TextStyle(fontSize: 30),),
                          _date.isEmpty
                              ? Text(
                                  "${_current.toLocal()}".split(' ')[0],
                                  style: const TextStyle(fontSize: 30),
                                )
                              : Text(
                                  _date,
                                  style: const TextStyle(fontSize: 30),
                                ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(child: Text("Branch : $Branch")),
                                Expanded(
                                    child: Text(
                                        "Semester : $semesterdropdownValue"))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text("Year : $yeardropdownValue")),
                                Expanded(child: Text("Subject : $Sub"))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text("Batch : $batchdropdownValue")),
                              ],
                            ),
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
                                              builder: (context) =>
                                                  AttendencePage(
                                                      branch: "$Branch",
                                                      sem:
                                                          semesterdropdownValue)),
                                        );
                                      },
                                      child: const Text("Take Attendence")),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
    // },
    // ),
    // );
  }
}
