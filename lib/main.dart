// ignore_for_file: deprecated_member_use, constant_identifier_names, depend_on_referenced_packages, unused_field, use_build_context_synchronously

import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:smart_parents/pages/TimeImage.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  OneSignal.shared.setAppId("26f997ff-1bb9-44a8-960f-97a39f8f489a");
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  await OneSignal.shared
      .promptUserForPushNotificationPermission(fallbackToSettings: true);
  // await initializeService();

  runApp(const MyApp());
}

// final _prefs = SharedPreferences.getInstance();

// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//       onStart: onStart,
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
//     PermissionStatus permissionStatus = await location.hasPermission();
//     if (permissionStatus != PermissionStatus.granted) {
//       permissionStatus = await location.requestPermission();
//     } else {
//       if (FirebaseAuth.instance.currentUser != null) {
//         final SharedPreferences prefs = await _prefs;
//         var id = prefs.getString('id');
//         var role = prefs.getString('role');
//         if (role == 'student') {
//           location.enableBackgroundMode(enable: true);
//           await location.requestPermission();
//           LocationData locationData = await location.getLocation();
//           final fireStore = FirebaseFirestore.instance;
//           fireStore
//               .collection('Admin/$admin/students/$id/location')
//               .doc(id)
//               .get()
//               .then((value) => {
//                     if (value.exists)
//                       {
//                         fireStore
//                             .collection('Admin/$admin/students/$id/location')
//                             .doc(id)
//                             .update({
//                           'latitude': locationData.latitude,
//                           'longitude': locationData.longitude,
//                           'timestamp': DateTime.now(),
//                         })
//                       }
//                     else
//                       {
//                         fireStore
//                             .collection('Admin/$admin/students/$id/location')
//                             .doc(id)
//                             .set({
//                           'latitude': locationData.latitude,
//                           'longitude': locationData.longitude,
//                           'timestamp': DateTime.now(),
//                         })
//                       }
//                   });
//         }
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
