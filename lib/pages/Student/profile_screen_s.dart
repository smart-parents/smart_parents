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

  String? id;
  main() {
    if (FirebaseAuth.instance.currentUser != null) {
      final email = FirebaseAuth.instance.currentUser!.email;
      String em = email.toString();
      String facid = em.substring(0, em.length - 8);
      id = facid;
    }
  }

  @override
  Widget build(BuildContext context) {
    main();
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
                          "User ID: $uid",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        Text(
                          // alignment: Alignment(0.0, -0.8),
                          "Enrollment: $id",
                          // ignore: prefer_const_constructors
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
                                builder: (context) =>  EditS(id: "$id",),
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
  }
}
