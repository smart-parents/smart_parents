import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smart_parents/pages/TimeImage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAOUD8giZV2XdhMM4XEwtCwzPdNeDbcY2w",
            authDomain: "smart-parents-11c8b.firebaseapp.com",
            projectId: "smart-parents-11c8b",
            storageBucket: "smart-parents-11c8b.appspot.com",
            messagingSenderId: "581206730087",
            appId: "1:581206730087:web:e3d782874866d2ff8fbbc2",
            measurementId: "G-90WR2B1GJL"));
  } else {
    await Firebase.initializeApp();
  }
  // await FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 15));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // CHeck for Errors
        if (snapshot.hasError) {
          if (kDebugMode) {
            print("Something went Wrong");
          }
        }
        // once Completed, show your application
        if (snapshot.connectionState == ConnectionState.done) {
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
            home: const TimeImage(),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
