// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_parents/pages/Faculty/attendencepages/util/names.dart';
import 'package:smart_parents/widgest/dropDownWidget.dart';
import 'package:smart_parents/components/constants.dart';

class NoticeAdd extends StatefulWidget {
  const NoticeAdd({Key? key}) : super(key: key);
  @override
  State<NoticeAdd> createState() => _NoticeAddState();
}

class _NoticeAddState extends State<NoticeAdd> {
  String? Branch;
  final _formKey = GlobalKey<FormState>();
  final subjectController = TextEditingController();
  final noticeController = TextEditingController();

  @override
  void dispose() {
    subjectController.dispose();
    noticeController.dispose();
    super.dispose();
  }

  clearText() async {
    subjectController.clear();
    noticeController.clear();
  }

  var subject = '';
  var notice = '';
  void addnotice() {
    CollectionReference notices =
        FirebaseFirestore.instance.collection('Admin/$admin/Notices');
    String docId = DateTime.now().toString();
    notices
        .doc(docId)
        .set({
          'branch': Branch,
          'sem': semesterdropdownValue,
          'subject': subject,
          'notice': notice,
          'date': docId,
        })
        .then((value) => print('faculty Added'))
        .catchError((error) => print('Failed to Add user: $error'));
    clearText();
  }

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

                  // physics: const BouncingScrollPhysics(),
                  children: [
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(children: [
                          const SizedBox(
                            height: 30,
                          ),
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
                                child: DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  value: Branch,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  hint: const Text('Select an item'),
                                  icon: const Icon(
                                      Icons.keyboard_arrow_down_outlined),
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
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 15),
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
                                  // maxLines: null,
                                  decoration: const InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Enter notice topic:",
                                      hintStyle: TextStyle(fontSize: 18)),
                                  controller: subjectController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter notice topic:';
                                    }
                                    return null;
                                  },
                                  // keyboardType: TextInputType.multiline,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                padding:
                                    const EdgeInsets.only(left: 15, bottom: 10),
                                margin: const EdgeInsets.only(
                                    left: 20, top: 20, right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      style: BorderStyle.solid,
                                      color: Colors.grey),
                                ),
                                child: TextFormField(
                                  maxLines: null,
                                  // controller: project_description_controller_r,
                                  decoration: const InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Enter notice",
                                      hintStyle: TextStyle(fontSize: 18)),
                                  controller: noticeController,
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
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      subject = subjectController.text;
                                      notice = noticeController.text;
                                      addnotice();
                                      Navigator.pop(context);
                                    });
                                  }
                                },
                                child: const Text(
                                  "Add Notice",
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  ]);
            }),
      ),
    );
  }
}
