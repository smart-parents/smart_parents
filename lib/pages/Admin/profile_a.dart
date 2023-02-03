// import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_parents/pages/option.dart';
// import 'dart:html' as html;

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;
  final storage = new FlutterSecureStorage();
  User? user = FirebaseAuth.instance.currentUser;
  // String ve = "Verify Email";

  verifyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      print('Verification Email has been sent');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.lightBlueAccent,
          content: Text(
            'Verification Email has been sent',
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'User ID: $uid',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Email: $email',
                style: TextStyle(fontSize: 18.0),
              ),
              // refresh(),
              user!.emailVerified
                  ? Text(
                      // '$ve',
                      'Verified',
                      style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                    )
                  : TextButton(
                      onPressed: () => {verifyEmail()},
                      // child: Text('$ve')),
                      child: Text('Verify Email')),
            ],
          ),
          Row(
            children: [
              Text(
                'Created: $creationTime',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () async => {
                  await FirebaseAuth.instance.signOut(),
                  await storage.delete(key: "uid"),
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Option(),
                      ),
                      (route) => false)
                },
                child: Text('Logout'),
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
              ),
            ],
          )
        ],
      ),
      // ),
    );
  }
}
