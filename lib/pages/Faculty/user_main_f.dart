import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:smart_parents/pages/Admin/profile_a.dart';
import 'package:smart_parents/pages/Faculty/dashboard_f.dart';

class UserMainF extends StatefulWidget {
  UserMainF({Key? key}) : super(key: key);
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
  // final storage = new FlutterSecureStorage();
  static List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    Text(
      'Index 2: schedule',
    ),
    Text(
      'Index 3: chat',
    ),
    Profile()
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
        // backgroundColor: Color.fromARGB(255, 207, 235, 255),
        // automaticallyImplyLeading: false,
        // title: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     // Image.asset("assets/images/top3.png", width: 100, height: 50,),

        //     const Text(
        //       "Faculty",
        //       style: TextStyle(
        //         fontSize: 30.0,
        //       ),
        //     ),
        //     Image.asset(
        //       "assets/images/Faculty.png",
        //       height: 50,
        //     ),
        //   ],
        // ),
        title: const Text('Home'),
        backgroundColor: Colors.blue.shade700,
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
              rippleColor: Color.fromARGB(255, 37, 86, 116),
              hoverColor: Color.fromARGB(255, 37, 86, 116),
              // gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              // tabMargin: EdgeInsets.symmetric(horizontal: 50),
              // duration: Duration(milliseconds: 400),
              tabBackgroundColor: Color.fromARGB(255, 37, 86, 116),
              color: Colors.black,
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

      // bottomNavigationBar: BottomNavyBar(
      //   backgroundColor: Color.fromARGB(255, 207, 235, 255),
      //   selectedIndex: _selectedIndex,
      //   showElevation: true,
      //   itemCornerRadius: 24,
      //   curve: Curves.easeIn,
      //   onItemSelected: _onItemTapped,
      //   items: <BottomNavyBarItem>[
      //     BottomNavyBarItem(
      //       icon: Icon(Icons.home),
      //       title: Text('Home'),
      //       activeColor: Color.fromARGB(255, 37, 86, 116),
      //       textAlign: TextAlign.center,
      //     ),
      //     BottomNavyBarItem(
      //       icon: Icon(Icons.person),
      //       title: Text('Profile'),
      //       activeColor: Color.fromARGB(255, 37, 86, 116),
      //       textAlign: TextAlign.center,
      //     ),
      //   ],
      // ),

      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Student Detail',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'My Profile',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: 'Change Password',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: const Color.fromARGB(255, 177, 217, 250),
      //   onTap: _onItemTapped,
      // ),
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
          // main(),
          // buildHeader(context),
          Material(
              color: Colors.blue.shade700,
              child: InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 24 + MediaQuery.of(context).padding.top,
                        bottom: 24),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/Photo/raj.png'),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'xyz',
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        ),
                        Text(
                          "$fid",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        )
                      ],
                    ),
                  ))),
          // buildMenuItems(context),
          Container(
            //padding: const EdgeInsets.all(15),
            child: Wrap(
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
                  leading: const Icon(Icons.paste),
                  title: const Text("View Your Child Result"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.money),
                  title: const Text("View Fees Details"),
                  onTap: () {},
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
          ),
        ],
      )),
    );
  }
  // Widget buildHeader(BuildContext contex) =>
  // Widget buildMenuItems(BuildContext contex) =>
}
