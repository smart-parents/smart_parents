// ignore_for_file: deprecated_member_use, constant_identifier_names, depend_on_referenced_packages, unused_field, use_build_context_synchronously

import 'dart:async';
// import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
// import 'package:smart_parents/components/internetcheck.dart';
import 'package:smart_parents/pages/TimeImage.dart';
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
            apiKey: "AIzaSyBugsA2pQS4H8JUQJyISJexDpTn-aM5qzM",
            authDomain: "smart-parents-97628.firebaseapp.com",
            projectId: "smart-parents-97628",
            storageBucket: "smart-parents-97628.appspot.com",
            messagingSenderId: "988559124743",
            appId: "1:988559124743:web:4be7ca32d3cafbb9bc3da2",
            measurementId: "G-PZYQCLET3P"));
  } else {
    await Firebase.initializeApp();
    OneSignal.shared.setAppId("26f997ff-1bb9-44a8-960f-97a39f8f489a");
    // Optional: Set other OneSignal parameters
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    // Optional: Prompt the user for push notification permission
    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _userProvidedPrivacyConsent = false;
  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
    } else {
      // InternetPopup().initialize(context: context);
      OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

      OneSignal.shared
          .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
        print('Notification opened');
      });

      OneSignal.shared
          .setInAppMessageClickedHandler((OSInAppMessageAction action) {
        print('In app message clicked');
      });

      checkPrivacyConsent();
      takeNotificationPermission();
      print('notification setup successfully');
    }
  }

  Future<void> checkPrivacyConsent() async {
    bool userProvidedPrivacyConsent =
        await OneSignal.shared.userProvidedPrivacyConsent();
    setState(() {
      _userProvidedPrivacyConsent = userProvidedPrivacyConsent;
    });
  }

  Future<void> requestPrivacyConsent() async {
    await OneSignal.shared.consentGranted(true);
    checkPrivacyConsent();
  }

  Future<void> takeNotificationPermission() async {
    // Check if the user has provided privacy consent
    bool userProvidedPrivacyConsent =
        await OneSignal.shared.userProvidedPrivacyConsent();
    if (!userProvidedPrivacyConsent) {
      //   showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return AlertDialog(
      //         title: const Text('Privacy Consent Required'),
      //         content: const Text(
      //             'Please provide privacy consent to receive notifications.'),
      //         actions: <Widget>[
      //           TextButton(
      //             child: const Text('OK'),
      //             onPressed: () {
      //               Navigator.of(context).pop();
      //             },
      //           ),
      //           TextButton(
      //             child: const Text('Grant Consent'),
      //             onPressed: () {
      requestPrivacyConsent();
      //             Navigator.of(context).pop();
      //           },
      //         ),
      //       ],
      //     );
      //   },
      // );
      return;
    }
  }

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
