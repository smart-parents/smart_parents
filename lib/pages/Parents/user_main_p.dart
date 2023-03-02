// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/pages/Parents/attendance_screen.dart';
import 'package:smart_parents/pages/Parents/notice_p/notice_dash.dart';
import 'package:smart_parents/pages/Parents/parents_home.dart';
import 'package:smart_parents/pages/Parents/profile_screen_p.dart';

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
    var child;
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
    print(branch);
    final snahot = await FirebaseFirestore.instance
        .collection('Admin/$admin/students')
        .where('number', isEqualTo: child)
        .get();
    if (snahot.docs.isNotEmpty) {
      for (DocumentSnapshot<Map<String, dynamic>> doc in snahot.docs) {
        sem = doc.get('sem');
      }
    }
    print(sem);
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const Parents_home(),
    const Attendance_screen(),
    const Text(
      'Index 3: chat',
    ),
    const Profile_screenP()
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
      ),
      drawer: NavigationDrawer(),
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
              activeColor: Colors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({Key? key}) : super(key: key);
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
                          backgroundImage: AssetImage('assets/images/man.png'),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Parents',
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
              //   leading: const Icon(Icons.home_outlined),
              //   title: const Text("Home"),
              //   onTap: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //       builder: (context) => const Parents_home(),
              //     ));
              //   },
              // ),
              ListTile(
                leading: const Icon(Icons.paste),
                title: const Text("View Your Child Result"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.money),
                title: const Text("Notice"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Notice(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.insert_drive_file_outlined),
                title: const Text("View Exam Info"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: const Text("Get Your Child Location"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.contact_page_outlined),
                title: const Text("Contact Faculty"),
                onTap: () {},
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
