import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/pages/time_image.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e, s) {
    debugPrint('Firebase init error: $e');
    debugPrintStack(stackTrace: s);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final primary = ColorScheme.fromSwatch(
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
      }),
    ).copyWith(surface: Colors.white);
    return MaterialApp(
      title: 'Smart Parents',
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          prefixIconColor: kPrimaryColor,
          suffixIconColor: kPrimaryColor,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(primary.primary),
            foregroundColor: WidgetStatePropertyAll(primary.surface),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
        colorScheme: primary,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyCustomSplashScreen(),
    );
  }
}
