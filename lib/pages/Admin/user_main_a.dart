// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_parents/components/constants.dart';
// import 'package:smart_parents/components/internetcheck.dart';
import 'package:smart_parents/pages/Admin/dashboard_a.dart';
import 'package:smart_parents/pages/Admin/profile_a.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:smart_parents/pages/option.dart';

class UserMainA extends StatefulWidget {
  const UserMainA({Key? key}) : super(key: key);
  @override
  _UserMainState createState() => _UserMainState();
}

class _UserMainState extends State<UserMainA> {
  int _selectedIndex = 0;
  final _prefs = SharedPreferences.getInstance();
  @override
  void initState() {
    super.initState();
    adminget();
    Timer(const Duration(seconds: 5), () {
      subscribeUserForNotifications();
    });
    // if (kIsWeb) {
    // } else {
    //   InternetPopup().initialize(context: context);
    // }
  }

  bool _isLoading = false;

  Future<void> subscribeUserForNotifications() async {
    final SharedPreferences prefs = await _prefs;
    var id = prefs.getString('id');
    // Check if the user has provided privacy consent
    bool userProvidedPrivacyConsent =
        await OneSignal.shared.userProvidedPrivacyConsent();
    if (!userProvidedPrivacyConsent) {
      print(
          "User has not provided privacy consent yet. Cannot subscribe for notifications.");
      return;
    }
    // Prompt the user to enable notifications
    await OneSignal.shared.promptUserForPushNotificationPermission();

    // Retrieve the user's device token
    String deviceToken = await OneSignal.shared
        .getDeviceState()
        .then((deviceState) => deviceState!.userId!);

    // Subscribe the user to notifications
    await FirebaseFirestore.instance
        .collection('Admin')
        .doc(id)
        .set({'notification_token': deviceToken}, SetOptions(merge: true));
  }

  adminget() async {
    final SharedPreferences prefs = await _prefs;
    var pid = prefs.getString('id');
    final snapShot = await FirebaseFirestore.instance
        .collection('Users')
        .where('id', isEqualTo: pid)
        .get();
    if (snapShot.docs.isNotEmpty) {
      for (DocumentSnapshot<Map<String, dynamic>> doc in snapShot.docs) {
        admin = doc.get('admin');
      }
    }
  }

  // final storage = new FlutterSecureStorage();
  static final List<Widget> _widgetOptions = <Widget>[
    const Dashboard(),
    const Profile(),
    // const ChangePassword(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   login();
  // }

  // final _prefs = SharedPreferences.getInstance();
  // login() async {
  //   FirebaseAuth.instance.signOut();
  //   final SharedPreferences prefs = await _prefs;
  //   String? email = prefs.getString('email');
  //   String? pass = prefs.getString('pass');
  //   print("signout");
  //   try {
  //     FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: "$email", password: "$pass")
  //         .then(
  //           (value) => print("login $email"),
  //         );
  //     print("login");
  //   } on FirebaseAuthException catch (e) {
  //     print(e);
  //   }
  // }
  delete() async {
    final SharedPreferences prefs = await _prefs;
    final success = await prefs.clear();
    print(success);
  }

  @override
  Widget build(BuildContext context) {
    // login();
    return WillPopScope(
        onWillPop: () async {
          // Navigator.of(context).push(
          //     MaterialPageRoute(builder: (context) => const WelcomeScreen()));
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          return false;
        },
        child: AbsorbPointer(
            absorbing: _isLoading,
            child: Stack(children: [
              if (_isLoading)
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              Container(
                decoration: BoxDecoration(
                  // color: Colors.transparent,
                  image: DecorationImage(
                    image: AssetImage(background),
                    fit: BoxFit.cover,
                  ),
                ),
                // child: InternetConnectionDialog(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    // backgroundColor: Colors.transparent,
                    // backgroundColor: const Color.fromARGB(255, 207, 235, 255),
                    automaticallyImplyLeading: false,
                    title:
                        //  Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        // Image.asset("assets/images/top3.png", width: 100, height: 50,),
                        const Text(
                      "Admin",
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () async => {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirm Logout"),
                                content: const Text(
                                    "Are you sure you want to logout?"),
                                actions: [
                                  TextButton(
                                    child: const Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text("Logout"),
                                    onPressed: () async {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      // Perform the deletion here
                                      // ...
                                      try {
                                        await FirebaseAuth.instance.signOut();
                                        delete();
                                        await OneSignal.shared
                                            .removeExternalUserId();
                                        // await storage.delete(key: "uid"),
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const Option(),
                                            ),
                                            (route) => false);
                                      } catch (e) {
                                        print(e);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              backgroundColor:
                                                  kPrimaryLightColor,
                                              content: Text(
                                                'Failed to logout: $e',
                                                style: const TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.black),
                                              )),
                                        );
                                      } finally {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          )
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                      ),
                    ],
                    // Image.asset(
                    //   "assets/images/Admin.png",
                    //   height: 50,
                    // ),
                    // ElevatedButton(
                    //   onPressed: () async => {
                    //     await FirebaseAuth.instance.signOut(),
                    //     await storage.delete(key: "uid"),
                    //     Navigator.pushAndRemoveUntil(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => LoginScreen(),
                    //         ),
                    //         (route) => false)
                    //   },
                    //   child: Text('Logout'),
                    //   style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                    // )
                    //   ],
                    // ),
                  ),
                  body: _widgetOptions.elementAt(_selectedIndex),
                  bottomNavigationBar: Container(
                    decoration: const BoxDecoration(
                      color: kPrimaryLightColor,
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: GNav(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          activeColor: Colors.white,
                          iconSize: 24,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          tabBackgroundColor: kPrimaryColor,
                          tabs: const [
                            GButton(
                              icon: Icons.home,
                              text: 'Home',
                            ),
                            GButton(
                              icon: Icons.account_circle,
                              text: 'Profile',
                            ),
                          ],
                          selectedIndex: _selectedIndex,
                          onTabChange: _onItemTapped,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ])));
  }
}
