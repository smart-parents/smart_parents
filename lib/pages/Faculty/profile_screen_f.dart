// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_parents/pages/Faculty/edit_f.dart';
import 'package:smart_parents/pages/option.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  Widget build(BuildContext context) {
    // main();
    // login();
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection('faculty').doc(id).get(),
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
          var age = data['age'];
          if (dob != null) {
            Timestamp timestamp = snapshot.data!['dob'];
            DateTime dateTime = timestamp.toDate();
            dob = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
            List<String> dobParts = dob.split('-');
            int day = int.parse(dobParts[0]);
            int month = int.parse(dobParts[1]);
            int year = int.parse(dobParts[2]);

// Create a DateTime object with the DOB
            DateTime dobDateTime = DateTime(year, month, day);

// Calculate the age
            DateTime now = DateTime.now();
            Duration ageDuration = now.difference(dobDateTime);
            age = (ageDuration.inDays / 365).floor();

// Print the age
            print('Age: $age');
          }
          // var dob = data['dob'];
          return Center(
            child: Container(
              padding: const EdgeInsets.only(top: 4.5),
              // width: 414.0,
              height: MediaQuery.of(context).size.width * 590.0,
              width: MediaQuery.of(context).size.width * 380.0,
              color: Colors.blue[50],
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/man.png'),
                  ),
                  const Text(
                    'Faculty',
                    style: TextStyle(
                      fontSize: 30,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Container(
                    // height: 470.0,
                    // width: 365.0,
                    margin:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: const Color.fromARGB(255, 37, 86, 116),
                    ),
                    // alignment: Alignment(0.0, -0.9),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(left: 15, top: 20),
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
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
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
          );
        });
  }
}
