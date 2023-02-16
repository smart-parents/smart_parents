import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:smart_parents/pages/Admin/dashboard_a.dart';
// import 'package:smart_parents/pages/Admin/profile_a.dart';
// import 'package:smart_parents/pages/Admin/change_password_a.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:smart_parents/pages/Faculty/Chat/chatpage.dart';
import 'package:smart_parents/pages/Parents/attendance_screen.dart';
import 'package:smart_parents/pages/Student/dashboard_s.dart';
import 'package:smart_parents/pages/Student/profile_screen_s.dart';

class UserMainS extends StatefulWidget {
  UserMainS({Key? key}) : super(key: key);
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
  // final storage = new FlutterSecureStorage();
  static List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    Attendance_screen(),
    Chatpage(),
    Profile_screenS()
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
      drawer: NavigationDrawer(
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
    );
  }
}

class NavigationDrawer extends StatefulWidget {
  final String imagePath;
  NavigationDrawer({required this.imagePath});

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
                            backgroundImage:
                                AssetImage('assets/images/man.png'),
                            // backgroundImage: image.image,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Student',
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
                      }),
                  ListTile(
                    leading: const Icon(Icons.timelapse),
                    title: const Text("Classes Schedule"),
                    onTap: () {},
                  ),
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
                    title: const Text("Fee Details"),
                    onTap: () {},
                  ),
                  const Divider(color: Colors.black54),
                  ListTile(
                    leading: const Icon(Icons.contact_page_outlined),
                    title: const Text("contact With Faculty"),
                    onTap: () {},
                  ),
                ],
              ),
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
