// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:smart_parents/widgest/textfieldwidgetform.dart';

class Fees extends StatefulWidget {
  const Fees({Key? key}) : super(key: key);

  @override
  _FeesState createState() => _FeesState();
}

class _FeesState extends State<Fees> {
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: const Color.fromARGB(255, 123, 180, 204),
          leading: const BackButton(),
          title: const Text('Fees Notification')),
      body: SingleChildScrollView(
          child: Column(children: [
        const SizedBox(
          height: 15,
        ),
        const Text(
          'Students Details',
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        TextFieldWidgetForm(
          label: "Name",
          onChanged: (yuu) {},
          text: "",
        ),
        const SizedBox(
          height: 15,
        ),
        TextFieldWidgetForm(
          label: "Id",
          onChanged: (yuu) {},
          text: "",
        ),
        const SizedBox(
          height: 15,
        ),
        TextFieldWidgetForm(
          label: "Enrollment Number",
          onChanged: (yuu) {},
          text: "",
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: TextFieldWidgetForm(
                label: "Semester",
                onChanged: (yuu) {},
                text: "",
              ),
            ),
            Flexible(
              child: TextFieldWidgetForm(
                label: "Department",
                onChanged: (yuu) {},
                text: "",
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: TextFieldWidgetForm(
                label: "Stream",
                onChanged: (yuu) {},
                text: "",
              ),
            ),
            Flexible(
              child: TextFieldWidgetForm(
                label: "Year",
                onChanged: (yuu) {},
                text: "",
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        TextFieldWidgetForm(
          label: "Amount",
          onChanged: (yuu) {},
          text: "",
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () => {
                    // Navigator.of(context).pushAndRemoveUntil(
                    //   MaterialPageRoute(
                    //       builder: (context) => AdminNavScreen()),
                    //   (route) => false,
                    // ),
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    // backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                    minimumSize: const Size(150, 50),
                  ),
                  child: const Text(
                    'Fees payment',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return const Faculty();
                    //     },
                    //   ),
                    // )
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    // backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                    minimumSize: const Size(150, 50),
                  ),
                  child: const Text(
                    'Pay Fees Notification',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        )
      ])),
    );
  }
}
