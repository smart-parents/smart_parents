// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages, prefer_typing_uninitialized_variables, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_parents/widgest/dropDownWidget.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  String? docId;
  void addnotice() {
    CollectionReference notices =
        FirebaseFirestore.instance.collection('Admin/$admin/Notices');
    docId = DateFormat('dd-MM-yyyy hh:mm:ss').format(DateTime.now());
    print(docId);
    notices
        .doc(docId)
        .set({
          'branch': Branch,
          'sem': semesterdropdownValue,
          'subject': subject,
          'notice': notice,
          'date': docId,
        })
        .then((value) => print('notice Added'))
        .catchError((error) => print('Failed to Add user: $error'));
    clearText();
  }

  // File? file;
  // ImagePicker image = ImagePicker();
  // String? url;
  // var name;

  // getfile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf', 'doc'],
  //   );
  //   if (result != null) {
  //     File c = File(result.files.single.path.toString());
  //     setState(() {
  //       file = c;
  //       name = result.names.toString();
  //     });
  //     uploadFile();
  //   }
  // }

  Uint8List? _imageFile;
  Future<void> pickImage() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        if (kIsWeb) {
          final bytes = await pickedFile.readAsBytes();
          setState(() {
            _imageFile = bytes;
            // uploadImage();
          });
        } else {
          final bytes = await pickedFile.readAsBytes();
          setState(() {
            _imageFile = bytes;
            // uploadImage();
          });
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> uploadImage() async {
    setState(() {});
    if (_imageFile == null) {
      return;
    }
    // final user = FirebaseAuth.instance.currentUser;
    final storageRef =
        FirebaseStorage.instance.ref().child('$admin/Notices/$docId.jpg');
    final UploadTask uploadTask = storageRef.putData(_imageFile!);
    final TaskSnapshot downloadUrl = await uploadTask.whenComplete(() => null);
    final url = (await downloadUrl.ref.getDownloadURL());
    await FirebaseFirestore.instance
        .collection('Admin/$admin/Notices')
        .doc(docId)
        .update({'photoUrl': url});
    print('Image uploaded to Firebase Storage: $url');
  }

  Widget _buildPhotoWidget() {
    if (_imageFile != null) {
      return Stack(
        children: [
          Image.memory(_imageFile!),
          Positioned(
            right: 0,
            top: 0,
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () {
                setState(() {
                  _imageFile = null;
                });
              },
              child: Icon(
                Icons.close,
                color: Colors.grey[100],
              ),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox(height: 0);
    }
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
              return ListView(children: [
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
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
                                  style: BorderStyle.solid, color: Colors.grey),
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
                              // height: 200,
                              padding:
                                  const EdgeInsets.fromLTRB(15, 10, 15, 10),
                              margin: const EdgeInsets.only(
                                  left: 20, top: 20, right: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    style: BorderStyle.solid,
                                    color: Colors.grey),
                              ),
                              child: Column(
                                children: [
                                  _buildPhotoWidget(),
                                  TextFormField(
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Enter notice",
                                      hintStyle: const TextStyle(fontSize: 18),
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.attach_file),
                                        onPressed: pickImage,
                                      ),
                                    ),
                                    controller: noticeController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter notice';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.multiline,
                                  ),
                                ],
                              )),
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
                                  uploadImage();
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
