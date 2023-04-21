// ignore_for_file: depend_on_referenced_packages, invalid_return_type_for_catch_error, use_build_context_synchronously

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/components/sendNotification.dart';
import 'package:smart_parents/widgest/dropDownWidget.dart';
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';

class DataModel {
  final String name;
  final String mime;
  final int bytes;
  final String url;

  DataModel({
    required this.name,
    required this.mime,
    required this.bytes,
    required this.url,
  });

  String get size {
    final kb = bytes / 1024;
    final mb = kb / 1024;

    return mb > 1
        ? '${mb.toStringAsFixed(2)}MB'
        : '${kb.toStringAsFixed(2)} KB';
  }
}

class ResultAdd extends StatefulWidget {
  const ResultAdd({super.key});

  @override
  State<ResultAdd> createState() => _ResultAddState();
}

class _ResultAddState extends State<ResultAdd> with notification {
  DataModel? task;
  File? file;
  final subjectController = TextEditingController();
  @override
  void dispose() {
    subjectController.dispose();
    super.dispose();
  }

  clearText() async {
    subjectController.clear();
  }

  Future selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      final path = result.files.single.path!;
      setState(() => file = File(path));
    }
  }

  CollectionReference results =
      FirebaseFirestore.instance.collection('Admin/$admin/Results');
  String? docId;
  var subject = '';

  Future uploadFile() async {
    if (file == null) return;
    var date = DateFormat('dd-MM-yyyy hh:mm:ss').format(DateTime.now());
    DocumentReference docRef =
        results.doc(); // create a new document with a unique ID
    docRef.set({
      'branch': branch,
      'batch': batchyeardropdownValue,
      'subject': subject,
      'date': date,
      // add more fields here if needed
    }).then((_) {
      docId = docRef.id;
      print('Document ID: ${docRef.id}');
    }).catchError((error) => print('Failed to Add user: $error'));
    docId = docRef.id;
    // final user = FirebaseAuth.instance.currentUser;
    final storageRef =
        FirebaseStorage.instance.ref().child('$admin/Results/$docId.pdf');
    final UploadTask uploadTask = storageRef.putFile(file!);

    final TaskSnapshot downloadUrl = await uploadTask.whenComplete(() => null);

    final url = (await downloadUrl.ref.getDownloadURL());
    await FirebaseFirestore.instance
        .collection('Admin/$admin/Results')
        .doc(docId)
        .update({'pdf': url});
    sendNotificationToAllUsers(
        "",
        'Result',
        subject,
        await FirebaseFirestore.instance
            .collection('Admin/$admin/students')
            .where('branch', isEqualTo: branch)
            .where('batch', isEqualTo: batchyeardropdownValue)
            .get());
    sendNotificationToAllUsers(
        "",
        'Result',
        subject,
        await FirebaseFirestore.instance
            .collection('Admin/$admin/parents')
            .where('branch', isEqualTo: branch)
            .where('batch', isEqualTo: batchyeardropdownValue)
            .get());
    // setState(() {
    //   _imageUrl = url;
    //   _uploading = false;
    // });
    print('Image uploaded to Firebase Storage: $url');
    clearText();
    Navigator.pop(context);
    return const CircularProgressIndicator();
    // final fileName = basename(file!.path);
    // final destination = 'files/$fileName';
    // print(fileName);
    // print(destination);
    // // FirebaseApi.uploadFile(destination, file!);
    // setState(() {});

    // if (task == null) return;

    // final snapshot = await task!.(() => {});
    // final urlDownload = await snapshot.ref.getDownloadURL();

    // print('Download Link: $urlDownload');
  }

  final _formKey = GlobalKey<FormState>();
  // bool error = true;
  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? path.basename(file!.path) : null;
    // String fileName = basename(file!.path);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Result'),
        ),
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                dropdown(
                  DropdownValue: batchyeardropdownValue,
                  sTring: batchList,
                  Hint: "Batch(Starting Year)",
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15),
                  // margin: const EdgeInsets.only(
                  //   top: 20,
                  // ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        style: BorderStyle.solid, color: Colors.grey),
                  ),
                  child: TextFormField(
                    minLines: 1,
                    // maxLines: null,
                    decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: "Enter result topic:",
                        hintStyle: TextStyle(fontSize: 18)),
                    controller: subjectController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter result topic:';
                      }
                      return null;
                    },
                    // keyboardType: TextInputType.multiline,
                  ),
                ),
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   height: 150,
                //   padding: const EdgeInsets.only(left: 15, bottom: 10),
                //   // margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(15),
                //     border: Border.all(
                //         style: BorderStyle.solid, color: Colors.grey),
                //   ),
                //   child: TextFormField(
                //     maxLines: null,
                //     decoration: const InputDecoration(
                //       enabledBorder: InputBorder.none,
                //       focusedBorder: InputBorder.none,
                //       hintText: "Enter Description of Results",
                //       hintStyle: TextStyle(fontSize: 18),
                //     ),
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return 'Enter Description of Results';
                //       }
                //       return null;
                //     },
                //     keyboardType: TextInputType.multiline,
                //   ),
                // ),
                const SizedBox(
                  height: 20,
                ),
                DottedBorder(
                  color: kPrimaryColor,
                  dashPattern: const [10, 15],
                  strokeWidth: 5,
                  child: Container(
                    width: double.infinity,
                    // height: 210,
                    color: kPrimaryLightColor,
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              if (fileName == null) ...{
                                const Text(
                                  'Please select file!',
                                  style: TextStyle(color: red),
                                ),
                              } else ...{
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.picture_as_pdf,
                                      color: kPrimaryColor,
                                      size: 20,
                                    ),
                                    Text(fileName,
                                        overflow: TextOverflow
                                            .ellipsis, // or TextOverflow.ellipsis
                                        // maxLines: null,
                                        style: const TextStyle(
                                            color: kPrimaryColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                    // Text('MIME: ${dropedfile!.mime}'),
                                    // Image.network(dropedfile!.Url),
                                  ],
                                ),
                              },
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              const Icon(
                                Icons.file_upload_outlined,
                                size: 100,
                                color: kPrimaryColor,
                              ),
                              // Text(
                              //   "Select Files",
                              //   style: TextStyle(
                              //       fontSize: 25,
                              //       fontWeight: FontWeight.bold,
                              //       color: kPrimaryColor),
                              // ),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton.icon(
                                  onPressed: selectFile,
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0, vertical: 15.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    // primary:
                                    //     Color.fromARGB(255, 176, 39, 39)
                                  ),
                                  label: const Text(
                                    "Browse File",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  icon: const Icon(Icons.search)),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // const SizedBox(
                //   height: 15,
                // ),
                // if (error == true) ...{
                //   const Text(
                //     'Please select file!',
                //     style: TextStyle(color: red),
                //   ),
                // },
                const SizedBox(
                  height: 55,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (file == null) {
                        // setState(() {
                        //   // error == true;
                        // });
                      } else {
                        setState(() {
                          // error == false;
                          subject = subjectController.text;
                          uploadFile();
                          // notice = noticeController.text;
                          // addnotice();
                        });
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 20.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    // primary:
                    //     Color.fromARGB(255, 176, 39, 39)
                  ),
                  child: const Text(
                    "Upload Result",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
