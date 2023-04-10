// ignore_for_file: camel_case_types, deprecated_member_use, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/pages/Student/edit_s.dart';
import 'package:smart_parents/pages/option.dart';

class Profile_screenS extends StatefulWidget {
  const Profile_screenS({super.key});

  @override
  State<Profile_screenS> createState() => _Profile_screenSState();
}

class _Profile_screenSState extends State<Profile_screenS> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  String? email = FirebaseAuth.instance.currentUser!.email;
  final _prefs = SharedPreferences.getInstance();
  delete() async {
    final SharedPreferences prefs = await _prefs;
    final success = await prefs.clear();
    print(success);
  }

  @override
  void initState() {
    main();
    _loadPhotoUrl();
    super.initState();
  }

  String? id;
  main() {
    if (FirebaseAuth.instance.currentUser != null) {
      String? email = FirebaseAuth.instance.currentUser!.email;
      String em = email.toString();
      id = em.substring(0, em.length - 8);
    }
  }

  bool _uploading = false;

  void _loadPhotoUrl() async {
    final doc = await FirebaseFirestore.instance
        .collection('Admin/$admin/students')
        .doc(id)
        .get();
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
        .collection('Admin/$admin/students')
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
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection('Admin/$admin/students')
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
          var number = data!['number'];
          var name = data['name'];
          var email = data['email'];
          var mono = data['mono'];
          var year = data['year'];
          var branch = data['branch'];
          var sem = data['sem'];
          var batch = data['batch'];
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
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    children: [
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
                        'Student',
                        style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 25, right: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: kPrimaryColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(left: 10, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Enrollment: $number",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 255, 255, 255),
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Batch: $batch",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Semester: $sem",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Year: $year",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton.icon(
                                  onPressed: () async => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditS(id: "$id")))
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
                                    // FlutterBackgroundService()
                                    //     .invoke("stopService"),
                                    delete(),
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
              )
            ],
          );
        });
  }
}
