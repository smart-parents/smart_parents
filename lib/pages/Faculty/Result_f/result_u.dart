// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/pages/Faculty/Result_f/DataModel.dart';
import 'package:smart_parents/widgest/dropDownWidget.dart';
import 'package:path/path.dart';

class DropAreaPage extends StatefulWidget {
  const DropAreaPage({super.key});

  @override
  State<DropAreaPage> createState() => _DropAreaPageState();
}

class _DropAreaPageState extends State<DropAreaPage> {
  DataModel? task;
  File? file;

  @override
  Widget build(BuildContext context) {
    final fileName =
        file != null ? basename(file!.path) : 'No File Selected Yet';
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Result'),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                dropdown(
                    DropdownValue: semesterdropdownValue,
                    sTring: Semester,
                    Hint: "Semester"),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  padding: const EdgeInsets.only(left: 15, bottom: 10),
                  margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        style: BorderStyle.solid, color: Colors.grey),
                  ),
                  child: TextFormField(
                    maxLines: null,
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Enter Description of Results",
                      hintStyle: TextStyle(fontSize: 18),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Description of Results';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                DottedBorder(
                  color: kPrimaryColor,
                  dashPattern: const [10, 15],
                  strokeWidth: 5,
                  child: Container(
                    height: 250,
                    color: kPrimaryLightColor,
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
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
                                        horizontal: 40.0, vertical: 20.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    // primary:
                                    //     Color.fromARGB(255, 176, 39, 39)
                                  ),
                                  label: const Text(
                                    "Browse File",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  icon: const Icon(Icons.search))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.picture_as_pdf,
                      size: 30,
                    ),
                    Text(fileName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    // Text('MIME: ${dropedfile!.mime}'),
                    // Image.network(dropedfile!.Url),
                  ],
                ),
                //Text('Size: ${filename!.size}'),
                const SizedBox(
                  height: 55,
                ),
                ElevatedButton(
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    //   setState(() {
                    //     subject = subjectController.text;
                    //     notice = noticeController.text;
                    //     addnotice();
                    //     Navigator.pop(context);
                    //   });
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
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
        ));
  }

  Future selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final path = result.files.single.path!;

      setState(() => file = File(path));
    }
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';
    print(fileName);
    print(destination);
    // FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    // final snapshot = await task!.(() => {});
    // final urlDownload = await snapshot.ref.getDownloadURL();

    // print('Download Link: $urlDownload');
  }
}
