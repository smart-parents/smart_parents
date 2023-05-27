// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, use_build_context_synchronously

import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:smart_parents/components/change_password.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/pages/Admin/edit_a.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? em;
  final _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    main();
    login();
  }

  void main() async {
    final SharedPreferences prefs = await _prefs;
    em = prefs.getString('email');
  }

  void login() async {
    FirebaseAuth.instance.signOut();
    final SharedPreferences prefs = await _prefs;
    em = prefs.getString('email');
    String? pass = prefs.getString('pass');
    print("signout");
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: "$em", password: "$pass")
          .then(
            (value) => print("login $em"),
          );
      print("login");
      final doc =
          await FirebaseFirestore.instance.collection('Admin').doc(em).get();
      setState(() {
        _imageUrl = doc.data()!['photoUrl'];
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  bool _uploading = false;

  Uint8List? _imageFile;
  String? _imageUrl;

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _imageFile = bytes;
          uploadImage();
        });
        Navigator.pop(context);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _selectProfileImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> uploadImage() async {
    setState(() {
      _uploading = true;
    });
    if (_imageFile == null) {
      return;
    }
    final user = FirebaseAuth.instance.currentUser;
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('$admin/profile_photos/${user!.uid}.jpg');
    final UploadTask uploadTask = storageRef.putData(_imageFile!);

    final TaskSnapshot downloadUrl = await uploadTask.whenComplete(() => null);

    final url = (await downloadUrl.ref.getDownloadURL());
    await FirebaseFirestore.instance
        .collection('Admin')
        .doc(em)
        .update({'photoUrl': url});
    setState(() {
      _imageUrl = url;
      _uploading = false;
    });

    print('Image uploaded to Firebase Storage: $_imageUrl');
  }

  Widget _buildPhotoWidget() {
    if (_uploading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_imageUrl != null) {
      return
          // Stack(children: [
          GestureDetector(
        onTap: _selectProfileImage,
        child: ImageNetwork(
          image: _imageUrl!,
          height: 100,
          width: 100,
          fitAndroidIos: BoxFit.contain,
          fitWeb: BoxFitWeb.contain,
          onLoading: const CircularProgressIndicator(
            color: kPrimaryColor,
          ),
          onError: const Icon(
            Icons.error,
            color: red,
          ),
          onTap: _selectProfileImage,
        ),
      );

      // ]);
    } else {
      // return Stack(
      //   children: [
      return Image.asset('assets/images/man.png', fit: BoxFit.cover);
      // ],
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream:
          FirebaseFirestore.instance.collection('Admin').doc(em).snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasError) {
          print('Something Went Wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var data = snapshot.data!.data();
        var email = data!['email'];
        var name = data['name'];
        var mono = data['mono'];
        return ListView(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.only(top: 25),
                // width: 414.0,
                // height: MediaQuery.of(context).size.width * 590.0,
                // width: MediaQuery.of(context).size.width * 380.0,
                // color: Colors.blue[50],
                child: Column(
                  children: [
                    // const CircleAvatar(
                    //   radius: 40,
                    //   backgroundImage: AssetImage('assets/images/man.png'),
                    // ),
                    GestureDetector(
                      onTap: _selectProfileImage,
                      child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey, width: 2),
                          ),
                          child: Stack(
                            children: [
                              ClipOval(
                                child: _buildPhotoWidget(),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    const Text(
                      'Admin',
                      style: TextStyle(
                        fontSize: 30,
                        // color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    Container(
                      // height: 470.0,
                      // width: 365.0,
                      margin: const EdgeInsets.only(left: 25, right: 25),
                      height: MediaQuery.of(context).size.height * 0.55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: kPrimaryColor),
                      // alignment: Alignment(0.0, -0.9),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.maxFinite,
                            margin: const EdgeInsets.only(left: 15, top: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SizedBox(
                                //   height: 30,
                                // ),
                                // Text(
                                //   // alignment: Alignment(0.0, -0.8),
                                //   "Enrollment: $number",
                                //   //  ${snapshot['number']}",
                                //   // ignore: prefer_const_constructors
                                //   style: TextStyle(
                                //     fontSize: 20,
                                //     color: Color.fromARGB(255, 255, 255, 255),
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                Text(
                                  "Email: $email",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Name: $name",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Mobile: $mono",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                // Text(
                                //   "Branch: $branch",
                                //   style: TextStyle(
                                //     fontSize: 20,
                                //     color: Color.fromARGB(255, 255, 255, 255),
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                // Text(
                                //   "Batch: $batch",
                                //   style: TextStyle(
                                //     fontSize: 20,
                                //     color: Color.fromARGB(255, 255, 255, 255),
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                // Text(
                                //   "Semester: $sem",
                                //   style: TextStyle(
                                //     fontSize: 20,
                                //     color: Color.fromARGB(255, 255, 255, 255),
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                // Text(
                                //   "Year: $year",
                                //   style: TextStyle(
                                //     fontSize: 20,
                                //     color: Color.fromARGB(255, 255, 255, 255),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          // Align(
                          //   alignment: Alignment(0, 0),
                          // child:
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Positioned(
                              //   // width: double.infinity,
                              //   bottom: 0,
                              //   left: 0,
                              //   child:
                              Expanded(
                                child: TextButton.icon(
                                  onPressed: () async => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditA(
                                          id: "$em",
                                        ),
                                      ),
                                    ) // (route) => false)
                                  },
                                  icon: const Icon(
                                    Icons.info_outline,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    // 'Edit Profile',
                                    'Edit Details',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                ),
                              ),
                              // ),
                              // const SizedBox(
                              //   height: 5,
                              // ),
                              // Positioned(
                              //   // width: double.infinity,
                              //   bottom: 0,
                              //   right: 0,
                              //   child:
                              Expanded(
                                child: TextButton.icon(
                                  onPressed: () async => {
                                    // await FirebaseAuth.instance.signOut(),
                                    // delete(),
                                    // await storage.delete(key: "uid"),
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ChangePassword(),
                                      ),
                                    )
                                  },
                                  icon: const Icon(
                                    Icons.password,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    // 'Change Password',
                                    'Change Password',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
