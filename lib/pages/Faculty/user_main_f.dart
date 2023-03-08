// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/pages/Faculty/Schedule/schedule_u.dart';
import 'package:smart_parents/pages/Faculty/Subject_f/subject.dart';
import 'package:smart_parents/pages/Faculty/dashboard_f.dart';
import 'package:smart_parents/pages/Faculty/profile_screen_f.dart';
import 'package:smart_parents/pages/Faculty/show_Stu/show1.dart';
import 'package:smart_parents/pages/Faculty/chat_f.dart';
import 'package:smart_parents/pages/Welcome/welcome_screen.dart';
import 'package:smart_parents/pages/Faculty/attendencepages/attendance_display_f.dart';
// import 'package:smart_parents/pages/Faculty/attendencepages/att.dart';

class UserMainF extends StatefulWidget {
  const UserMainF({Key? key}) : super(key: key);
  // void initState() {
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
  //     // SystemUiOverlay.bottom,
  //   ]);
  // }

  @override
  _UserMainState createState() => _UserMainState();
}

class _UserMainState extends State<UserMainF> {
  int _selectedIndex = 0;
  final _prefs = SharedPreferences.getInstance();
  @override
  void initState() {
    adminget();
    super.initState();
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
    print(admin);
    final snaphot = await FirebaseFirestore.instance
        .collection('Admin/$admin/faculty')
        .where('faculty', isEqualTo: pid)
        .get();
    if (snaphot.docs.isNotEmpty) {
      for (DocumentSnapshot<Map<String, dynamic>> doc in snaphot.docs) {
        branch = doc.get('branch');
      }
    }
    print(branch);
  }

  // final storage = new FlutterSecureStorage();
  static final List<Widget> _widgetOptions = <Widget>[
    const Dashboard(),
    const MyCarouselSlider(),
    const ChatScreen(),
    const ProfileF()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const WelcomeScreen()));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        drawer: const NavigationDrawer(),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: kPrimaryLightColor,
            // boxShadow: [
            //   BoxShadow(
            //     blurRadius: 20,
            //     // color: Colors.black.withOpacity(.1),
            //   )
            // ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                // rippleColor: kPrimaryColor ,
                // hoverColor: kPrimaryColor,
                // gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                // tabMargin: EdgeInsets.symmetric(horizontal: 50),
                // duration: Duration(milliseconds: 400),
                tabBackgroundColor: kPrimaryColor,
                // color: Colors.black,
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.schedule,
                    text: 'Schedule',
                  ),
                  GButton(
                    icon: Icons.chat,
                    text: 'Chat',
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
  }

  String? fid;
  main() {
    if (FirebaseAuth.instance.currentUser != null) {
      final email = FirebaseAuth.instance.currentUser!.email;
      String em = email.toString();
      String facid = em.substring(0, em.length - 8);
      fid = facid;
    }
  }

  // bool _uploading = false;
  String? _imageUrl;

  void _loadPhotoUrl() async {
    // final user = FirebaseAuth.instance.currentUser;
    final doc = await FirebaseFirestore.instance
        .collection('Admin/$admin/faculty')
        .doc(fid)
        .get();
    setState(() {
      _imageUrl = doc.data()!['photoUrl'];
    });
  }

  Widget _buildPhotoWidget() {
    if (_imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: _imageUrl!,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
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
          // main(),
          // buildHeader(context),
          Material(
            color: kPrimaryColor,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.only(
                    top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
                child: Column(
                  children: [
                    // Image.asset('assets/images/man.png', fit: BoxFit.cover),
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
                    const Text(
                      'xyz',
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                    Text(
                      "$fid",
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
          // buildMenuItems(context),
          Wrap(
            runSpacing: 10,
            children: [
              ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text("Home"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Dashboard(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text("Add Today's Attendence"),
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) => const AttendanceCalendarPage(
                  //     sub: 'PHP',
                  //     studentId: '206470316050',
                  //   ),
                  // ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.calendar_month),
                title: const Text("Attendence Report"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.person_2_outlined),
                title: const Text("Add Parents"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.schedule_outlined),
                title: const Text("View Attendance"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AttendanceDisplayPage(
                      // sub: 'PHP',
                      // studentId: '206470316050',
                    ),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.contact_page_outlined),
                title: const Text("Subjects"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Subject(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text("Show Student"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Show_stu(),
                  ));
                },
              ),
            ],
          ),
        ],
      )),
    );
  }
  // Widget buildHeader(BuildContext contex) =>
  // Widget buildMenuItems(BuildContext contex) =>
}
