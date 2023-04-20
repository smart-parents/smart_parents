// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:smart_parents/components/background.dart';
// import 'package:smart_parents/components/internetcheck.dart';
import 'package:smart_parents/components/responsive.dart';
import 'package:smart_parents/pages/Admin/Login_a/login_screen_a.dart';
import 'package:smart_parents/pages/Faculty/Login_f/login_screen_s.dart';
import 'package:smart_parents/pages/Parents/Login_p/login_screen_p.dart';
import 'package:smart_parents/pages/Student/Login_s/login_screen_s.dart';

class Option extends StatefulWidget {
  const Option({Key? key}) : super(key: key);

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  @override
  void initState() {
    // if (kIsWeb) {
    // } else {
    //   InternetPopup().initialize(context: context);
    // }
    // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    //     FlutterLocalNotificationsPlugin();
    // flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()!
    //     .requestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Background(
      child: SafeArea(
        child: Responsive(
          mobile: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Image.asset('assets/images/Admin.png'),
                        // iconSize: height,
                        iconSize: screenWidth * 0.4,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                      ),
                      const Text("Admin", style: TextStyle(fontSize: 20.0)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Image.asset('assets/images/Student.png'),
                        // iconSize: height,
                        iconSize: screenWidth * 0.4,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreenS()),
                          );
                        },
                      ),
                      const Text("Student", style: TextStyle(fontSize: 20.0)),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Image.asset('assets/images/Faculty.png'),
                        // iconSize: height,
                        iconSize: screenWidth * 0.4,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreenF()),
                          );
                        },
                      ),
                      const Text("Faculty", style: TextStyle(fontSize: 20.0)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Image.asset('assets/images/Parents.png'),
                        // iconSize: height,
                        iconSize: screenWidth * 0.4,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreenP()),
                          );
                        },
                      ),
                      const Text("Parents", style: TextStyle(fontSize: 20.0)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          desktop: const DesktopOption(),
        ),
        //   ],
      ),
    );
  }
}

class DesktopOption extends StatelessWidget {
  const DesktopOption({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double height = 250;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Image.asset('assets/images/Admin.png'),
              // iconSize: height,
              iconSize: screenWidth * 0.2,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
            const Text("Admin", style: TextStyle(fontSize: 20.0)),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Image.asset('assets/images/Faculty.png'),
              // iconSize: height,
              iconSize: screenWidth * 0.2,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreenF()),
                );
              },
            ),
            const Text("Faculty", style: TextStyle(fontSize: 20.0)),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Image.asset('assets/images/Student.png'),
              // iconSize: height,
              iconSize: screenWidth * 0.2,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreenS()),
                );
              },
            ),
            const Text("Student", style: TextStyle(fontSize: 20.0)),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Image.asset('assets/images/Parents.png'),
              // iconSize: height,
              iconSize: screenWidth * 0.2,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreenP()),
                );
              },
            ),
            const Text("Parents", style: TextStyle(fontSize: 20.0)),
          ],
        ),
      ],
    );
  }
}
