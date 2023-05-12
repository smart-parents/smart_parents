// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, non_constant_identifier_names, prefer_typing_uninitialized_variables, deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/pages/Faculty/Schedule/schedule_f.dart';
import 'package:intl/intl.dart';

// class Department {
//   final String id;
//   final String name;

//   Department(this.id, this.name);
// }

class Subject {
  final String id;
  final String name;

  Subject(this.id, this.name);
}

class EditSchedule extends StatefulWidget {
  const EditSchedule(
      {Key? key,
      required this.batch,
      required this.doc,
      required this.start,
      required this.end,
      required this.subject,
      required this.type,
      required this.day})
      : super(key: key);
  final String batch;
  final String doc;
  final String start;
  final String end;
  final String type;
  final String subject;
  final String day;

  @override
  _EditScheduleState createState() => _EditScheduleState();
}

class _EditScheduleState extends State<EditSchedule> {
  TimeOfDay start = TimeOfDay.now();
  String _start = DateFormat('hh:mm a').format(DateTime.now());
  TimeOfDay end =
      TimeOfDay.fromDateTime(DateTime.now().add(const Duration(hours: 1)));
  String _end = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(hours: 1)));
  String? Branch;
  var Sub;
  List<Subject> _subjects = [];
  List<String> type = ['Lecture', 'Lab'];
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _fetchSubjects();
    DateTime start0 = DateFormat('hh:mm a').parse(widget.start);
    start = TimeOfDay.fromDateTime(start0);
    _start = widget.start;
    DateTime end0 = DateFormat('hh:mm a').parse(widget.end);
    end = TimeOfDay.fromDateTime(end0);
    _end = widget.end;
    Sub = widget.subject;
    if (widget.type == 'Lecture') {
      selectedIndex = 0;
    } else if (widget.type == 'Lab') {
      selectedIndex = 1;
    }
  }

  void update_schedule() async {
    var fullhour = DateFormat('HH:mm')
        .format(DateTime(2022, 1, 1, start.hour, start.minute));
    // FirebaseFirestore.instance
    //     .collection('Admin/$admin/schedule')
    //     .doc('${branch}_$semesterdropdownValue')
    //     .get()
    //     .then((value) async => {
    // if (value.exists)
    //   {
    //     await
    FirebaseFirestore.instance
        .collection('Admin')
        .doc(admin)
        .collection('schedule')
        .doc('${branch}_${widget.batch}')
        // .doc('${branch}_${semesterdropdownValue}_$daysdropdownValue')
        .collection('timetable')
        .doc(widget.day)
        .collection('entries')
        .doc(widget.doc)
        .set({
      // 'subject': "$Sub (${type[selectedIndex]})",
      'subject': "$Sub",
      'type': type[selectedIndex],
      'startTime': _start,
      'start24': fullhour,
      'endTime': _end,
    });
    // }
    // else
    //   {
    //     await FirebaseFirestore.instance
    //         .collection('Admin/$admin/schedule')
    //         // .doc(widget.sub)
    //         // .collection('lectures')
    //         .doc('${branch}_$semesterdropdownValue')
    //         .set({
    //       // 'day': daysdropdownValue,
    //       'branch': branch,
    //       'sem': semesterdropdownValue,
    //       // 'subject': Sub,
    //       // 'start': _start,
    //       // 'end': _end,
    //     }),
    //     await FirebaseFirestore.instance
    //         .collection('Admin')
    //         .doc(admin)
    //         .collection('schedule')
    //         .doc('${branch}_$semesterdropdownValue')
    //         // .doc('${branch}_${semesterdropdownValue}_$daysdropdownValue')
    //         .collection('timetable')
    //         .doc(daysdropdownValue)
    //         .collection('entries')
    //         .add({
    //       'subject': "$Sub (${type[selectedIndex]})",
    //       'startTime': _start,
    //       'start24': fullhour,
    //       'endTime': _end,
    //     })
    //   }
    // });
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
      // Sub = _subjects[0].name;
    });
  }

  void showAlertDialogOnOkCallback(String title, String msg,
      DialogType dialogType, BuildContext context, VoidCallback onOkPress) {
    AwesomeDialog(
      context: context,
      animType: AnimType.TOPSLIDE,
      dialogType: dialogType,
      title: title,
      desc: msg,
      btnOkIcon: Icons.check_circle,
      btnOkColor: Colors.green.shade900,
      btnOkOnPress: onOkPress,
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    dynamic fieldTextStyle = const TextStyle(
        color: Colors.cyan, fontSize: 17, fontWeight: FontWeight.w400);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Update Schedule"),
      ),
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customRadio(type[0], 0),
                        const SizedBox(
                          width: 10,
                        ),
                        customRadio(type[1], 1),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // dropdown(
                    //     DropdownValue: semesterdropdownValue,
                    //     sTring: Semester,
                    //     Hint: "Semester"),
                    // const SizedBox(
                    //   height: 20,
                    // ),
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
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                // dropdown(
                //     DropdownValue: daysdropdownValue,
                //     sTring: Days,
                //     Hint: "Day"),
                // const SizedBox(
                //   height: 20,
                // ),
                // Text(
                //       DateFormat('E, dd MMM').format(dates[_selectedIndex]),
                //       style: GoogleFonts.rubik(
                //           fontSize: 30,
                //           color: kPrimaryColor,
                //           fontWeight: FontWeight.bold),
                //     ),
                // const SizedBox(
                //   height: 20,
                // ),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.access_time,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child:
                            // _start.isEmpty
                            //     ? Text(
                            //         'Choose Start Time',
                            //         style: fieldTextStyle,
                            //       )
                            //     :
                            Text(
                      _start,
                      style: fieldTextStyle,
                    )),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.grey[700],
                      ),
                      onPressed: () async {
                        TimeOfDay? picked = await showTimePicker(
                            context: context, initialTime: start);
                        if (picked != null) {
                          setState(() {
                            _start = DateFormat('hh:mm a').format(DateTime(
                                2022, 1, 1, picked.hour, picked.minute));
                            start = picked;
                            _end = DateFormat('hh:mm a').format(
                                DateTime(2022, 1, 1, start.hour, start.minute)
                                    .add(const Duration(hours: 1)));
                            end = TimeOfDay.fromDateTime(
                                DateTime(2022, 1, 1, start.hour, start.minute)
                                    .add(const Duration(hours: 1)));
                          });
                        }
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
                        child:
                            // _end.isEmpty
                            //     ? Text(
                            //         'Choose Stop Time',
                            //         style: fieldTextStyle,
                            //       )
                            //     :
                            Text(
                      _end,
                      style: fieldTextStyle,
                    )),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.grey[700],
                      ),
                      onPressed: () async {
                        TimeOfDay? picked = await showTimePicker(
                            context: context, initialTime: end);
                        if (picked != null) {
                          setState(() {
                            _end = DateFormat('hh:mm a').format(DateTime(
                                2022, 1, 1, picked.hour, picked.minute));
                            end = picked;
                          });
                        }
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () => showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Update Schedule?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () => {
                                            update_schedule(),
                                            showAlertDialogOnOkCallback(
                                                'Success !',
                                                'Schedule Successfully Updatted.',
                                                DialogType.SUCCES,
                                                context,
                                                () => Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const ShowSchedule(),
                                                        ),
                                                        (route) => false)),
                                          },
                                          child: const Text('Submit'),
                                        ),
                                      ],
                                    ),
                                  ),
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(300, 40)),
                              child: const Text("Update Schedule")),
                        ),
                      ],
                    ))
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

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget customRadio(String txt, int index) {
    return OutlinedButton(
      onPressed: () => changeIndex(index),
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: selectedIndex == index ? Colors.cyan : Colors.grey,
          width: 2.0,
        ),
      ),
      child: Text(
        txt,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selectedIndex == index ? Colors.cyan : Colors.grey),
      ),
    );
  }
}
