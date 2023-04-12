// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:smart_parents/components/constants.dart';

class AddExamTimeTable extends StatefulWidget {
  const AddExamTimeTable({Key? key, required this.docid, required this.name})
      : super(key: key);
  final String docid;
  final String name;

  @override
  State<AddExamTimeTable> createState() => _AddExamTimeTableState();
}

class Subject {
  final String id;
  final String name;

  Subject(this.id, this.name);
}

class _AddExamTimeTableState extends State<AddExamTimeTable> {
  @override
  void initState() {
    super.initState();
    _fetchSubjects();
  }

  addExam(subject, date, start, end) {
    CollectionReference exam = FirebaseFirestore.instance
        .collection('Admin/$admin/exams/${widget.docid}/exam');
    return exam
        .add({
          'subject': subject,
          'date': date,
          'starttime': start,
          'endtime': end
        })
        .then((value) => print('student Added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }

  var Sub;
  List<Subject> _subjects = [];
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
      Sub = _subjects[0].name;
    });
  }

  final DateTime current = DateTime.now();
  String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
  DateTime start = DateTime.now();
  String start0 = DateFormat('hh:mm a').format(DateTime.now());
  DateTime end = DateTime.now().add(const Duration(hours: 1));
  String end0 = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(hours: 1)));
  dynamic fieldTextStyle = const TextStyle(
      color: Colors.cyan, fontSize: 17, fontWeight: FontWeight.w400);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: const Color.fromARGB(255, 207, 235, 255),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: "Back",
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(widget.name, style: const TextStyle(fontSize: 30.0)),
        ),
        body: Center(
            child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Text(
                      "Subject",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
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
                        // decoration: const InputDecoration(
                        //   border: InputBorder.none,
                        //   contentPadding: EdgeInsets.zero,
                        // ),
                        // hint: const Text('Select an item'),
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
                        // validator: (value) {
                        //   if (value == null) {
                        //     return 'Please select a subject';
                        //   }
                        //   return null; // return null if there's no error
                        // },
                      ),
                    ),

                    // const SizedBox(
                    //   width: 40,
                    // ),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.calendar_today,
                        ),
                        // const SizedBox(
                        //   width: 20,
                        // ),
                        Expanded(
                            child:
                                //  _date.isEmpty
                                //     ? Text(
                                //         'Choose Date',
                                //         style: fieldTextStyle,
                                //       )
                                //     :
                                Text(date.toString(), style: fieldTextStyle)),
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
                                  current.year, current.month - 1, current.day),
                              maxTime: DateTime(
                                  current.year, current.month + 2, current.day),
                              onConfirm: (dt) {
                                setState(() {
                                  // _date = dt.toString().substring(0, 10);
                                  date = DateFormat('dd-MM-yyyy').format(dt);
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
                        // const SizedBox(
                        //   width: 20,
                        // ),
                        Expanded(
                            child:
                                // _start.isEmpty
                                //     ? Text(
                                //         'Choose Start Time',
                                //         style: fieldTextStyle,
                                //       )
                                //     :
                                Text(
                          start0,
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
                                  start0 = DateFormat('hh:mm a').format(time);
                                  start = time;
                                  end0 = DateFormat('hh:mm a').format(
                                      start.add(const Duration(hours: 1)));
                                  end = time.add(const Duration(hours: 1));
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
                        // const SizedBox(
                        //   width: 20,
                        // ),
                        Expanded(
                            child:
                                // _end.isEmpty
                                //     ? Text(
                                //         'Choose Stop Time',
                                //         style: fieldTextStyle,
                                //       )
                                //     :
                                Text(
                          end0,
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
                              currentTime: end,
                              // showSecondsColumn: false,
                              onConfirm: (time) {
                                setState(() {
                                  end0 = DateFormat('hh:mm a').format(time);
                                  end = time;
                                });
                              },
                            );
                          },
                        )
                      ],
                    ),
                    // Container(
                    //   margin: const EdgeInsets.symmetric(vertical: 10.0),
                    //   child: TextFormField(
                    //     autofocus: false,
                    //     decoration: const InputDecoration(
                    //       labelText: 'Name: ',
                    //       labelStyle: TextStyle(fontSize: 20.0),
                    //       border: OutlineInputBorder(),
                    //       errorStyle: TextStyle(fontSize: 15),
                    //     ),
                    //     controller: nameController,
                    //     validator: (value) {
                    //       if (value == null || value.isEmpty) {
                    //         return 'Please Enter Name';
                    //       }
                    //       return null;
                    //     },
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              addExam(Sub, date, start0, end0);
                              Navigator.of(context).pop();
                            },
                            child: const Text("Add Exam TimeTable")),
                      ),
                    ),
                  ],
                ),
              ),
            ])));
  }
}
