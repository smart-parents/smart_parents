// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/widgest/dropDownWidget.dart';

class AddSubject extends StatefulWidget {
  const AddSubject({Key? key}) : super(key: key);
// void initState() {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
//       // SystemUiOverlay.bottom,
//     ]);
// }
  @override
  _AddSubjectState createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  final _formKey = GlobalKey<FormState>();
  // final email = FirebaseAuth.instance.currentUser!.email;
  // String? email;

  var name = "";
  var number = "";
  // String? Branch;
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final semController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    numberController.dispose();
    semController.dispose();
    super.dispose();
  }

  clearText() {
    nameController.clear();
    numberController.clear();
    semController.clear();
  }

  // Adding Student
  CollectionReference subject =
      FirebaseFirestore.instance.collection('Admin/$admin/subject');

  Future<void> addUser() {
    return subject
        .doc(number)
        .set({
          'sem': semesterdropdownValue,
          'sub_name': name,
          'sub_code': number,
          'branch': branch,
        })
        .then((value) => print('student Added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Subject"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: "Back",
          onPressed: () => Navigator.of(context).pop(),
        ),
        // backgroundColor: const Color.fromARGB(255, 207, 235, 255),
      ),
      body: Center(
          child:
              // FutureBuilder<QuerySnapshot>(
              //     future: FirebaseFirestore.instance
              //         .collection('Admin/$admin/department')
              //         .get(),
              //     builder: (context, snapshot) {
              //       if (!snapshot.hasData) {
              //         return const CircularProgressIndicator();
              //       }
              //       // final items = snapshot.data.docs.map((doc) => doc.data()['name']).toList();
              //       final items =
              //           snapshot.data!.docs.map((doc) => doc.get('name')).toList();
              //       return
              Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
            children: [
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
              //   decoration: BoxDecoration(
              //       color: Colors.grey[100],
              //       borderRadius: BorderRadius.circular(15.0),
              //       border: Border.all(
              //           color: Colors.grey,
              //           style: BorderStyle.solid,
              //           width: 0.80),
              //       boxShadow: const [
              //         BoxShadow(
              //           color: Colors.grey,
              //           offset: Offset(
              //             5.0,
              //             5.0,
              //           ),
              //           blurRadius: 5.0,
              //           spreadRadius: 1.0,
              //         ),
              //       ]),
              //   child: DropdownButton<String>(
              //     isExpanded: true,
              //     // hint: Text(hint,style: TextStyle(color: Colors.black),),
              //     value: Branch,
              //     hint: const Text('Select an item'),
              //     icon: const Icon(Icons.keyboard_arrow_down_outlined),
              //     elevation: 16,
              //     dropdownColor: Colors.grey[100],
              //     style: const TextStyle(color: Colors.black),
              //     underline: Container(height: 0, color: Colors.black),
              //     onChanged: (value) {
              //       setState(() {
              //         Branch = value;
              //       });
              //     },
              //     items: items.map((item) {
              //       return DropdownMenuItem<String>(
              //         value: item,
              //         child: Text(item),
              //       );
              //     }).toList(),
              //   ),
              // ),
              dropdown(
                  DropdownValue: semesterdropdownValue,
                  sTring: Semester,
                  Hint: "Semester"),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Subject Name: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.lightBlueAccent, fontSize: 15),
                  ),
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  maxLength: 7,
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Subject Code: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.lightBlueAccent, fontSize: 15),
                  ),
                  keyboardType: TextInputType.number,
                  controller: numberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Subject Code';
                    } else if (value.length != 7) {
                      return 'Please Enter Valid Subject Code';
                    }
                    return null;
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, otherwise false.
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          name = nameController.text;
                          number = numberController.text;
                          Navigator.pop(context);
                          addUser();
                        });
                      }
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => {clearText()},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey),
                    child: const Text(
                      'Reset',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )
          // }),
          ),
    );
  }
}
