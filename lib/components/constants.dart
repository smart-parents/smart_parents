import 'package:flutter/material.dart';

class Constants {
  static String appId = "1:1088705041732:web:21b5aa5fdba3011ba27311";
  static String apiKey = "AIzaSyCr3zJj1nErI-2vKhNh1O-kRU1_QBQDeKE";
  static String messagingSenderId = "1088705041732";
  static String projectId = "smart-parents-df1cf";
}

const kPrimaryColor = Color(0xFF5BB8FC);
const kPrimaryLightColor = Color(0xFFF1E6FF);

const double defaultPadding = 10.0;
const kSendButtonTextStyle = TextStyle(
  color: Color.fromARGB(255, 37, 86, 116),
  // Color.fromARGB(255, 207, 235, 255),
  // Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  hintStyle: TextStyle(color: Colors.grey),
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Color.fromARGB(255, 37, 86, 116), width: 2.0),
  ),
);
