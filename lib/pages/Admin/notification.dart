// // import 'package:cloud_functions/cloud_functions.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';

// class Facultys {
//   final String name;
//   final String notice;

//   Facultys({required this.name, required this.notice});
// }

// class Students {
//   final String name;
//   final String token;

//   Students({required this.name, required this.token});
// }

// class NotificationA extends StatefulWidget {
//   @override
//   _NotificationAState createState() => _NotificationAState();
// }

// class _NotificationAState extends State<NotificationA> {
//   final List<Facultys> _faculties = [
//     Facultys(name: 'Faculty A', notice: 'Important notice 1'),
//     Facultys(name: 'Faculty B', notice: 'Important notice 2'),
//     Facultys(name: 'Faculty C', notice: 'Important notice 3'),
//   ];
//   String? tokens;
//   final List<Students> _students = [
//     Students(name: 'Student 1', token: 'tokens'),
//     Students(name: 'Student 2', token: 'DEVICE_TOKEN_2'),
//     Students(name: 'Student 3', token: 'DEVICE_TOKEN_3'),
//   ];

//   // final FirebaseMessaging _messaging = FirebaseMessaging.instance;

//   @override
//   void initState() {
//     super.initState();
//     FirebaseMessaging.instance.requestPermission();
//     getToken();
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print(
//           'Received notification: ${message.notification?.title} - ${message.notification?.body}');
//     });
//   }

//   Future<void> getToken() async {
//     String? token = await FirebaseMessaging.instance.getToken();
//     print('Token: $token');
//     setState(() {
//       tokens = token;
//     });
//   }

// // Send a notification to a student's device
//   Future<void> sendNotification(
//       String title, String body) async {
//     try {
//       await FirebaseMessaging.instance.sendMessage(data: {
//         'title': title,
//         'body': body,
//       }, to: tokens);
//     } catch (e) {
//       print('Failed to send notification:');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Faculty Notices'),
//         ),
//         body: ListView.builder(
//           itemCount: _faculties.length,
//           itemBuilder: (context, index) {
//             final faculty = _faculties[index];
//             return ListTile(
//               title: Text(faculty.name),
//               subtitle: Text(faculty.notice),
//               trailing: IconButton(
//                 icon: Icon(Icons.send),
//                 onPressed: () {
//                   for (final student in _students) {
//                     sendNotification(
//                         faculty.name, faculty.notice);
//                   }
//                 },
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// // void main() async {
// // // Initialize Firebase
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //   runApp(NotificationA());
// // }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// // class NotificationA extends StatefulWidget {
// //   const NotificationA({super.key});

// //   @override
// //   // ignore: library_private_types_in_public_api
// //   _NotificationAState createState() => _NotificationAState();
// // }

// // class _NotificationAState extends State<NotificationA> {
// //   // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// //   //     FlutterLocalNotificationsPlugin();

// //   AndroidNotificationChannel channel = const AndroidNotificationChannel(
// //     'high_importance_channel', // id
// //     'High Importance Notifications', // title
// //     description:
// //         'This channel is used for important notifications.', // description
// //     importance: Importance.max,
// //   );

// //   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// //       FlutterLocalNotificationsPlugin();

// //   @override
// //   Future<void> initState() async {
// //     super.initState();
// //     await flutterLocalNotificationsPlugin
// //         .resolvePlatformSpecificImplementation<
// //             AndroidFlutterLocalNotificationsPlugin>()
// //         ?.createNotificationChannel(channel);
// //     // var initializationSettingsAndroid =
// //     //     const AndroidInitializationSettings('assets/images/Final.png');
// //     // var initializationSettings =
// //     //     InitializationSettings(android: initializationSettingsAndroid);
// //     // flutterLocalNotificationsPlugin.initialize(initializationSettings,
// //     //     onDidReceiveBackgroundNotificationResponse:
// //     //         onSelectNotification('Smart Parents'));
// //   }

// //   onSelectNotification(String payload) async {
// //     showDialog(
// //       context: context,
// //       builder: (_) {
// //         return AlertDialog(
// //           title: const Text("Payload"),
// //           content: Text("Payload : $payload"),
// //         );
// //       },
// //     );
// //   }

// //   Future<void> showNotification() async {
// //     var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
// //         'channel id', 'channel name',
// //         channelDescription: 'channel description',
// //         importance: Importance.max,
// //         priority: Priority.high,
// //         ticker: 'ticker');
// //     var platformChannelSpecifics =
// //         NotificationDetails(android: androidPlatformChannelSpecifics);
// //     await flutterLocalNotificationsPlugin
// //         .show(0, 'title', 'body', platformChannelSpecifics, payload: 'item x');
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: const Text('Notification Example'),
// //         ),
// //         body: Center(
// //           child: TextButton(
// //             onPressed: () {
// //               showNotification();
// //             },
// //             child: const Text('Show Notification'),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // import 'dart:convert';
// // import 'package:http/http.dart' as http;

// // // Send a notification to a device using the FCM API
// // Future<void> sendNotification(String token, String title, String body) async {
// //   final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
// //   final headers = {
// //     'Content-Type': 'application/json',
// //     'Authorization': 'key=<YOUR_SERVER_KEY>',
// //   };
// //   final payload = {
// //     'to': token,
// //     'notification': {
// //       'title': title,
// //       'body': body,
// //       'click_action': 'FLUTTER_NOTIFICATION_CLICK',
// //     },
// //   };
// //   final response = await http.post(
// //     url,
// //     headers: headers,
// //     body: jsonEncode(payload),
// //   );
// //   if (response.statusCode != 200) {
// //     throw Exception('Failed to send notification: ${response.body}');
// //   }
// // }
