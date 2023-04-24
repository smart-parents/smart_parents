// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_parents/components/constants.dart';

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
    // timer = Timer.periodic(const Duration(seconds: 5), (timer) {
    //   getLocationData();
    // });
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('College Admin Dashboard'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: const [
            UserAccountsDrawerHeader(
              accountName: Text('John Doe'),
              accountEmail: Text('johndoe@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://www.example.com/images/user_profile.png'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
            ),
          ],
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        children: [
          _buildCard('Manage Students', Icons.people, Colors.green),
          _buildCard('Manage Faculty', Icons.person, Colors.blue),
          _buildCard('Manage Courses', Icons.book, Colors.orange),
          _buildCard('Manage Assignments', Icons.assignment, Colors.purple),
        ],
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
        onTap: () {},
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
  // @override
  // Widget build(BuildContext context) {
  //   return Center(
  //     child: ElevatedButton(
  //         onPressed: getLocationData, child: const Text('Live Location')),
  //   );
  // }
}
