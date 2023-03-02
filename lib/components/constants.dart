// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';

class Constants {
  static String appId = "1:581206730087:web:e3d782874866d2ff8fbbc2";
  static String apiKey = "AIzaSyAOUD8giZV2XdhMM4XEwtCwzPdNeDbcY2w";
  static String messagingSenderId = "581206730087";
  static String projectId = "smart-parents-11c8b";
}

var admin;
var branch;
var sem;

const kPrimaryColor = Color(0xFF255674);
const kPrimaryLightColor = Color(0xFFCFEBFF);

const double defaultPadding = 10.0;
const kSendButtonTextStyle = TextStyle(
  color: kPrimaryColor,
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
    top: BorderSide(color: kPrimaryColor, width: 2.0),
  ),
);
