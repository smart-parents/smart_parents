// import 'dart:convert';
// import 'dart:js';
// import 'dart:math';
// import 'package:flutter/material.dart';

// initInfo(){
//   var androidInitialize = const AndroidInitializationSettings('@mipmap/ic_launcher');
//   var iosInitialize = const  IOSInitializationSettings();
//   var initializationSettings = InitializationSettings(android: androidInitialize, ios: iosInitialize);
//   fluttterLocalNotificationPlugin.initialize(initializationsSettings ,onSelectNotification:(String? payload) async{
//     try{
//       if(payload != null && payload.isNotEmpty){
//         Navigator.push(context,MaterialPageRoute(builder: (BuildContext context)
//         {
//           return NewPage(info:payload.toString());
//         }
//         ));

//       }else{
//       }
//       } catch(e){
//         return;
//       });
//    FirebaseMessaging.onMessage.listen((RemoteMessage message)
// //
// //
// // NOT Understable code
// //
// //
// )

// }

// void sendPushMessage(String token,String body , String title) async{
//   try{
//     await http.post(
//       Uri.parse('https://fcm.googleapis.com/fcm/send',
//       headers : <String,String>{
//        'Content-Type':'application/json',
//        'Authorization':"key=  write her keys"
//       },
//       body : jsonEncode(
//         <String,dynamic>
//         'prioity':'high',
//         'data': <String,dynamic>{
//           'click_action':'FLUTTER_NOTIFIFCATION_CLICK',
//           'sta

//           tus':'done',
//           'body':body,
//           'title':title,
//         },
//         "notification":  <String,dynamic>{

//           "title":title,
//           "body":body,
//               "android_channel_id":"dbfood"
//         },
//         "to":token,

//   },

// @override
// Widget build(BuildContext context){
//   return Scaffold(
//     body:center(
//        child: Column(
//       MainAxisAlignment : MainAxisAlignment.Center,
//       children:[
//         TextFormField(
//           controller: username,
//         ),
//         TextFormField(
//           controller: title,
//         ),
//         TextFormField(
//           controller: body,
//         ),
//         //
//         //
//         //here code is not finished.....
//         //

//       ]
//     )
//     )
//   );
// }
// }
