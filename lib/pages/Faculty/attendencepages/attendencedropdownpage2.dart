// ignore_for_file: depend_on_referenced_packages

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_parents/pages/Faculty/attendencepages/attendencePage.dart';
import 'package:smart_parents/pages/Faculty/attendencepages/util/names.dart';
import 'package:smart_parents/widgest/dropDownWidget.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

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
  DateTime _current = DateTime.now();
  String _date = '';
  String _start = '';
  String _end = '';
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
    dynamic fieldTextStyle = TextStyle(
        color: Colors.cyan, fontSize: 17, fontWeight: FontWeight.w400);

// Initialize the Cloud Firestore

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Attendence"),
      ),
      body: Center(
        child: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('department').get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            // final items = snapshot.data.docs.map((doc) => doc.data()['name']).toList();
            final items =
                snapshot.data!.docs.map((doc) => doc.get('name')).toList();
            // final semester =
            //     snapshot.data!.docs.map((doc) => doc.get('semno')).toList();
            return ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                    SizedBox(
                      height: 30,
                    ),
                    // dropdown(
                    //     DropdownValue: items.toString(),
                    //     sTring: Branch,
                    //     Hint: "Branch"),
                    Container(
                      child: Column(
                        children: [
                          const Text(
                            "Branch",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(
                                    color: Colors.grey,
                                    style: BorderStyle.solid,
                                    width: 0.80),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: const Offset(
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
                    ),
                    SizedBox(
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
                    SizedBox(
                      height: 20,
                    ),
                    dropdown(
                        DropdownValue: yeardropdownValue,
                        sTring: CollegeYear,
                        Hint: "Year"),
                    SizedBox(
                      height: 20,
                    ),
                    dropdown(
                        DropdownValue: batchdropdownValue,
                        sTring: Batch,
                        Hint: "Batch"),
                    SizedBox(
                      height: 20,
                    ),
                    dropdown(
                        DropdownValue: subjectdropdownValue,
                        sTring: Subject,
                        Hint: "Subject"),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.calendar_today,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: _date.isEmpty
                                ? Text(
                                    'Choose Date',
                                    style: fieldTextStyle,
                                  )
                                : Text('$_date', style: fieldTextStyle)),
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey[700],
                          ),
                          onPressed: () {
                            DatePicker.showDatePicker(
                              context,
                              theme: DatePickerTheme(
                                containerHeight: 350,
                                backgroundColor: Colors.white,
                              ),
                              showTitleActions: true,
                              minTime: DateTime(_current.year,
                                  _current.month - 1, _current.day),
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
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: _start.isEmpty
                                ? Text(
                                    'Choose Start Time',
                                    style: fieldTextStyle,
                                  )
                                : Text(
                                    '$_start',
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
                              theme: DatePickerTheme(
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
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: _end.isEmpty
                                ? Text(
                                    'Choose Stop Time',
                                    style: fieldTextStyle,
                                  )
                                : Text(
                                    '$_end',
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
                              theme: DatePickerTheme(
                                containerHeight: 240,
                                backgroundColor: Colors.white,
                              ),
                              showTitleActions: true,
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
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        // height: 300,
                        width: 350,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 0.80),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: const Offset(
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
                              SizedBox(
                                height: 10,
                              ),
                              // Text("Time",style: TextStyle(fontSize: 30),),
                              Text(
                                "${_current.toLocal()}".split(' ')[0],
                                style: TextStyle(fontSize: 30),
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
                                        child:
                                            Text("Year : $yeardropdownValue")),
                                    Expanded(
                                        child: Text(
                                            "Subject : $subjectdropdownValue"))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                            "Batch : $batchdropdownValue")),
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
                                                      AttendencePage()),
                                            );
                                          },
                                          child: Text("Take Attendence")),
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
            );
          },
        ),
      ),
    );
  }
}
