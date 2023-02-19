import 'package:flutter/material.dart';
import 'package:smart_parents/pages/Faculty/user_main_f.dart';
import 'package:smart_parents/pages/Parents/user_main_p.dart';
import 'package:smart_parents/pages/Student/user_main_s.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_parents/pages/option.dart';
import 'package:smart_parents/pages/Admin/user_main_a.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Check extends StatefulWidget {
  const Check({Key? key}) : super(key: key);

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  // final storage = new FlutterSecureStorage();
  final _prefs = SharedPreferences.getInstance();
  String? role;

  Future<bool> checkLoginStatus() async {
    final SharedPreferences prefs = await _prefs;
    final String? action = prefs.getString('uid');
    // String? value = await storage.read(key: "uid");
    if (action == null) {
      return false;
    }
    return true;
  }

  roles() async {
    final SharedPreferences prefs = await _prefs;
    String? arole = prefs.getString('role');
    print(arole);
    if (arole == 'admin') {
      role = arole;
      print(role);
    }
    if (arole == 'faculty') {
      role = arole;
      print(role);
    }
    if (arole == 'student') {
      role = arole;
      print(role);
    }
    if (arole == 'parents') {
      role = arole;
      print(role);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkLoginStatus(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          roles();
          if (snapshot.data == false) {
            return const Option();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                color: Colors.lightBlue,
                child: const Center(child: CircularProgressIndicator()));
          }
          if (role == 'admin') {
            return const UserMainA();
          }
          if (role == 'faculty') {
            return const UserMainF();
          }
          if (role == 'student') {
            return const UserMainS();
          }
          if (role == 'parents') {
            return const ParentsScreen();
          }
          return const Option();
        });
  }
}
