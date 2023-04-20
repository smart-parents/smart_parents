// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// class Constants {
//   static String appId = "1:581206730087:web:e3d782874866d2ff8fbbc2";
//   static String apiKey = "AIzaSyAOUD8giZV2XdhMM4XEwtCwzPdNeDbcY2w";
//   static String messagingSenderId = "581206730087";
//   static String projectId = "smart-parents-11c8b";
// }

var background = 'assets/images/background.jpg';

var admin;
var branch;
// var sem;
var batch;
var child;

const kPrimaryColor = Color(0xFF255674);
// const kPrimaryLightColor = Color.fromARGB(255, 184, 232, 255);
const kPrimaryLightColor = Color.fromARGB(255, 207, 235, 255);

const double defaultPadding = 10.0;
const kSendButtonTextStyle = TextStyle(
  color: kPrimaryColor,
  // Color.fromARGB(255, 207, 235, 255),
  // Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

InputDecoration kMessageTextFieldDecoration = InputDecoration(
  // fillColor: Colors.white,
  filled: true,
  fillColor: kPrimaryLightColor,
  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  hintStyle: TextStyle(color: Colors.grey[800]),
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  color: kPrimaryLightColor,
  border: Border(
    top: BorderSide(color: kPrimaryColor, width: 2.0),
  ),
);

// List<String> Semester = [
//   "1",
//   "2",
//   "3",
//   "4",
//   "5",
//   "6",
//   // "7",
//   // "8",
// ];
// List<String> Batch = ["A", "B", "C", "All"];
List<String> Days = [
  "Sunday",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday"
];
List<String> batchList =
    List.generate(100, (index) => (2001 + index).toString());
// List<String> CollegeYear = ["2020", "2021", "2022", "2023"];

// String semesterdropdownValue = Semester[0];
// String batchdropdownValue = Batch[0];
String daysdropdownValue = DateFormat('EEEE').format(DateTime.now());
String batchyeardropdownValue = DateFormat('yyyy').format(DateTime.now());
// Map<String, String> values = {
//   semesterdropdownValue: "1",
//   batchdropdownValue: "A",
//   daysdropdownValue: "Monday",
//   yeardropdownValue: "2023",
// };

const green = Color(0xff00CE2D);
const red = Color(0xffff0800);
