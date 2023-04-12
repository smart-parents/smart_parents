// ignore_for_file: deprecated_member_use, constant_identifier_names, depend_on_referenced_packages

import 'dart:async';
// import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_parents/pages/TimeImage1.dart';
// import 'package:http/http.dart' as http;
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:location/location.dart';
// import 'package:smart_parents/components/constants.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAOUD8giZV2XdhMM4XEwtCwzPdNeDbcY2w",
            authDomain: "smart-parents-11c8b.firebaseapp.com",
            databaseURL:
                "https://smart-parents-11c8b-default-rtdb.firebaseio.com",
            projectId: "smart-parents-11c8b",
            storageBucket: "smart-parents-11c8b.appspot.com",
            messagingSenderId: "581206730087",
            appId: "1:581206730087:web:fd5055e4eac384a98fbbc2",
            measurementId: "G-9X7L4TQW98"));
  } else {
    await Firebase.initializeApp();
  }
  // makeHttpGetRequest();
  // await initializeService();
  runApp(const MyApp());
}

// Future<void> makeHttpGetRequest() async {
//   final response = await http.get(
//     Uri.parse(
//         'https://smart-parents-11c8b-default-rtdb.firebaseio.com'), // Replace with your backend server URL
//     headers: {
//       'Content-Type': 'application/json', // Set appropriate Content-Type header
//       'Access-Control-Allow-Origin': '*', // Set appropriate CORS headers
//       'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
//       'Access-Control-Allow-Headers': 'Origin, Content-Type, X-Auth-Token',
//     },
//   );

//   // Handle response
//   print('Response status: ${response.statusCode}');
//   print('Response body: ${response.body}');
// }
// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//       // this will be executed when app is in foreground or background in separated isolate
//       onStart: onStart,
//       // auto start service
//       autoStart: false,
//       isForegroundMode: true,
//     ),
//     iosConfiguration: IosConfiguration(),
//   );
// }

// @pragma('vm:entry-point')
// void onStart(ServiceInstance service) async {
//   DartPluginRegistrant.ensureInitialized();
//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       service.setAsForegroundService();
//     });
//     service.on('setAsBackground').listen((event) {
//       service.setAsBackgroundService();
//     });
//   }
//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });
//   Timer.periodic(const Duration(seconds: 1), (timer) async {
//     print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
//     Location location = Location();
//     // location.serviceEnabled();
//     // location.requestService();
//     location.enableBackgroundMode(enable: true);
//     PermissionStatus permissionStatus = await location.hasPermission();
//     if (permissionStatus != PermissionStatus.granted) {
//       permissionStatus = await location.requestPermission();
//     } else {
//       LocationData locationData = await location.getLocation();
//       if (FirebaseAuth.instance.currentUser != null) {
//         String? email = FirebaseAuth.instance.currentUser!.email;
//         String em = email.toString();
//         String id = em.substring(0, em.length - 8);
//         final fireStore = FirebaseFirestore.instance;
//         fireStore
//             .collection('Admin/$admin/students/$id/location')
//             .doc(id)
//             .get()
//             .then((value) => {
//                   if (value.exists)
//                     {
//                       fireStore
//                           .collection('Admin/$admin/students/$id/location')
//                           .doc(id)
//                           .update({
//                         'latitude': locationData.latitude,
//                         'longitude': locationData.longitude,
//                         'timestamp': DateTime.now(),
//                       })
//                     }
//                   else
//                     {
//                       fireStore
//                           .collection('Admin/$admin/students/$id/location')
//                           .doc(id)
//                           .set({
//                         'latitude': locationData.latitude,
//                         'longitude': locationData.longitude,
//                         'timestamp': DateTime.now(),
//                       })
//                     }
//                 });
//       }
//     }
//   });
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Parents',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: const MaterialColor(0xFF255674, {
          50: Color(0xFFE5EDF5),
          100: Color(0xFFBFD3E2),
          200: Color(0xFF93B5CC),
          300: Color(0xFF6597B5),
          400: Color(0xFF417FA5),
          500: Color(0xFF1D678E),
          600: Color(0xFF195E84),
          700: Color(0xFF145473),
          800: Color(0xFF0F4E63),
          900: Color(0xFF083F4B),
        })).copyWith(background: Colors.white),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyCustomSplashScreen(),
    );
  }
}
