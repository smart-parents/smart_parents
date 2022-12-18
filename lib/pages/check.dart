import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_parents/pages/option.dart';
import 'package:smart_parents/pages/user_main.dart';

class Check extends StatefulWidget {
  const Check({Key? key}) : super(key: key);

  // void initState() {
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
  //     // SystemUiOverlay.bottom,
  //   ]);
  // }

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final storage = new FlutterSecureStorage();

  Future<bool> checkLoginStatus() async {
    String? value = await storage.read(key: "uid");
    if (value == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //     future: _initialization,
    //     builder: (context, snapshot) {
    //       // Check for Errors
    //       if (snapshot.hasError) {
    //         print("Something Went Wrong");
    //       }
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return Center(child: CircularProgressIndicator());
    //       }
    return FutureBuilder(
        future: checkLoginStatus(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data == false) {
            return const Option();
          }
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Container(
          //       color: Colors.lightBlue,
          //       child: const Center(child: CircularProgressIndicator()));
          // }
          return UserMain();
        });
    // );
    // });
  }
}
