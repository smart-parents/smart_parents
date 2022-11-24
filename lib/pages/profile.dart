import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_parents/pages/Login/login_screen.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);
  // void initState() {
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
  //     // SystemUiOverlay.bottom,
  //   ]);
  // }

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;
  final storage = new FlutterSecureStorage();
  User? user = FirebaseAuth.instance.currentUser;

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
    // return Container(
    //   child: SingleChildScrollView(
    //     scrollDirection: Axis.vertical,
    //     child: Table(
    //       columnWidths: const <int, TableColumnWidth>{
    //         1: FixedColumnWidth(140),
    //       },
    //       defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    //       children: [
    //         TableRow(
    //           children: [
    //             TableCell(
    //               child: Container(
    //                 child: Center(
    //                   child: Text(
    //                     'Admin ID: $uid',
    //                     style: TextStyle(
    //                       fontSize: 20.0,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //         TableRow(
    //           children: [
    //             TableCell(
    //               child: Container(
    //                 child: Center(
    //                   child: Text(
    //                     'Email: $email',
    //                     style: TextStyle(
    //                       fontSize: 20.0,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //         TableRow(
    //           children: [
    //             TableCell(
    //               child: Container(
    //                 child: Center(
    //                   child: Text(
    //                     'Created: $creationTime',
    //                     style: TextStyle(
    //                       fontSize: 20.0,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
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
              user!.emailVerified
                  ? Text(
                      'verified',
                      style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                    )
                  : TextButton(
                      onPressed: () => {verifyEmail()},
                      child: Text('Verify Email'))
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
                        builder: (context) => LoginScreen(),
                      ),
                      (route) => false)
                },
                child: Text('Logout'),
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
              )
            ],
          )
        ],
      ),
    );
  }
}
