import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  // get fid => null;
  final _prefs = SharedPreferences.getInstance();
  delete() async {
    final SharedPreferences prefs = await _prefs;
    final success = await prefs.clear();
    print(success);
  }

  // late Future<QuerySnapshot<Map<String, dynamic>>> snapshot;
  String? id;
  main() {
    if (FirebaseAuth.instance.currentUser != null) {
      String? email = FirebaseAuth.instance.currentUser!.email;
      String em = email.toString();
      String facid = em.substring(0, em.length - 8);
      id = facid;
      // snapshot = FirebaseFirestore.instance
      //     .collection('students')
      //     .where('number', isEqualTo: "$id")
      //     .get();
    }
  }

  @override
  Widget build(BuildContext context) {
    main();
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection('students').doc(id).get(),
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
          return Center(
            child: Container(
              // height: 590.0,
              padding: const EdgeInsets.only(top: 20),
              width: 414.0,
              color: Colors.blue[50],
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/man.png'),
                  ),
                  Text(
                    'Student',
                    style: TextStyle(
                      fontSize: 30,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Container(
                    height: 470.0,
                    width: 365.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Color.fromARGB(255, 37, 86, 116),
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
                              // SizedBox(
                              //   height: 30,
                              // ),
                              Text(
                                // alignment: Alignment(0.0, -0.8),
                                "Enrollment: $number",
                                //  ${snapshot['number']}",
                                // ignore: prefer_const_constructors
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Email: $email",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Name: $name",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Mobile: $mono",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Branch: $branch",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Batch: $batch",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Semester: $sem",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Year: $year",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Align(
                        //   alignment: Alignment(0, 0),
                        // child:
                        Container(
                          alignment: Alignment(0, 0),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton.icon(
                                onPressed: () async => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditS(
                                        id: "$id",
                                      ),
                                    ),
                                  ) // (route) => false)
                                },
                                icon: Icon(
                                  Icons.info_outline,
                                  color: Colors.white,
                                ),
                                label: Text(
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
                                icon: Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
