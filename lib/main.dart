// ignore_for_file: deprecated_member_use, constant_identifier_names, depend_on_referenced_packages, unused_field, use_build_context_synchronously

import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/pages/TimeImage.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  OneSignal.shared.setAppId("26f997ff-1bb9-44a8-960f-97a39f8f489a");
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  await OneSignal.shared
      .promptUserForPushNotificationPermission(fallbackToSettings: true);
  runApp(const MyApp());
}

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
      requestPrivacyConsent();
      return;
    }
  }

  ColorScheme primary = ColorScheme.fromSwatch(
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
  })).copyWith(background: Colors.white);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Parents',
      theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
            // prefixIconColor: Colors.grey[600],
            // suffixIconColor: Colors.grey[600],
            prefixIconColor: kPrimaryColor,
            suffixIconColor: kPrimaryColor,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
            ),
          ),
          // buttonTheme: ButtonThemeData(colorScheme: primary),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(primary.primary),
                foregroundColor: MaterialStatePropertyAll(primary.background)
                // textStyle: MaterialStatePropertyAll(
                //   TextStyle(color:primary.primary)
                // ),
                // foregroundColor: MaterialStatePropertyAll(primary.primary),
                ),
          ),
          appBarTheme: const AppBarTheme(
              backgroundColor: kPrimaryColor, foregroundColor: Colors.white),
          useMaterial3: true,
          colorScheme: primary),
      debugShowCheckedModeBanner: false,
      home: const MyCustomSplashScreen(),
    );
  }
}
