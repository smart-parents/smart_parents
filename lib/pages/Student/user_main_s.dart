// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:image_network/image_network.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/pages/Parents/attendance_screen.dart';
import 'package:smart_parents/pages/Student/Schedule/schedule_u.dart';
// import 'package:smart_parents/pages/Student/attendance_show.dart';
import 'package:smart_parents/pages/Student/attendance.dart';
import 'package:smart_parents/pages/Student/chat_s.dart';
import 'package:smart_parents/pages/Student/notice_s/notice_dash.dart';
import 'package:smart_parents/pages/Student/profile_screen_s.dart';
import 'package:smart_parents/pages/Welcome/welcome_screen.dart';

class UserMainS extends StatefulWidget {
  const UserMainS({Key? key}) : super(key: key);
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
    const Text("Dashboard"),
    const Attendance_screen(),
    const ChatScreen(),
    // DoubleBackToCloseApp(
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: const Text('My App'),
    //     ),
    //     body: const Center(
    //       child: Text('Hello, world!'),
    //     ),
    //   ),
    // ),
    const Profile_screenS()
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                  // rippleColor: const Color.fromARGB(255, 37, 86, 116),
                  // hoverColor: const Color.fromARGB(255, 37, 86, 116),
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
  // late Future<Image> _image;
  @override
  void initState() {
    super.initState();
    main();
    _loadPhotoUrl();
    // _image = _getImage();
    fetchName();
  }

  // Future<Image> _getImage() async {
  //   var storageReference =
  //       FirebaseStorage.instance.ref().child(widget.imagePath);
  //   var imageUrl = await storageReference.getDownloadURL();
  //   var image = NetworkImage(imageUrl);
  //   return Image(image: image);
  // }

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
        .collection('Admin/$admin/students')
        .doc(fid)
        .get();
    name = faculty.data()!['name'];
  }

  // bool _uploading = false;
  String? _imageUrl;

  void _loadPhotoUrl() async {
    // final user = FirebaseAuth.instance.currentUser;
    final doc = await FirebaseFirestore.instance
        .collection('Admin/$admin/students')
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
                          // const CircleAvatar(
                          //   radius: 40,
                          //   backgroundImage:
                          //       AssetImage('assets/images/man.png'),
                          //   // backgroundImage: image.image,
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
                            style: const TextStyle(
                                fontSize: 28, color: Colors.white),
                          ),
                          Text(
                            fid,
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
                      builder: (context) => const AttendanceCalendarPage(),
                    ));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.calendar_month_rounded),
                  title: const Text("See Schedule"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ShowSchedule(),
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
