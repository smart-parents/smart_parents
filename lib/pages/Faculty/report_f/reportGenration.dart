// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/pages/Faculty/attendencepages/util/names.dart';
import 'package:smart_parents/pages/Faculty/report_f/makepdf.dart';
import 'package:smart_parents/pages/Faculty/report_f/reportPdfDownload.dart';
import 'package:smart_parents/widgest/dropDownWidget.dart';

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

class ReportGenration extends StatefulWidget {
  const ReportGenration({Key? key}) : super(key: key);

  @override
  _ReportGenrationState createState() => _ReportGenrationState();
}

class _ReportGenrationState extends State<ReportGenration> {
  final DateTime _current = DateTime.now();
  // String _date = '';
  // String _start = '';
  // String _end = '';
  String? Branch;
  String? Sub;
  // List<Department> _departments = [];
  List<Subject> _subjects = [];

  @override
  void initState() {
    super.initState();
    // _fetchDepartments();
    _fetchSubjects();
  }

  // late String _selectedDepartmentId;
  // late String _selectedSubjectId;
  // Future<void> _fetchDepartments() async {
  //   final QuerySnapshot<Map<String, dynamic>> departmentsSnapshot =
  //       await FirebaseFirestore.instance
  //           .collection('Admin/$admin/department')
  //           .get();

  //   final List<Department> departments = [];

  //   for (final DocumentSnapshot<Map<String, dynamic>> departmentSnapshot
  //       in departmentsSnapshot.docs) {
  //     final Department department =
  //         Department(departmentSnapshot.id, departmentSnapshot.data()!['name']);
  //     departments.add(department);
  //   }

  //   setState(() {
  //     _departments = departments;
  //     // _selectedDepartmentId = _departments[0].id;
  //   });
  // }

  DateTime selectedDate = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  Future<void> _fetchSubjects() async {
    final QuerySnapshot<Map<String, dynamic>> subjectSnapshot =
        await FirebaseFirestore.instance
            .collection('Admin/$admin/subject')
            .where('branch', isEqualTo: branch)
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
    Future<void> _selectDate(BuildContext context) async {
      DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
      }
      print(selectedDate);
    }

    Future<void> _selectDate2(BuildContext context) async {
      DateTime? picked2 = await showDatePicker(
          context: context,
          initialDate: selectedDate2,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked2 != null && picked2 != selectedDate2) {
        setState(() {
          selectedDate2 = picked2;
        });
      }
    }

    // String yeardropdownValue = CollegeYear[0];
    // String batchdropdownValue = Batch[0];
    // String subjectdropdownValue = Subject[0];
    // String facultiesdropdownValue = Faculties[0];
    return Scaffold(
        appBar: AppBar(
          title: Text("Report"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(children: [
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
                // Column(
                //   children: [
                //     const Text(
                //       "Branch",
                //       style: TextStyle(fontSize: 20),
                //     ),
                //     const SizedBox(
                //       height: 5,
                //     ),
                //     Container(
                //       padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //       decoration: BoxDecoration(
                //           color: Colors.grey[100],
                //           borderRadius: BorderRadius.circular(15.0),
                //           border: Border.all(
                //               color: Colors.grey,
                //               style: BorderStyle.solid,
                //               width: 0.80),
                //           boxShadow: const [
                //             BoxShadow(
                //               color: Colors.grey,
                //               offset: Offset(
                //                 5.0,
                //                 5.0,
                //               ),
                //               blurRadius: 5.0,
                //               spreadRadius: 1.0,
                //             ),
                //           ]),
                //       child: DropdownButton<String>(
                //         isExpanded: true,
                //         // hint: Text(hint,style: TextStyle(color: Colors.black),),
                //         value: Branch,
                //         hint: const Text('Select an item'),
                //         icon: const Icon(Icons.keyboard_arrow_down_outlined),
                //         elevation: 16,
                //         dropdownColor: Colors.grey[100],
                //         style: const TextStyle(color: Colors.black),
                //         underline: Container(height: 0, color: Colors.black),
                //         onChanged: (value) {
                //           setState(() {
                //             Branch = value;
                //           });
                //         },
                //         items: _departments.map((item) {
                //           return DropdownMenuItem<String>(
                //             value: item.name,
                //             child: Text(item.name),
                //           );
                //         }).toList(),
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(
                  height: 20,
                ),
                // dropdown(
                //     DropdownValue: yeardropdownValue,
                //     sTring: CollegeYear,
                //     Hint: "Year"),
                // const SizedBox(
                //   height: 20,
                // ),
                dropdown(
                    DropdownValue: semesterdropdownValue,
                    sTring: Semester,
                    Hint: "Semester"),
                const SizedBox(
                  height: 20,
                ),
                dropdown(
                    DropdownValue: batchdropdownValue,
                    sTring: Batch,
                    Hint: "Batch"),
                SizedBox(
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
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // dropdownButton(facultiesdropdownValue, sTring:Faculties, "Faculty"),
                    SizedBox(
                      height: 40,
                    ),
                    // Container(
                    //   height: 200,
                    //   width: 200,
                    //   child: CupertinoDatePicker(
                    //       mode: CupertinoDatePickerMode.date,
                    //       initialDateTime: DateTime(1969, 1, 1),
                    //       onDateTimeChanged: (DateTime newDateTime) {
                    //         // Do something
                    //       },
                    //     ),
                    // ),
                    // date picker
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("From :"),
                            SizedBox(
                              height: 10,
                            ),
                            Text("${selectedDate.toLocal()}".split(' ')[0]),
                            SizedBox(
                              height: 20.0,
                            ),
                            // ignore: deprecated_member_use
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              onPressed: () => _selectDate(context),
                              child: Text(
                                'Select date',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 70,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("To :"),
                            SizedBox(
                              height: 10,
                            ),
                            Text("${selectedDate2.toLocal()}".split(' ')[0]),
                            SizedBox(
                              height: 20.0,
                            ),
                            // ignore: deprecated_member_use
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              onPressed: () => _selectDate2(context),
                              child: Text(
                                'Select date',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(width: 20,),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => reportt(
                                    list: [],
                                    sem: '',
                                  )),
                        );
                      },
                      child: Text("Genrate Report"),
                      style: ElevatedButton.styleFrom(fixedSize: Size(300, 40)),
                    ),
                  ],
                ),
              ]),
            )
          ]),
        ));
  }
}
