import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationA extends StatefulWidget {
  const NotificationA({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotificationAState createState() => _NotificationAState();
}

class _NotificationAState extends State<NotificationA> {
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Future<void> initState() async {
    super.initState();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    // var initializationSettingsAndroid =
    //     const AndroidInitializationSettings('assets/images/Final.png');
    // var initializationSettings =
    //     InitializationSettings(android: initializationSettingsAndroid);
    // flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     onDidReceiveBackgroundNotificationResponse:
    //         onSelectNotification('Smart Parents'));
  }

  onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Payload"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }

  Future<void> showNotification() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'channel id', 'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, 'title', 'body', platformChannelSpecifics, payload: 'item x');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Notification Example'),
        ),
        body: Center(
          child: TextButton(
            onPressed: () {
              showNotification();
            },
            child: const Text('Show Notification'),
          ),
        ),
      ),
    );
  }
}
