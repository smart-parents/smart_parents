import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_parents/pages/option.dart';

class Profile_screenP extends StatefulWidget {
  const Profile_screenP({super.key});

  @override
  State<Profile_screenP> createState() => _Profile_screenPState();
}

class _Profile_screenPState extends State<Profile_screenP> {
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
        height: 590.0,
        width: 414.0,
        color: Colors.blue[50],
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/man.png'),
            ),
            Text(
              'Parents',
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "User ID: $uid",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        Text(
                          // alignment: Alignment(0.0, -0.8),
                          "Mobile Number: $id",
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
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
                          tooltip: 'logout',
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255),
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
