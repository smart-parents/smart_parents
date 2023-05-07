// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/pages/Student/Schedule/schedule_u.dart';

import 'package:smart_parents/pages/Student/attendance.dart';
import 'package:smart_parents/pages/Student/fees.dart';
import 'package:smart_parents/pages/Student/notice_s/notice_dash.dart';
import 'package:smart_parents/pages/Parents/exam_p/exam.dart';
import 'package:smart_parents/widgest/animation.dart';

Timer? timer;

class DashboardS extends StatefulWidget {
  const DashboardS({Key? key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<DashboardS> {
  @override
  void initState() {
    super.initState();
    // FlutterBackgroundService().startService();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      getLocationData();
    });
  }

  final _prefs = SharedPreferences.getInstance();

  getLocationData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      // Create a Location instance
      final SharedPreferences prefs = await _prefs;
      var id = prefs.getString('id');
      var role = prefs.getString('role');
      if (role == 'student') {
        Location location = Location();
        // location.enableBackgroundMode(enable: true);
        // Request the location permission if not granted
        await location.requestPermission();
        // Get the current location data
        LocationData locationData = await location.getLocation();
        // String? email = FirebaseAuth.instance.currentUser!.email;
        // String em = email.toString();
        // String id = em.substring(0, em.length - 8);
        // Use Firestore package to send data to Firestore
        final fireStore = FirebaseFirestore.instance;
        fireStore
            .collection('Admin/$admin/students/$id/location')
            .doc(id)
            .get()
            .then((value) => {
                  if (value.exists)
                    {
                      fireStore
                          .collection('Admin/$admin/students/$id/location')
                          .doc(id)
                          .update({
                        'latitude': locationData.latitude,
                        'longitude': locationData.longitude,
                        'timestamp': DateTime.now(),
                      })
                    }
                  else
                    {
                      fireStore
                          .collection('Admin/$admin/students/$id/location')
                          .doc(id)
                          .set({
                        'latitude': locationData.latitude,
                        'longitude': locationData.longitude,
                        'timestamp': DateTime.now(),
                      })
                    }
                });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.transparent,
        image: DecorationImage(
          image: AssetImage(background),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16.0),
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          children: [
            _buildCard('View Attendence', Icons.calendar_month, Colors.green),
            _buildCard('View Notice', Icons.notifications, Colors.blue),
            _buildCard('View Schedule', Icons.schedule, Colors.orange),
            _buildCard('View Exam', Icons.school, Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, IconData iconData, Color color) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
          switch (title) {
            case 'View Attendence':
              Navigator.push(
                  context, FadeAnimation(const AttendanceCalendarPage()));
              // Navigator.push(context, FadeAnimation(getLocation()));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const Student()),
              // );
              break;
            case 'View Notice':
              Navigator.push(context, FadeAnimation(const Notice()));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const Faculty()),
              // );
              break;
            case 'View Schedule':
              Navigator.push(context, FadeAnimation(const ShowSchedule()));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const Department()),
              // );
              break;
            case 'View Exam':
              Navigator.push(context, FadeAnimation(const Exam()));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const Notice()),
              // );
              break;
            case 'Manage Fees':
              Navigator.push(context, FadeAnimation(const Fees()));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const Fees()),
              // );
              break;
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: color,
              size: 64.0,
            ),
            const SizedBox(height: 16.0),
            Text(
              title,
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
