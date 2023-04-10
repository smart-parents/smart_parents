// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/pages/Admin/edit_a.dart';
import 'package:smart_parents/pages/option.dart';
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
    login();
    main();
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
      id = email.toString();
    }
  }

  login() async {
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
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  bool _uploading = false;

  void _loadPhotoUrl() async {
    // final user = FirebaseAuth.instance.currentUser;
    final doc =
        await FirebaseFirestore.instance.collection('Admin').doc(id).get();
    setState(() {
      _imageUrl = doc.data()!['photoUrl'];
    });
  }

  Uint8List? _imageFile;
  String? _imageUrl;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        if (kIsWeb) {
          final bytes = await pickedFile.readAsBytes();
          setState(() {
            _imageFile = bytes;
            uploadImage();
          });
        } else {
          final bytes = await pickedFile.readAsBytes();
          setState(() {
            _imageFile = bytes;
            uploadImage();
          });
        }
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
        .collection('Admin')
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
      return GestureDetector(
        onTap: pickImage,
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
          onTap: pickImage,
        ),
      );
    } else {
      return Stack(
        children: [
          Image.asset('assets/images/man.png', fit: BoxFit.cover),
          // Positioned.fill(
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
      future: FirebaseFirestore.instance.collection('Admin').doc(id).get(),
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
                      onTap: pickImage,
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
                        children: <Widget>[
                          Container(
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
                              TextButton.icon(
                                onPressed: () async => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditA(
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
