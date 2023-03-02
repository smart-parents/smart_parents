// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/pages/Parents/attendance_screen.dart';
import 'package:smart_parents/pages/Student/chat_s.dart';
import 'package:smart_parents/pages/Student/dashboard_s.dart';
import 'package:smart_parents/pages/Student/notice_s/notice_dash.dart';
import 'package:smart_parents/pages/Student/profile_screen_s.dart';

class UserMainS extends StatefulWidget {
  const UserMainS({Key? key}) : super(key: key);
  // void initState() {
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
  //     // SystemUiOverlay.bottom,
  //   ]);
  // }

  @override
  _UserMainState createState() => _UserMainState();
}

class _UserMainState extends State<UserMainS> {
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
    final snaphot = await FirebaseFirestore.instance
        .collection('Admin/$admin/students')
        .where('number', isEqualTo: pid)
        .get();
    if (snaphot.docs.isNotEmpty) {
      for (DocumentSnapshot<Map<String, dynamic>> doc in snaphot.docs) {
        branch = doc.get('branch');
        sem = doc.get('sem');
      }
    }
    print(branch);
  }

  // final storage = new FlutterSecureStorage();
  static final List<Widget> _widgetOptions = <Widget>[
    const Dashboard(),
    const Attendance_screen(),
    const ChatScreen(),
    const Profile_screenS()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //   backgroundColor: Color.fromARGB(255, 207, 235, 255),
        //   automaticallyImplyLeading: false,
        //   title: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       // Image.asset("assets/images/top3.png", width: 100, height: 50,),
        //
        //       const Text(
        //         "Student",
        //         style: TextStyle(
        //           fontSize: 30.0,
        //         ),
        //       ),
        //       Image.asset(
        //         "assets/images/Student.png",
        //         height: 50,
        //       ),
        //     ],
        //   ),
        // ),
        title: const Text('Home'),
      ),
      drawer: const NavigationDrawer(
        imagePath: 'Jay Photo.jpg',
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 207, 235, 255),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              // rippleColor: const Color.fromARGB(255, 37, 86, 116),
              // hoverColor: const Color.fromARGB(255, 37, 86, 116),
              // gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                  icon: Icons.calendar_month_rounded,
                  text: 'Attendance',
                ),
                GButton(
                  icon: Icons.chat,
                  text: ' Chat',
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
    );
  }
}

class NavigationDrawer extends StatefulWidget {
  final String imagePath;
  const NavigationDrawer({super.key, required this.imagePath});

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  // NavigationDrawer({Key? key}) : super(key: key);
  // late Future<Image> _image;
  // @override
  // void initState() {
  //   super.initState();

  //   _image = _getImage();
  // }

  // Future<Image> _getImage() async {
  //   var storageReference =
  //       FirebaseStorage.instance.ref().child(widget.imagePath);
  //   var imageUrl = await storageReference.getDownloadURL();
  //   var image = NetworkImage(imageUrl);
  //   return Image(image: image);
  // }

  String? fid;
  main() {
    if (FirebaseAuth.instance.currentUser != null) {
      final email = FirebaseAuth.instance.currentUser!.email;
      String em = email.toString();
      String facid = em.substring(0, em.length - 8);
      fid = facid;
    }
  }

  @override
  Widget build(BuildContext context) {
    main();
    // return FutureBuilder(
    //     // future: _image,
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    // Image image = snapshot.data as Image;

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // buildHeader(context),
            Material(
                color: kPrimaryColor,
                child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 24 + MediaQuery.of(context).padding.top,
                          bottom: 24),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                AssetImage('assets/images/man.png'),
                            // backgroundImage: image.image,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Student',
                            style: TextStyle(fontSize: 28, color: Colors.white),
                          ),
                          Text(
                            "$fid",
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white),
                          )
                        ],
                      ),
                    ))),
            // buildMenuItems(context),
            Wrap(
              runSpacing: 10,
              children: [
                // ListTile(
                //     leading: const Icon(Icons.home_outlined),
                //     title: const Text("Home"),
                //     onTap: () {
                //       Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => const Dashboard(),
                //       ));
                //     }),
                // ListTile(
                //   leading: const Icon(Icons.timelapse),
                //   title: const Text("Classes Schedule"),
                //   onTap: () {},
                // ),
                ListTile(
                  leading: const Icon(Icons.calendar_month_rounded),
                  title: const Text("See Attendence"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Attendance_screen(),
                    ));
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.paste),
                  title: const Text("Results"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.pages_outlined),
                  title: const Text("Study Material"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.insert_drive_file_outlined),
                  title: const Text("Exam Info"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.money),
                  title: const Text("Notices"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Notice(),
                    ));
                  },
                ),
                const Divider(color: Colors.black54),
                ListTile(
                  leading: const Icon(Icons.contact_page_outlined),
                  title: const Text("contact With Faculty"),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
    // } else {
    //   return Container(
    //     height: 200.0,
    //     width: 200.0,
    //     child: CircularProgressIndicator(),
    //   );
    // }
    // }
    // );
  }
  // Widget buildHeader(BuildContext contex) =>
  // Widget buildMenuItems(BuildContext contex) =>
}
