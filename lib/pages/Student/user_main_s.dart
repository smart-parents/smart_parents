import 'package:flutter/material.dart';
// import 'package:smart_parents/pages/Admin/dashboard_a.dart';
// import 'package:smart_parents/pages/Admin/profile_a.dart';
// import 'package:smart_parents/pages/Admin/change_password_a.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:smart_parents/pages/Admin/profile_a.dart';
import 'package:smart_parents/pages/Parents/attendance_screen.dart';
import 'package:smart_parents/pages/Student/dashboard_s.dart';

class UserMain extends StatefulWidget {
  UserMain({Key? key}) : super(key: key);
  // void initState() {
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
  //     // SystemUiOverlay.bottom,
  //   ]);
  // }

  @override
  _UserMainState createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  int _selectedIndex = 0;
  // final storage = new FlutterSecureStorage();
  static List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    Attendance_screen(),
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
    backgroundColor: Colors.blue.shade700,
    ),
    drawer: const NavigationDrawer(),
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
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
    child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        )),
  );
  Widget buildHeader(BuildContext contex) => Material(
      color: Colors.blue.shade700,
      child: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.only(
                top: 24 + MediaQuery.of(contex).padding.top, bottom: 24),
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/Photo/raj.png'),
                ),
                SizedBox(height: 10),
                Text(
                  'Raj Birari',
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
                Text(
                  'rajbirari@gmail.com',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                )
              ],
            ),
          )));
  Widget buildMenuItems(BuildContext contex) => Container(
    //padding: const EdgeInsets.all(15),
    child: Wrap(
      runSpacing: 10,
      children: [
        ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text("Home"),
            onTap: () {
              Navigator.of(contex).push(MaterialPageRoute(
                builder: (context) => const Dashboard(),
              ));
            }),
        ListTile(
          leading: const Icon(Icons.home_filled),
          title: const Text("Classes Schedule"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.calendar_month_rounded),
          title: const Text("See Attendence"),
          onTap: () {
            Navigator.of(contex).push(MaterialPageRoute(
              builder: (context) => const Attendance_screen(),
            ));
          },
        ),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text("Results"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text("Study Material"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text("Exam Info"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text("Fee Details"),
          onTap: () {},
        ),
        const Divider(color: Colors.black54),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text("contact With Faculty"),
          onTap: () {},
        ),
      ],
    ),
  );
}
