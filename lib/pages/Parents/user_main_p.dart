// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, library_private_types_in_public_api, use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:image_network/image_network.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/pages/Parents/attendance_show.dart';
import 'package:smart_parents/pages/Parents/chat_parents_f.dart';
import 'package:smart_parents/pages/Parents/contact_faculty.dart';
import 'package:smart_parents/pages/Parents/dashboard_p.dart';
import 'package:smart_parents/pages/Parents/exam_p/exam.dart';
import 'package:smart_parents/pages/Parents/fees.dart';
import 'package:smart_parents/pages/Parents/livelocation.dart';
import 'package:smart_parents/pages/Parents/notice_p/notice_dash.dart';
import 'package:smart_parents/pages/Parents/profile_screen_p.dart';
import 'package:smart_parents/pages/Parents/result_p.dart';
import 'package:smart_parents/pages/option.dart';

class ParentsScreen extends StatefulWidget {
  const ParentsScreen({super.key});

  @override
  State<ParentsScreen> createState() => _ParentsScreenState();
}

class _ParentsScreenState extends State<ParentsScreen> {
  int _selectedIndex = 0;
  // final storage = new FlutterSecureStorage();
  final _prefs = SharedPreferences.getInstance();
  @override
  void initState() {
    super.initState();
    adminget();
    Timer(const Duration(seconds: 5), () {
      subscribeUserForNotifications();
    });
  }

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
        .collection('Admin/$admin/parents')
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
    // var child;
    final snaphot = await FirebaseFirestore.instance
        .collection('Admin/$admin/parents')
        .where('number', isEqualTo: pid)
        .get();
    if (snaphot.docs.isNotEmpty) {
      for (DocumentSnapshot<Map<String, dynamic>> doc in snaphot.docs) {
        branch = doc.get('branch');
        child = doc.get('child');
      }
    }
    print(child);
    final snahot = await FirebaseFirestore.instance
        .collection('Admin/$admin/students')
        .where('number', isEqualTo: child)
        .get();
    if (snahot.docs.isNotEmpty) {
      for (DocumentSnapshot<Map<String, dynamic>> doc in snahot.docs) {
        batch = doc.get('batch');
      }
    }
    print(batch);
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const Parents_home(),
    // const Attendance_screen(),
    // const Text(
    //   'Index 3: chat',
    // ),
    const Profile_screenP()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  delete() async {
    final SharedPreferences prefs = await _prefs;
    final success = await prefs.clear();
    print(success);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigator.of(context).push(
        //     MaterialPageRoute(builder: (context) => const WelcomeScreen()));
        // SystemNavigator.pop();
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return false;
      },
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage(background),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            //   backgroundColor: Color.fromARGB(255, 187, 218, 240),
            //   automaticallyImplyLeading: false,
            //   title: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       //Image.asset("assets/images/top3.png", width: 100, height: 50,),

            //       const Text(
            //         "Parents",
            //         style: TextStyle(
            //           fontSize: 30.0,
            //         ),
            //       ),
            //       Image.asset(
            //         "assets/images/Parents.png",
            //         height: 50,
            //       ),
            //     ],
            //   ),
            title: const Text('Home'),
            actions: [
              IconButton(
                onPressed: () async => {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm Logout"),
                        content: const Text("Are you sure you want to logout?"),
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
                              // Perform the deletion here
                              // ...
                              try {
                                await FirebaseAuth.instance.signOut();
                                delete();
                                await OneSignal.shared.removeExternalUserId();
                                // await storage.delete(key: "uid"),
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Option(),
                                    ),
                                    (route) => false);
                              } catch (e) {
                                print(e);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: kPrimaryLightColor,
                                      content: Text(
                                        'Failed to logout: $e',
                                        style: const TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black),
                                      )),
                                );
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
          ),
          drawer: const NavigationDrawer(),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
      ),
    );
  }
}

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({super.key});

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  // NavigationDrawer({Key? key}) : super(key: key);
  @override
  void initState() {
    super.initState();
    main();
    _loadPhotoUrl();
    // _image = _getImage();
    fetchName();
  }

  main() {
    if (FirebaseAuth.instance.currentUser != null) {
      final email = FirebaseAuth.instance.currentUser!.email;
      String em = email.toString();
      String facid = em.substring(0, em.length - 8);
      fid = facid;
    }
  }

  String fid = '';
  String name = '';
  fetchName() async {
    final faculty = await FirebaseFirestore.instance
        .collection('Admin/$admin/parents')
        .doc(fid)
        .get();
    name = faculty.data()!['name'];
  }

  // bool _uploading = false;
  String? _imageUrl;

  void _loadPhotoUrl() async {
    // final user = FirebaseAuth.instance.currentUser;
    final doc = await FirebaseFirestore.instance
        .collection('Admin/$admin/parents')
        .doc(fid)
        .get();
    setState(() {
      _imageUrl = doc.data()!['photoUrl'];
    });
  }

  Widget _buildPhotoWidget() {
    if (_imageUrl != null) {
      return ImageNetwork(
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
    main();
    return Drawer(
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // buildHeader(context),
          Material(
              color: kPrimaryColor,
              // child: InkWell(
              //     onTap: () {},
              child: Container(
                padding: EdgeInsets.only(
                    top: 20 + MediaQuery.of(context).padding.top, bottom: 20),
                child: Column(
                  children: [
                    // const CircleAvatar(
                    //   radius: 40,
                    //   backgroundImage: AssetImage('assets/images/man.png'),
                    // ),
                    Container(
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
                    const SizedBox(height: 10),
                    Text(
                      name,
                      style: const TextStyle(fontSize: 28, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      fid,
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    )
                  ],
                ),
              )),
          // buildMenuItems(context),
          Wrap(
            // runSpacing: 10,
            children: [
              ListTile(
                leading: const Icon(Icons.chat),
                title: const Text("Chat with Faculty"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ChatParent(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: const Text("Contact Faculty"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ContactF(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text("Get Your Child Location"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ChildLocation(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.calendar_month),
                title: const Text("View Attendances"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AttendanceCalendarPage(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.assignment),
                title: const Text("View Results"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Result(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.school),
                title: const Text("View Exams"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Exam(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.money),
                title: const Text("View Fees"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Fees(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text("View Notices"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Notice(),
                  ));
                },
              ),
            ],
          ),
        ],
      )),
    );
    // Widget buildHeader(BuildContext contex) =>
    // Widget buildMenuItems(BuildContext contex) =>
  }
}
