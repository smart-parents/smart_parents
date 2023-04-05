// ignore_for_file: deprecated_member_use, constant_identifier_names, depend_on_referenced_packages

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_parents/pages/TimeImage1.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAOUD8giZV2XdhMM4XEwtCwzPdNeDbcY2w",
            authDomain: "smart-parents-11c8b.firebaseapp.com",
            projectId: "smart-parents-11c8b",
            storageBucket: "smart-parents-11c8b.appspot.com",
            messagingSenderId: "581206730087",
            appId: "1:581206730087:web:fd5055e4eac384a98fbbc2",
            measurementId: "G-9X7L4TQW98"));
  } else {
    await Firebase.initializeApp();
  }
  await initializeService();
  runApp(const MyApp());
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,
      // auto start service
      autoStart: false,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(),
  );
  // service.startService();
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (kDebugMode) {
      print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
    }
    // final deviceInfo = DeviceInfoPlugin();
    // String? device;
    // if (Platform.isAndroid) {
    //   final androidInfo = await deviceInfo.androidInfo;
    //   device = androidInfo.model;
    // }
    service.invoke(
      'update',
      {
        "current_date": DateTime.now().toIso8601String(),
        // "device": device,
      },
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   future: kIsWeb
    //       ? Firebase.initializeApp(
    //           options: const FirebaseOptions(
    //               apiKey: "AIzaSyAOUD8giZV2XdhMM4XEwtCwzPdNeDbcY2w",
    //               authDomain: "smart-parents-11c8b.firebaseapp.com",
    //               projectId: "smart-parents-11c8b",
    //               storageBucket: "smart-parents-11c8b.appspot.com",
    //               messagingSenderId: "581206730087",
    //               appId: "1:581206730087:web:fd5055e4eac384a98fbbc2",
    //               measurementId: "G-9X7L4TQW98"))
    //       : Firebase.initializeApp(),
    //   builder: (context, snapshot) {
    //     // Check for Errors
    //     if (snapshot.hasError) {
    //       if (kDebugMode) {
    //         print("Something went Wrong");
    //       }
    //     }
    //     // once Completed, show your application
    //     if (snapshot.connectionState == ConnectionState.done) {
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
    //     }
    //     return const CircularProgressIndicator();
    //   },
    // );
  }
}
