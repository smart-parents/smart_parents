// ignore_for_file: camel_case_types, deprecated_member_use, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:smart_parents/components/change_password.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/pages/Parents/edit_p.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_parents/widgest/animation.dart';

class Profile_screenP extends StatefulWidget {
  const Profile_screenP({super.key});

  @override
  State<Profile_screenP> createState() => _Profile_screenPState();
}

class _Profile_screenPState extends State<Profile_screenP> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  String? email = FirebaseAuth.instance.currentUser!.email;
  // get fid => null;

  // late Future<QuerySnapshot<Map<String, dynamic>>> snapshot;
  String? id;
  main() {
    if (FirebaseAuth.instance.currentUser != null) {
      String? email = FirebaseAuth.instance.currentUser!.email;
      String em = email.toString();
      String facid = em.substring(0, em.length - 8);
      id = facid;
    }
  }

  @override
  void initState() {
    main();
    _loadPhotoUrl();
    super.initState();
  }

  bool _uploading = false;

  void _loadPhotoUrl() async {
    // final user = FirebaseAuth.instance.currentUser;
    final doc = await FirebaseFirestore.instance
        .collection('Admin/$admin/students')
        .doc(id)
        .get();
    if (doc.data() != null) {
      setState(() {
        _imageUrl = doc.data()!['photoUrl'];
      });
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
        .collection('Admin/$admin/parents')
        .doc(id)
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
        stream: FirebaseFirestore.instance
            .collection('Admin/$admin/parents')
            .doc(id)
            .snapshots(),
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
          var number = data!['number'];
          var name = data['name'];
          var email = data['email'];
          var dob = data['dob'];
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
          return ListView(
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.only(top: 25),
                  // width: 414.0,
                  // height: MediaQuery.of(context).size.height * 10.0,
                  // width: MediaQuery.of(context).size.width * 10.0,
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
                        'Parent',
                        style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Container(
                        // height: 470.0,
                        // width: 365.0,
                        margin: const EdgeInsets.only(left: 25, right: 25),
                        height: MediaQuery.of(context).size.height * 0.55,
                        // width: MediaQuery.of(context).size.width * 2.0,
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
                                  // SizedBox(
                                  //   height: 30,
                                  // ),
                                  Text(
                                    // alignment: Alignment(0.0, -0.8),
                                    "Mobile: $number",
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
                                    "Dob: $dob",
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
                                TextButton.icon(
                                  onPressed: () async => {
                                    Navigator.push(
                                        context,
                                        FadeAnimation(EditP(
                                          id: '$id',
                                        ))),
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => EditP(
                                    //       id: "$id",
                                    //     ),
                                    //   ),
                                    // ) // (route) => false)
                                  },
                                  icon: const Icon(
                                    Icons.info_outline,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                ),
                                // TextButton.icon(
                                //   onPressed: () async => {
                                //     await FirebaseAuth.instance.signOut(),
                                //     delete(),
                                //     // await storage.delete(key: "uid"),
                                //     Navigator.pushAndRemoveUntil(
                                //         context,
                                //         MaterialPageRoute(
                                //           builder: (context) => const Option(),
                                //         ),
                                //         (route) => false)
                                //   },
                                //   icon: const Icon(
                                //     Icons.logout,
                                //     color: Colors.white,
                                //   ),
                                //   label: const Text(
                                //     'Logout',
                                //     style: TextStyle(
                                //       fontSize: 20,
                                //       color: Color.fromARGB(255, 255, 255, 255),
                                //     ),
                                //   ),
                                // ),
                                TextButton.icon(
                                  onPressed: () async => {
                                    // await FirebaseAuth.instance.signOut(),
                                    // delete(),
                                    // await storage.delete(key: "uid"),
                                    Navigator.push(context,
                                        FadeAnimation(const ChangePassword())),
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         const ChangePassword(),
                                    //   ),
                                    // )
                                  },
                                  icon: const Icon(
                                    Icons.password,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    // 'Change Password',
                                    'Change',
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
