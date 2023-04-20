// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/widgest/dropDownWidget.dart';

class Fees extends StatefulWidget {
  const Fees({Key? key}) : super(key: key);

  @override
  _FeesState createState() => _FeesState();
}

class _FeesState extends State<Fees> {
  // int? name;
  final _formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final semController = TextEditingController();
  @override
  void initState() {
    super.initState();
    datafetch();
  }

  @override
  void dispose() {
    amountController.dispose();
    semController.dispose();
    super.dispose();
  }

  late Stream<QuerySnapshot> studentStream;
  datafetch() {
    studentStream = FirebaseFirestore.instance
        .collection('Admin/$admin/students')
        .where('batch', isEqualTo: batchyeardropdownValue)
        .snapshots();
  }

  // final nameController = TextEditingController();
  String? child;
  String? namestudent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: const Color.fromARGB(255, 123, 180, 204),
          leading: const BackButton(),
          title: const Text('Fees Notification')),
      body:
          //  SingleChildScrollView(
          //   child:
          Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: studentStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            // final items = snapshot.data.docs.map((doc) => doc.data()['name']).toList();
            final items =
                snapshot.data!.docs.map((doc) => doc.get('number')).toList();
            final names =
                snapshot.data!.docs.map((doc) => doc.get('name')).toList();
            // int? name;
            return Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // const Text(
                    //   'Students Details',
                    //   style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    // ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    dropdown(
                      DropdownValue: batchyeardropdownValue,
                      sTring: batchList,
                      Hint: "Batch(Starting Year)",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Enrollment Number',
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
                      child: GestureDetector(
                        onTap: datafetch(),
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          // hint: Text(hint,style: TextStyle(color: Colors.black),),
                          value: child,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          hint: const Text('Select a number'),
                          icon: const Icon(Icons.keyboard_arrow_down_outlined),
                          elevation: 16,
                          dropdownColor: Colors.grey[100],
                          style: const TextStyle(color: Colors.black),
                          // underline: Container(height: 0, color: Colors.black),
                          onChanged: (value) {
                            setState(() {
                              child = value;
                              int name = items.indexOf(value);
                              namestudent = names[name];
                              // nameController.text = names[items.indexOf(value)];
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
                    ),
                    // TextFieldWidgetForm(
                    //   label: "Enrollment Number",
                    //   onChanged: (yuu) {},
                    //   text: "",
                    // ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    const SizedBox(
                      height: 20,
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        // names[items.indexOf(child)],
                        // names[name] ?? 'name',
                        namestudent ?? 'name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                            fontSize: 20.0),
                      ),
                      //  TextFormField(
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.grey[700],
                      //       fontSize: 20.0),
                      //   readOnly: true,
                      //   // initialValue: namestudent,
                      //   autofocus: false,
                      //   decoration: const InputDecoration(
                      //     labelText: 'Name',
                      //     labelStyle: TextStyle(fontSize: 20.0),
                      //     border: OutlineInputBorder(),
                      //     errorStyle: TextStyle(fontSize: 15),
                      //   ),
                      //   controller: nameController,
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please Enter Name';
                      //     }
                      //     return null;
                      //   },
                      // ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        maxLength: 1,
                        autofocus: false,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Semester: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(fontSize: 15),
                        ),
                        controller: semController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Semester';
                          } else if (value.length != 1) {
                            return 'Please Enter Valid Semester';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Amount: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(fontSize: 15),
                        ),
                        controller: amountController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Amount';
                          }
                          return null;
                        },
                      ),
                    ),
                    // TextFieldWidgetForm(
                    //   label: "Name",
                    //   onChanged: (yuu) {},
                    //   text: "",
                    // ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // TextFieldWidgetForm(
                    //   label: "Id",
                    //   onChanged: (yuu) {},
                    //   text: "",
                    // ),
                    // const SizedBox(
                    //   height: 15,
                    // ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: <Widget>[
                    //     Flexible(
                    //       child: TextFieldWidgetForm(
                    //         label: "Semester",
                    //         onChanged: (yuu) {},
                    //         text: "",
                    //       ),
                    //     ),
                    //     Flexible(
                    //       child: TextFieldWidgetForm(
                    //         label: "Department",
                    //         onChanged: (yuu) {},
                    //         text: "",
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: <Widget>[
                    //     Flexible(
                    //       child: TextFieldWidgetForm(
                    //         label: "Stream",
                    //         onChanged: (yuu) {},
                    //         text: "",
                    //       ),
                    //     ),
                    //     Flexible(
                    //       child: TextFieldWidgetForm(
                    //         label: "Year",
                    //         onChanged: (yuu) {},
                    //         text: "",
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // TextFieldWidgetForm(
                    //   label: "Amount",
                    //   onChanged: (yuu) {},
                    //   text: "",
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // Center(
                    //   child: Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: <Widget>[
                    //       Expanded(
                    //         child:
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.of(context).pushAndRemoveUntil(
                        //   MaterialPageRoute(
                        //       builder: (context) => AdminNavScreen()),
                        //   (route) => false,
                        // ),
                        if (_formKey.currentState!.validate()) {
                          setState(() {});
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        // backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                        minimumSize: const Size(150, 50),
                      ),
                      child: const Text(
                        'Fees payment',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                    // ),
                    // const SizedBox(
                    //   width: 20,
                    // ),
                    // Expanded(
                    //   child: ElevatedButton(
                    //     onPressed: () => {
                    //       // Navigator.push(
                    //       //   context,
                    //       //   MaterialPageRoute(
                    //       //     builder: (context) {
                    //       //       return const Faculty();
                    //       //     },
                    //       //   ),
                    //       // )
                    //     },
                    //     style: ElevatedButton.styleFrom(
                    //       shape: const StadiumBorder(),
                    //       // backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                    //       minimumSize: const Size(150, 50),
                    //     ),
                    //     child: const Text(
                    //       'Pay Fees Notification',
                    //       style: TextStyle(fontSize: 20.0, color: Colors.white),
                    //     ),
                    //   ),
                    // ),
                    //   ],
                    // ),
                    // ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      // ),
    );
  }
}
