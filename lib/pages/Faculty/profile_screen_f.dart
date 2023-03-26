// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, unnecessary_null_comparison

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/pages/Faculty/edit_f.dart';
import 'package:smart_parents/pages/option.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileF extends StatefulWidget {
  const ProfileF({Key? key}) : super(key: key);

  @override
  _ProfileFState createState() => _ProfileFState();
}

class _ProfileFState extends State<ProfileF> {
  String? em;
  final _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    main();
    login();
    _loadPhotoUrl();
  }

  delete() async {
    final SharedPreferences prefs = await _prefs;
    final success = await prefs.clear();
    print(success);
  }

  String? id;
  main() {
    if (FirebaseAuth.instance.currentUser != null) {
      String? email = FirebaseAuth.instance.currentUser!.email;
      String ema = email.toString();
      String facid = ema.substring(0, ema.length - 8);
      id = facid;
      print(id);
    }
  }

  login() async {
    FirebaseAuth.instance.signOut();
    final SharedPreferences prefs = await _prefs;
    em = prefs.getString('faculty');
    print("em=$em");
    String? pass = prefs.getString('pass');
    print("signout");
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: "$em", password: "$pass")
          .then(
            (value) => print("login $em"),
          );
      print("login");
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  late File _imageFile;
  bool _uploading = false;
  String? _imageUrl;

  void _loadPhotoUrl() async {
    // final user = FirebaseAuth.instance.currentUser;
    final doc = await FirebaseFirestore.instance
        .collection('Admin/$admin/faculty')
        .doc(id)
        .get();
    setState(() {
      _imageUrl = doc.data()!['photoUrl'];
    });
  }

  Future _pickImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile!.path);
      _uploadImage();
    });
  }

  Future _uploadImage() async {
    setState(() {
      _uploading = true;
    });

    final user = FirebaseAuth.instance.currentUser;
    final ref =
        FirebaseStorage.instance.ref().child('profile_photos/${user!.uid}.jpg');
    final uploadTask = ref.putFile(_imageFile);
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();

    await FirebaseFirestore.instance
        .collection('Admin/$admin/faculty')
        .doc(id)
        .update({'photoUrl': downloadUrl});

    setState(() {
      _imageUrl = downloadUrl;
      _uploading = false;
    });
  }

  Widget _buildPhotoWidget() {
    if (_uploading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_imageUrl != null) {
      return GestureDetector(
        onTap: _pickImage,
        child:
            // CachedNetworkImage(
            //   imageUrl: _imageUrl!,
            //   placeholder: (context, url) => const CircularProgressIndicator(),
            //   errorWidget: (context, url, error) => const Icon(Icons.error),
            // ),

            //     FastCachedImage(
            //   url: _imageUrl!,
            //   // fit: BoxFit.cover,
            //   fadeInDuration: const Duration(seconds: 1),
            //   errorBuilder: (context, exception, stacktrace) {
            //     return Text(stacktrace.toString());
            //   },
            //   loadingBuilder: (context, progress) {
            //     debugPrint(
            //         'Progress: ${progress.isDownloading} ${progress.downloadedBytes} / ${progress.totalBytes}');
            //     return
            //         // Container(
            //         //   color: Colors.yellow,
            //         //   child:
            //         Stack(
            //       alignment: Alignment.center,
            //       children: [
            //         if (progress.isDownloading && progress.totalBytes != null)
            //           Text(
            //               '${progress.downloadedBytes ~/ 1024} / ${progress.totalBytes! ~/ 1024} kb',
            //               style: const TextStyle(color: kPrimaryColor)),
            //         SizedBox(
            //             // width: 120,
            //             // height: 120,
            //             child: CircularProgressIndicator(
            //                 color: kPrimaryColor,
            //                 value: progress.progressPercentage.value)),
            //       ],
            //       // ),
            //     );
            //   },
            // ),

            ImageNetwork(
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
          onTap: _pickImage,
        ),
      );
    } else {
      return Stack(
        children: [
          Image.asset('assets/images/man.png', fit: BoxFit.cover),
          // Positioned.fill(
          // child:
          //   child: Material(
          //     color: Colors.transparent,
          //     child: InkWell(
          //       onTap: _pickImage,
          //       child: Center(
          //         child: Text(
          //           _imageUrl != null
          //               ? 'Tap to update photo'
          //               : 'Tap to add photo',
          //           style: const TextStyle(
          //               color: Colors.white,
          //               fontSize: 16,
          //               fontWeight: FontWeight.bold),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection('Admin/$admin/faculty')
            .doc(id)
            .get(),
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
          var faculty = data!['faculty'];
          var email = data['email'];
          var name = data['name'];
          var mono = data['mono'];
          var dob = data['dob'];
          var branch = data['branch'];
          var age = data['age'];
          if (dob != null) {
            Timestamp timestamp = snapshot.data!['dob'];
            DateTime dateTime = timestamp.toDate();
            dob = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
            List<String> dobParts = dob.split('-');
            int day = int.parse(dobParts[0]);
            int month = int.parse(dobParts[1]);
            int year = int.parse(dobParts[2]);
            DateTime dobDateTime = DateTime(year, month, day);
            DateTime now = DateTime.now();
            Duration ageDuration = now.difference(dobDateTime);
            age = (ageDuration.inDays / 365).floor();
            print('Age: $age');
          }
          // var dob = data['dob'];
          return ListView(
            children: [
              Center(
                child: Container(
                  // padding: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.only(top: 25),
                  // height: MediaQuery.of(context).size.width * 590.0,
                  // width: MediaQuery.of(context).size.width * 380.0,
                  // color: kPrimaryLightColor,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey, width: 2),
                          ),
                          child: ClipOval(
                            child: _buildPhotoWidget(),
                          ),
                        ),
                      ),
                      // const CircleAvatar(
                      //   radius: 40,
                      //   backgroundImage: AssetImage('assets/images/man.png'),
                      // ),
                      const Text(
                        'Faculty',
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
                          color: kPrimaryColor,
                        ),
                        // alignment: Alignment(0.0, -0.9),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(left: 15, top: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
                                  Text(
                                    // alignment: Alignment(0.0, -0.8),
                                    "Faculty Id: $faculty",
                                    //  ${snapshot['number']}",
                                    // ignore: prefer_const_constructors
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "DOB: $dob",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Age: $age",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Branch: $branch",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
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
                                TextButton.icon(
                                  onPressed: () async => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditF(
                                          id: "$id",
                                        ),
                                      ),
                                    ) // (route) => false)
                                  },
                                  icon: const Icon(
                                    Icons.info_outline,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    'Edit Profile',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                ),
                                TextButton.icon(
                                  onPressed: () async => {
                                    await FirebaseAuth.instance.signOut(),
                                    delete(),
                                    // await storage.delete(key: "uid"),
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Option(),
                                        ),
                                        (route) => false)
                                  },
                                  icon: const Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    'Logout',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
